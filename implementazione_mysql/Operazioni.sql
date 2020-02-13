SET GLOBAL event_scheduler = ON;

/*-------------------------------------------------------------OK

/*Operazione 1: Controllo qualità del pasto
Descrizione:Viene controllato che il pasto che viene somministrato agli animali
	non abbia ripercussioni sul loro stato di salute: in particolare vengono 
    controllati gli indici di salute di tutti gli animali appartenenti ai locali
    nei quali è stato somministrato il pasto in esame
Input:composizione del pasto
Output:media degli indici di salute
Frequenza giornaliera:33
*/


DROP TRIGGER IF EXISTS cambio_pasto;
DELIMITER $$
CREATE TRIGGER cambio_pasto
BEFORE INSERT ON PastoPerLocale
FOR EACH ROW 
BEGIN 
	SET @fibre = 0;
    SET @proteine = 0;
    SET @glucidi = 0;
    SET @concentrazioneSali = 0;
    SET @concentrazioneVitamine = 0;
	SELECT PPL.fibre, PPL.proteine, PPL.glucidi, PPL.concentrazioneSali, PPL.concentrazioneVitamine
		INTO @fibre, @proteine, @glucidi, @concentrazioneSali, @concentrazioneVitamine
	FROM PastoPerLocale PPL
	WHERE PPL.codLocale = NEW.codLocale
	AND PPL.giorno_orario = (SELECT MAX(PPL1.giorno_orario)
							FROM PastoPerLocale PPL1
							WHERE PPL.codLocale = NEW.codLocale) ;
	CALL OP1_controllo_qualita_pasto(@fibre, @proteine, @glucidi, @concentrazioneSali, @concentrazioneVitamine);
END $$
DELIMITER ;


 
DROP FUNCTION IF EXISTS prima_somministrazione;
DELIMITER $$
CREATE FUNCTION prima_somministrazione(
	/*il pasto*/
    _fibre INT UNSIGNED,
	_proteine INT UNSIGNED,
	_glucidi INT UNSIGNED,
	_concentrazioneSali	TINYINT UNSIGNED,
	_concentrazioneVitamine	TINYINT UNSIGNED,
    /*il locale*/
    _codiceLocale	SMALLINT
) 
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE return_value TIMESTAMP;
    SELECT MIN(PPL.giorno_orario)
			FROM PastoPerLocale PPL
            WHERE PPL.fibre = _fibre
				AND PPL.proteine = _proteine
                AND PPL.glucidi = _glucidi
                AND PPL.concentrazioneSali = _concentrazioneSali
                AND PPL.concentrazioneVitamine = _concentrazioneVitamine
                AND PPL.codLocale = _codiceLocale
			LIMIT 1
            INTO return_value;
            
	IF return_value IS NOT NULL THEN
		RETURN(DATE_FORMAT(return_value, '%Y-%m-%d'));
	ELSE
		RETURN(NULL);
	END IF;

END$$
DELIMITER ;

DROP TABLE IF EXISTS log_qualita_pasto;
CREATE TABLE log_qualita_pasto
(
	fibre INT UNSIGNED,
    proteine INT UNSIGNED,
    glucidi INT UNSIGNED,
    sali TINYINT UNSIGNED,
    vitamine TINYINT UNSIGNED,
    media_respirazione SMALLINT UNSIGNED,
    media_deambulazione SMALLINT UNSIGNED,
    media_idratazione SMALLINT UNSIGNED,
    media_vigilanza SMALLINT UNSIGNED,
    media_lucentezza_pelo SMALLINT UNSIGNED,
	primary key (fibre, proteine, glucidi, sali, vitamine)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP PROCEDURE IF EXISTS OP1_controllo_qualita_pasto;
DELIMITER $$
CREATE PROCEDURE OP1_controllo_qualita_pasto
	(IN _fibre INT UNSIGNED,
	IN _proteine INT UNSIGNED,
	IN _glucidi INT UNSIGNED,
	IN _concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	IN _concentrazioneVitamine	TINYINT UNSIGNED)
BEGIN
	IF _fibre IS NOT NULL 
		AND _proteine IS NOT NULL 
		AND _glucidi IS NOT NULL 
		AND _concentrazioneSali IS NOT NULL 
		AND _concentrazioneVitamine IS NOT NULL THEN
        
		/*Considera la media di tutti gli indici di salute rilevati dopo la prima sommisitrazione del pasto in ogni locale*/
		 REPLACE INTO log_qualita_pasto
         SELECT 
			_proteine AS proteine,
            _glucidi AS glucidi,
            _concentrazioneSali AS concentrazioneSali,
            _concentrazioneVitamine AS concentrazioneVitamine,
            L.codiceLocale AS Locale, 
			AVG(I.tipologiaRespirazione) AS tipologiaRespirazione, 
			AVG(I.deambulazione) AS deambulazione, 
			AVG(I.idratazione) AS idratazione, 
			AVG(I.vigilanza) AS vigilanza, 
			AVG(I.lucentezzaPelo) AS lucentezzaPelo
		 FROM Locale L INNER JOIN Animale A ON L.codiceLocale = A.codLocale
						INNER JOIN IndiciSalute I ON A.codice = I.codAnimale
		 WHERE L.codiceLocale IN (SELECT DISTINCT(PPL.codlocale)
									FROM PastoPerLocale PPL
									WHERE PPL.fibre = _fibre
										AND PPL.proteine = _proteine
										AND PPL.glucidi = _glucidi
										AND PPL.concentrazioneSali = _concentrazioneSali
										AND PPL.concentrazioneVitamine = _concentrazioneVitamine)
			AND IF(prima_somministrazione(_fibre,
											_proteine, 
											_glucidi, 
											_concentrazioneSali, 
											_concentrazioneVitamine, 
											L.codiceLocale) IS NOT NULL,
					I.dataRilevazione > prima_somministrazione(_fibre, 
																_proteine, 
																_glucidi, 
																_concentrazioneSali, 
																_concentrazioneVitamine, 
																L.codiceLocale),
					0)
		GROUP BY L.codiceLocale;
END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS aggiorna_ridondanza_pasto_in_IndiciSalute;
DELIMITER $$
CREATE TRIGGER aggiorna_ridondanza_pasto_in_IndiciSalute
BEFORE INSERT ON IndiciSalute
FOR EACH ROW
BEGIN
	DECLARE var_fibre INT UNSIGNED DEFAULT NULL;
	DECLARE var_proteine INT UNSIGNED DEFAULT NULL;
	DECLARE var_glucidi INT UNSIGNED DEFAULT NULL;
	DECLARE var_sali TINYINT UNSIGNED DEFAULT NULL;
	DECLARE var_vitamine TINYINT UNSIGNED DEFAULT NULL;
	SELECT fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine
				FROM Animale A INNER JOIN PastoPerLocale PPL ON A.codLocale = PPL.codLocale
                WHERE A.codice = NEW.codAnimale
                ORDER BY PPL.giorno_orario DESC
                LIMIT 1 INTO var_fibre, var_proteine, var_glucidi, var_sali, var_vitamine;
	SET NEW.fibre = var_fibre;
    SET NEW.proteine = var_proteine;
    SET NEW.glucidi = var_glucidi;
    SET NEW.concentrazioneSali = var_sali;
    SET NEW.concentrazioneVitamine = var_vitamine;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

/*
Operazione 2: Registrazione di una ripoduzione con successo
Descrizione:Al completamento di una riproduzione terminata con succeso, viene
	compilata l’anagrafica del neonato, viene aggiornato lo stato della riproduzione e
    viene programmata una visita per il nuovo nato
Input:codice della riproduzione avvenuta con successo e dati appartenenti al
	neonato (sesso, specie, famiglia, razza, peso, altezza)
Output:registrazione del neonato con programmazione di una nuova visita
Frequenza giornaliera:32
*/

DROP FUNCTION IF EXISTS first_available_code;
DELIMITER $$
CREATE FUNCTION first_available_code() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 1;
	WHILE (SELECT A.codice
			FROM Animale A
            WHERE codice = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS first_available_GPS;
DELIMITER $$
CREATE FUNCTION first_available_GPS() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 1;
	WHILE (SELECT A.codiceGPS
			FROM Animale A
            WHERE codiceGPS = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS check_stato_riproduzione;
DELIMITER $$
CREATE TRIGGER check_stato_riproduzione
AFTER UPDATE ON Riproduzione
FOR EACH ROW 
BEGIN 
IF NEW.stato = 'insuccesso' THEN
	INSERT INTO
		Visita(descrizione,
				dataProgrammata,
				codAnimale,
				codVeterinario)
		VALUES('Visita di controllo automaticamente richiesta in seguito alla riproduzione fallita da parte dell\'animale',
				CURRENT_DATE + INTERVAL 3 DAY,
				NEW.codiceMadre,
				(SELECT R.codVeterinario
					FROM Riproduzione R
					WHERE R.codiceRiproduzione = NEW.codiceRiproduzione));
/*ELSEIF NEW.stato = 'successo' THEN
	signal sqlstate '45000' SET MESSAGE_TEXT = 'Chiamare la procedure OP2_registrazione_neonato per registrare il neonato e prenotargli una visita';
*/END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OP2_registrazione_neonato;
DELIMITER $$
CREATE PROCEDURE OP2_registrazione_neonato
	(IN _codRiproduzione SMALLINT UNSIGNED,
    IN _sesso	ENUM('M', 'F'),
	IN _specie	VARCHAR(30),
	IN _famiglia	VARCHAR(30),
	IN _dataDiNascita	DATE,
	IN _altezza	TINYINT UNSIGNED, /*Si suppone che nessun animale superi i 255 cm in altezza*/
	IN _peso	SMALLINT UNSIGNED, /*Si suppone che nessun animale superi le 65 tonnelate*/
	IN _razza	VARCHAR(30))
BEGIN
  DECLARE codice_ SMALLINT UNSIGNED;
  DECLARE GPS_ SMALLINT UNSIGNED;
  SET codice_ = first_available_code();
  CALL LOG(CONCAT("codice_neonato: ", codice_));
  SET GPS_ = first_available_GPS();
  -- START TRANSACTION;
  INSERT INTO 
  Animale(codice,
			sesso,
			specie,
			famiglia,
			idMadre,
			idPadre,
			dataDiNascita,
			altezza,
			peso,
			razza,
			codiceGPS,
			codLocale)
	VALUES(codice_,
			_sesso,
			_specie,
			_famiglia,
			(SELECT R.codiceMadre
				FROM Riproduzione R
				WHERE R.codiceRiproduzione = _codRiproduzione),
			(SELECT R.codicePadre
				FROM Riproduzione R
				WHERE R.codiceRiproduzione = _codRiproduzione),
			_dataDiNascita,
			_altezza,
			_peso,
			_razza,
			GPS_,
			(SELECT A.codLocale /*il neonato abita il locale della madre*/
				FROM Animale A INNER JOIN Riproduzione R ON A.codice = R.codiceMadre
				WHERE R.codiceRiproduzione = _codRiproduzione)); 
	-- COMMIT WORK;
  INSERT INTO 
	Visita(descrizione,
			dataProgrammata,
			codAnimale,
			codVeterinario)
	VALUES('Visita di controllo automaticamente richiesta in seguito alla nascita dell\' animale',
			CURRENT_DATE + INTERVAL 3 DAY,
            codice_,
            (SELECT R.codVeterinario
				FROM Riproduzione R
				WHERE R.codiceRiproduzione = _codRiproduzione));
	COMMIT;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Operazione 3: Pagamento delle stanze
Descrizione:Ogni giorno viene registrato il pagamento cumulativo di ogni cliente
	per ogni stanza prenotata e per ogni eventuale servizio aggiuntivo utilizzato
Input:la data odierna
Output:i pagamenti da effettuare
Frequenza giornaliera:1
*/

DROP PROCEDURE IF EXISTS OP3_incassa_prenotazioni_del_giorno;
DELIMITER $$
CREATE PROCEDURE OP3_incassa_prenotazioni_del_giorno
	(IN _day DATE)
BEGIN
  DECLARE finito INTEGER DEFAULT 0;
  DECLARE costo_stanze INTEGER UNSIGNED DEFAULT 0;
  DECLARE costo_servizi INTEGER UNSIGNED DEFAULT 0;
	DECLARE cliente VARCHAR(16) DEFAULT "";
	DECLARE cursore CURSOR FOR
		SELECT PS.codCliente
		FROM PrenotazioneStanza PS
        WHERE PS.dataPartenza = _day;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO cliente;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
        
        /*calcola costo delle stanze prenotate*/
        SELECT SUM(S.costoGiornaliero * DATEDIFF(PS.dataPartenza, PS.dataArrivo)) -- si considerano le notti, quindi la differenza in giorni
        FROM PrenotazioneStanza PS INNER JOIN Stanza S
			ON PS.numStanza = S.numStanza AND PS.nomeAgriturismo = S.codAgriturismo
        WHERE PS.codCliente = cliente
			AND PS.dataPartenza = _day INTO costo_stanze;
        
        /*calcola il costo dei servizi utilizzati*/
        SELECT SUM(SA.costo * (DATEDIFF(SPS.dataFineUtilizzo, SPS.dataInizioUtilizzo) + 1)) -- la data di fine utilizzo è da comprendere nei giorni di utilizzo
        FROM PrenotazioneStanza PS INNER JOIN ServizioPerStanza SPS
			ON PS.dataArrivo = SPS.dataArrivo
				AND PS.numStanza = SPS.numStanza
                AND PS.nomeAgriturismo = SPS.nomeAgriturismo
                AND PS.codCliente = SPS.codCliente INNER JOIN ServizioAggiuntivo SA
			ON SPS.codServizio = SA.tipoServizio
		WHERE PS.codCliente = cliente
			AND PS.dataPartenza = _day INTO costo_servizi;
          
		/*inserisci i valori come nuovo pagamento da effettuare*/
		INSERT INTO 
			Pagamenti(tipoPagamento, 
						totaleCosto,
						codCliente)
			VALUES ('stanza',
					costo_stanze + costo_servizi,
					cliente);
		-- CALL LOG(CONCAT("cstanze: ", costo_stanze, " cservizi: ", costo_servizi));
	END LOOP preleva;
	CLOSE cursore;
END $$
DELIMITER ;

DROP EVENT IF EXISTS controllo_pagamenti;
CREATE EVENT controllo_pagamenti
ON SCHEDULE EVERY 1 DAY 
STARTS '2021-01-01 00:00:01'
DO CALL OP3_incassa_prenotazioni_del_giorno(CURRENT_DATE());

/*-------------------------------------------------------------OK

Operazione 4: Stoccaggio del latte munto
Descrizione:Il latte munto viene conservato in appositi silos contenenti tutti latte
con composizione chimico-fisica simile
Input:data e ora della mungitura, oltre che il codice del latte munto
Output:Aggiornamento della quntità stoccata nel corretto silos
Frequenza giornaliera:15000
*/

DROP FUNCTION IF EXISTS first_available_silo;
DELIMITER $$
CREATE FUNCTION first_available_silo() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 1;
	WHILE (SELECT S.codice
			FROM Silos S
            WHERE S.codice = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS OP4_stoccaggio_latte;
DELIMITER $$
CREATE PROCEDURE OP4_stoccaggio_latte
	(/*mungitura*/
    IN _data_ora TIMESTAMP,
    IN _animale SMALLINT UNSIGNED,
    IN _mungitrice SMALLINT UNSIGNED,
    /*latte*/
    IN _codLatte SMALLINT UNSIGNED)
BEGIN

/*cerca il silos che ha la minor differenza tra 
  la quantità di sostanze disciolte nel latte
  con la media delle sostanze dei latti già stoccati in quel silo*/
SELECT S.codice, ABS((
			SELECT L.quantitàSostanzeDisciolte
			FROM Latte L
			WHERE L.codiceLatte = _codLatte) - 
            (
            SELECT AVG(L1.quantitàSostanzeDisciolte)
			FROM Silos S1 INNER JOIN Latte L1 ON S1.codice = L1.codSilos
			WHERE S1.codice = S.codice
			) 
		)
FROM Silos S
WHERE ABS((
			SELECT L.quantitàSostanzeDisciolte
			FROM Latte L
			WHERE L.codiceLatte = _codLatte) - 
            (
            SELECT AVG(L1.quantitàSostanzeDisciolte)
			FROM Silos S1 INNER JOIN Latte L1 ON S1.codice = L1.codSilos
			WHERE S1.codice = S.codice
			) 
		) = 
		(
		SELECT MIN(ABS((
			SELECT L2.quantitàSostanzeDisciolte
			FROM Latte L2
			WHERE L2.codiceLatte = _codLatte
			) - 
			(
			SELECT AVG(L3.quantitàSostanzeDisciolte)
			FROM Silos S3 INNER JOIN Latte L3 ON S3.codice = L3.codSilos
			WHERE S3.codice = S4.codice
            )
		)
	)
	FROM Silos S4
)LIMIT 1 INTO @silo, @diff;

-- CALL LOG(CONCAT("silo è : ", @silo, "; diff è: ", @diff));

/*controlla se c'è spazio nel silos*/
IF (SELECT S.capacità - S.livello
	FROM Silos S
    WHERE S.codice = @silo) < 
    (SELECT M.quantità
    FROM Mungitura M
    WHERE M.codAnimale = _animale
		AND M.codMungitrice = _mungitrice
        AND M.data_orario = _data_ora) THEN
	/* se non c'è spazio, controlla se esiste già un silos vuoto*/
    SET @silo = (SELECT IFNULL ((SELECT S.codice FROM Silos S WHERE S.livello = 0), NULL));
    IF @silo IS NULL THEN
		-- CALL LOG(CONCAT("silo è diventato null!"));
		SET @silo = first_available_silo();
		/*se non c'è, creane uno nuovo (valore capacità di default da scegliere)*/
		INSERT INTO Silos (codice, capacità, livello)
			VALUES (@silo, 1000, (SELECT M.quantità
									FROM Mungitura M
									WHERE M.codAnimale = _animale
										AND M.codMungitrice = _mungitrice
										AND M.data_orario = _data_ora));
		/*usare il nuovo silo per aggiornare dove è stoccato il latte*/
		/*SET @silo = (SELECT MAX(S.codice)
					FROM Silos S);*/
	ELSE
        /*se c'è, aumentare il livello di quel silos
          (direttamente la quantità, in quanto il silo è vuoto)*/
			-- CALL LOG(CONCAT("allora c'è e vale: ", @silo, " infatti livello è: ", (select S.livello FROM Silos S WHERE S.codice = @silo)));
			UPDATE Silos
            SET livello = /*livello + */(SELECT M.quantità
									FROM Mungitura M
									WHERE M.codAnimale = _animale
										AND M.codMungitrice = _mungitrice
										AND M.data_orario = _data_ora)
			WHERE codice = @silo;
    END IF;
    
ELSE
    /*se c'è spazio nel silo, aggiungi la quantità munta al livello*/
		UPDATE Silos
		SET livello = livello + (SELECT M.quantità
								FROM Mungitura M
								WHERE M.codAnimale = _animale
									AND M.codMungitrice = _mungitrice
									AND M.data_orario = _data_ora)
		WHERE codice = @silo;
END IF;

-- CALL LOG(CONCAT("silo dopo il controllo: ", @silo));

/*aggiornare in quale silo è stato stoccato il latte*/
UPDATE Latte
SET codSilos = @silo
WHERE codiceLatte = _codLatte;

END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Operazione 5: Controllo igiene dei locali
Descrizione:Per garantire il rispetto delle condizioni di benessere degli animali
all’interno dei locali, viene frequentemente controllato che i parametri rilevati 
rientrino nelle soglie di tollerabilità, ed eventualmente viene inviata una richiesta
di intervento di pulizia, insieme all’aggiornamento dei parametri del locale con i
valori più recenti raccolti
Input:Il codice del locale da controllare
Output:Richiesta d’intervento di pulizia
Frequenza giornaliera:40
*/

DROP PROCEDURE IF EXISTS OP5_controllo_igiene_locali;
DELIMITER $$
CREATE PROCEDURE OP5_controllo_igiene_locali
	(/*IN _locale SMALLINT UNSIGNED*/)
BEGIN

DECLARE finito INTEGER DEFAULT 0;
DECLARE locale SMALLINT UNSIGNED DEFAULT NULL;
DECLARE cursore CURSOR FOR
	SELECT L.codiceLocale
    FROM Locale L;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

OPEN cursore;

/*per ogni locale*/
preleva: LOOP
	FETCH cursore INTO locale;
    IF finito = 1 THEN
		LEAVE preleva;
	END IF;
    /*considera le medie di tutti i sensori nel locale*/
    SELECT AVG(V.livelloSporcizia)
    FROM Visivi V
    WHERE V.codLocale = locale INTO @media_sporcizia;
    
    SELECT AVG(A.temperatura)
    FROM Ambientali A
    WHERE A.codLocale = locale INTO @media_temperatura;
    
    SELECT AVG(A.umidità)
    FROM Ambientali A
    WHERE A.codLocale = locale INTO @media_umidita;
    
    SELECT AVG(CV.concentrazioneMetano)
    FROM CompostiVolatili CV
    WHERE CV.codLocale = locale INTO @media_metano;
    
    SELECT AVG(CV.concentrazioneAzoto)
    FROM CompostiVolatili CV
    WHERE CV.codLocale = locale INTO @media_azoto;
    
    /*aggiorna temperatura e umidità medi*/
    UPDATE Locale
    SET temperatura = @media_temperatura
    , umidità = @media_umidita
    WHERE codiceLocale = locale;
    
    /*considera le soglie di tollerabilità*/
    SELECT L.tollerabilitaAzoto, L.tollerabilitaSporcizia, L.tollerabilitaMetano
    FROM Locale L
    WHERE L.codiceLocale = locale INTO @max_azoto, @max_sporcizia, @max_metano;
    
    /*se anche solo uno di questi valori supera la soglia consentita*/
    IF @media_azoto > @max_azoto OR @media_sporcizia > @max_sporcizia OR @media_metano > @max_metano THEN
		/*effettua una nuova richiesta d'intervento di pulizia per il locale*/
		INSERT INTO PuliziaLocale (codLocale, data_orarioRilevazione, stato, personale)
        VALUES (locale, CURRENT_TIMESTAMP(), 'pendente', 'personale per la pulizia del locale');
    END IF;
    
END LOOP preleva;
CLOSE cursore;

END $$
DELIMITER ;

DROP EVENT IF EXISTS controllo_igiene_locali;
CREATE EVENT controllo_igiene_locali
ON SCHEDULE EVERY 12 HOUR 
STARTS '2021-01-01 00:08:00'
DO CALL OP5_controllo_igiene_locali();

/*-------------------------------------------------------------

Operazione 6: Processamento degli ordini
Descrizione:Gli utenti che si sono registrati nello store online possono acquistare i
prodotti caseari e ricevere il proprio ordine tramite le spedizioni gestite dal database
Input:Il codice del nuovo ordine effettuato dal cliente sullo store online
Output:Processamento ed invio dell’ordine
Frequenza giornaliera:400
*/

/*vincolo X controlla già la disponibilità dell'ordine!!

DROP PROCEDURE IF EXISTS OP6_processamento_ordini;
DELIMITER $$
CREATE PROCEDURE OP6_processamento_ordini
	(IN _var CHAR(20),
    OUT var_ INT)
BEGIN
  SELECT attr
  FROM table INTO var_;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS check_nuovo_ordine;
DELIMITER $$
CREATE TRIGGER check_nuovo_ordine
BEFORE INSERT ON Tabella
FOR EACH ROW 
BEGIN 
IF  THEN
	signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE: ';
END IF;
SET NEW.attributo = ();
END $$
DELIMITER ;

*/

/*-------------------------------------------------------------

Operazione 7: Prescrizione delle terapie
Descrizione:Alla registrazione di una nuova terapia da parte di un veterinario,
viene controllato se questa è la terza consecutiva sullo stesso animale, nel qual
caso viene effettuato un ricollocamento in una zona di quarantena
Input:la nuova terapia e l’animale a cui è assegnata
Output:Trasferimanto dell’animale in un nuovo locale di quarantena
Frequenza giornaliera:110
*/

/*Ogni Agriturismo ha un locale di quarantena, identificato da un codice superiore a 10000*/
DROP FUNCTION IF EXISTS localeQuarantena;
DELIMITER $$
CREATE FUNCTION localeQuarantena(
    _locale SMALLINT UNSIGNED
) 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
 
    SELECT L.codiceLocale
    FROM Locale L
    WHERE L.codiceLocale > 10000 -- soglia oltre la quale il locale è di quarantena
		AND 40 > (SELECT COUNT(A.codice)
					FROM Animale A
                    WHERE A.codLocale = L.codiceLocale)
		AND L.nomeAgriturismo = (SELECT L1.nomeAgriturismo
								FROM Locale L1
                                WHERE L1.codiceLocale = _locale) 
	LIMIT 1 INTO return_value;
    RETURN (return_value);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS OP7_check_nuova_terapia;
DELIMITER $$
CREATE TRIGGER OP7_check_nuova_terapia
BEFORE INSERT ON Terapia
FOR EACH ROW 
BEGIN 
IF (SELECT T.codiceTerapia
	FROM Terapia T
    WHERE T.codAnimale = NEW.codAnimale
        AND T.dataInizio + INTERVAL T.durata DAY  >= CURRENT_DATE()
        AND T.secondaTerapiaConsecutiva) IS NOT NULL THEN
	UPDATE Animale
    SET codLocale = localeQuarantena(codLocale)
    WHERE codice = NEW.codAnimale;
ELSEIF (SELECT T.codiceTerapia
		FROM Terapia T
		WHERE T.codAnimale = NEW.codAnimale
			AND T.dataInizio + INTERVAL T.durata DAY  >= CURRENT_DATE()
			AND NOT T.secondaTerapiaConsecutiva) IS NOT NULL THEN
	SET NEW.secondaTerapiaConsecutiva = 1;
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------

Operazione 8: Controllo degli animali dispersi
Descrizione:Durante le attività di pascolo viene monitorato ad intervalli regolari
il segnale GPS di ogni singolo animale affinchè ci si assicuri che rientri negli spazi
delimitati dalle recinzioni per le zone dedicate al pascolo
Input:codice dell’attività di pascolo
Output:segnalazione se l’animale è disperso
Frequenza giornaliera:3968
*/


DROP EVENT IF EXISTS controllo_attivita_pascolo;
CREATE EVENT controllo_attivita_pascolo
ON SCHEDULE EVERY 15 MINUTE 
STARTS '2021-01-01 00:00:01'
DO CALL attivita_in_data(CURRENT_DATE());

DROP PROCEDURE IF EXISTS attivita_in_data;
DELIMITER $$
CREATE PROCEDURE attivita_in_data
	(IN _data DATE)
BEGIN
	DECLARE finito INTEGER DEFAULT 0;
	DECLARE attivita SMALLINT UNSIGNED DEFAULT NULL;
	DECLARE cursore CURSOR FOR
		SELECT AP.codiceAttivita
        FROM AttivitaPascolo AP
        WHERE DATE_FORMAT(AP.giorno_orario, '%Y-%m-%d') = _data;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO attivita;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
        CALL OP8_check_animali_dispersi(attivita);
	END LOOP preleva;
	CLOSE cursore;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OP8_check_animali_dispersi;
DELIMITER $$
CREATE PROCEDURE OP8_check_animali_dispersi
	(IN _attivita SMALLINT UNSIGNED)
BEGIN
/*
	DECLARE finito INTEGER DEFAULT 0;
	DECLARE animale SMALLINT UNSIGNED DEFAULT NULL;
	DECLARE animali_dispersi VARCHAR(255) DEFAULT "";
	DECLARE cursore CURSOR FOR
		SELECT A.codice
        FROM Animale A
        WHERE A.codLocale = (SELECT AP.codLocale
							FROM AttivitaPascolo AP
                            WHERE AP.codiceAttivita = _attivita);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO animale;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
        IF -- distanza minima da una recinzione è superiore ad una soglia 
			THEN
			SET animale_dispersi = CONCAT(animali_dispersi, ';', animale);
		END IF;
	END LOOP preleva;
	CLOSE cursore;
    */
   	DECLARE animali_dispersi VARCHAR(255) DEFAULT "";
    
    SELECT GROUP_CONCAT(A.codice SEPARATOR ';')
    FROM Animale A
    WHERE A.codLocale = (SELECT AP.codLocale
							FROM AttivitaPascolo AP
                            WHERE AP.codiceAttivita = _attivita)
		AND 100 < -- distanza oltre la quale un animale è definito disperso
			(SELECT MIN(SQRT(POW(A.longitudine - RD.longitudine, 2)+POW(A.latitudine - RD.longitudine, 2)))
			FROM RecinzioneDivisoriaeZonaDiPascolo RD
			WHERE RD.codArea = (SELECT AP1.codArea
								FROM AreaPascolo AP1
								WHERE AP1.codiceAttivita = _attivita) ) INTO animali_dispersi;
    
    IF animali_dispersi <> "" THEN
		SELECT animali_dispersi;
		signal sqlstate '70006' SET MESSAGE_TEXT = 'Lista degli anmali dispersi mostrata in tabella';
	ELSE
		signal sqlstate '70006' SET MESSAGE_TEXT = 'Nessun animali disperso';
    END IF;

END $$
DELIMITER ;


/*-------------------------------------------------------------

perazione 9: Registrazione nuovo account
Descrizione:All’ inserimento di un nuovo account nello store online, viene 
controllato se i dati inseriti corrispondono a quelli di un cliente già registrato ma senza
un account. Nel caso viene aggiunto un record in Account con i dati forniti 
durante la registrazione, altrimenti viene prima registrato il nuovo cliente a partire
dal codice della sua carta
Input:anagrafica del cliente, dati dei documenti e informazioni sull’account daregistrare
Output:aggiunta di un account e del cliente che lo possiede
Frequenza giornaliera:19
*/

DROP TRIGGER IF EXISTS OP9_check_nuovo_account;
DELIMITER $$
CREATE TRIGGER OP9_check_nuovo_account
BEFORE INSERT ON Account
FOR EACH ROW 
BEGIN 
IF NEW.codiceCarta NOT IN (SELECT C.codCarta
							FROM Cliente C) THEN
	INSERT INTO Cliente (codCarta) VALUES (NEW.codiceCarta);
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------

Operazione 10: Ridistribuzione degli animali all’aggiunta di unnuovo locale
Descrizione:All’aggiunta di un nuovo locale, vengono smistati gli animali già
presenti nella stalla affinchè sia mantenuto costante il numero di animali per locale
Input:dati del nuovo locale e codice della stalla a cui appartiene
Output:ridistribuzione degli animali nel nuovo locale aggiunto e registrazione deinuovi sensori
Frequenza giornaliera:0.27
*/

DROP PROCEDURE IF EXISTS ridistrubuzione_in_stalla;
DELIMITER $$
CREATE PROCEDURE ridistrubuzione_in_stalla
	(IN _stalla TINYINT UNSIGNED,
    IN _locale SMALLINT UNSIGNED)
BEGIN
	DECLARE num_animali INTEGER DEFAULT 0;
	DECLARE num_locali INTEGER DEFAULT 0;
    DECLARE da_togliere INTEGER DEFAULT 0;
    
	DECLARE finito INTEGER DEFAULT 0;
	DECLARE locali SMALLINT UNSIGNED DEFAULT NULL;
	DECLARE cursore CURSOR FOR
		SELECT L.codiceLocale
        FROM Locale L
        WHERE L.codiceStalla = _stalla;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	SELECT COUNT(A.codice)
	FROM Animale A INNER JOIN Locale L ON A.codLocale = L.codiceLocale
	WHERE L.codiceStalla = _stalla INTO num_animali;

	SELECT COUNT(L.codiceLocale) -- + 1 considerare il locale che deve essere aggiunto
	FROM Locale L
	WHERE L.codiceStalla = _stalla INTO num_locali;
  
    SET da_togliere = FLOOR((num_animali / num_locali - 1) - (num_animali / (num_locali)));
    
    CALL LOG(CONCAT("da togliere: ", da_togliere));

	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO locali;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
			UPDATE Animale AS A INNER JOIN (SELECT A2.codice
											FROM Animale A2
											WHERE A2.codLocale = locali
											LIMIT da_togliere) AS A2 ON A.codice = A2.codice
			SET A.codLocale = _locale;/*
			WHERE codice IN (SELECT A.codice
							FROM Animale A );*/
	END LOOP preleva;
	CLOSE cursore;
  	
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS OP10_ridistribuzione_animali;
DELIMITER $$
CREATE TRIGGER OP10_ridistribuzione_animali
AFTER INSERT ON Locale
FOR EACH ROW 
BEGIN 
	CALL ridistrubuzione_in_stalla(NEW.codiceStalla, NEW.codiceLocale);
END $$
DELIMITER ;


/*-------------------------------------------------------------


/* MODULE PROCEDURE :

DROP PROCEDURE IF EXISTS procedure_name;
DELIMITER $$
CREATE PROCEDURE procedure_name
	(IN _var CHAR(20),
    OUT var_ INT)
BEGIN
  SELECT attr
  FROM table INTO var_;
END $$
DELIMITER ;

*/

/* MODULE FUNCTION:

DROP FUNCTION IF EXISTS function_name;
DELIMITER $$
CREATE FUNCTION function_name(
    var DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE return_value VARCHAR(20);
 
    IF credit > 50000 THEN
        SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
            credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
    -- return the customer level
    RETURN (return_value);
END$$
DELIMITER ;

*/

/* MODULE TRIGGER:

DROP TRIGGER IF EXISTS nome_trigger;
DELIMITER $$
CREATE TRIGGER nome_trigger
BEFORE INSERT ON Tabella
FOR EACH ROW 
BEGIN 
IF  THEN
	signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE: ';
END IF;
SET NEW.attributo = ();
END $$
DELIMITER ;

*/

/* MODULE CURSOR:

DECLARE finito INTEGER DEFAULT 0;
DECLARE result_var VARCHAR(255) DEFAULT "";
DECLARE nome_cursore CURSOR FOR
	SELECT
		...
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

OPEN nome_cursore;

preleva: LOOP
	FETCH nome_cursore INTO result_var;
    IF finito = 1 THEN
		LEAVE preleva;
	END IF;
    SET uscita = CONCAT(uscita, ';', result_var);
END LOOP preleva;
CLOSE nome_cursore;

*/
