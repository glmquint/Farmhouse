/* MODULE PROCEDURE :

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

/*-------------------------------------------------------------

/*Operazione 1: Controllo qualità del pasto
Descrizione:Viene controllato che il pasto che viene somministrato agli animali
	non abbia ripercussioni sul loro stato di salute: in particolare vengono 
    controllati gli indici di salute di tutti gli animali appartenenti ai locali
    nei quali è stato somministrato il pasto in esame
Input:composizione del pasto
Output:media degli indici di salute
Frequenza giornaliera:33
*/

/* Magari può essere utile un trigger da attivare ogni volta che viene cambiato pasto in un locale...
DROP TRIGGER IF EXISTS cambio_pasto;
DELIMITER $$
CREATE TRIGGER cambio_pasto
BEFORE UPDATE ON PastoPerLocale
FOR EACH ROW 
BEGIN 
-- chiama la stored procedure...
END $$
DELIMITER ;
*/

DELIMITER $$
 
CREATE FUNCTION prima_somministrazione(
	/*il pasto*/
    _fibre INT UNSIGNED,
	_proteine INT UNSIGNED,
	_glucidi INT UNSIGNED,
	_concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
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
                AND PPL.concentrazioneVitamine = _concentrazioneVitmine
                AND PPL.codLocale = _codiceLocale
			LIMIT 1
            INTO return_value;
            
	IF return_value IS NOT NULL THEN
		RETURN(DATE_FORMAT(FROM_UNIXTIME(return_value), '%e %b %Y'));
	ELSE
		RETURN(NULL);
	END IF;

END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE OP1_controllo_qualita_pasto
	(IN _fibre INT UNSIGNED,
	IN _proteine INT UNSIGNED,
	IN _glucidi INT UNSIGNED,
	IN _concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	IN _concentrazioneVitamine	TINYINT UNSIGNED)
BEGIN
 SELECT L.codiceLocale AS Locale, 
	AVG(I.tipologiaRespirazione) AS tipologiaRespirazione, 
	AVG(I.deambulazione) AS tipologiaRespirazione, 
    AVG(I.idratazione) AS idratazione, 
    AVG(I.vigilanza) AS vigilanza, 
    AVG(I.lucentezzaPelo) AS lucentezzaPelo
 FROM Locale L INNER JOIN Animale A ON L.codice = A.codiceLocale
				INNER JOIN IndiciSalute I ON A.codice = I.codiceAnimale
 WHERE L.codiceLocale IN (SELECT DISTINCT(PPL.codlocale
							FROM PastoPerLocale PPL
                            WHERE PPL.fibre = _fibre
								AND PPL.proteine = _proteine
                                AND PPL.glucidi = _glucidi
                                AND PPL.concentrazioneSali = _concentrazioneSali
                                AND PPL.concentrazioneVitamine = _concentrazioneVitamine))
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
END $$
DELIMITER ;

/*-------------------------------------------------------------

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

DELIMITER $$
CREATE FUNCTION first_available_code() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 0;
	WHILE (SELECT A.codice
			FROM Animale A
            WHERE codice = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION first_available_GPS() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 0;
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
				WHERE R.codiceRiproduzione = NEW.codRiproduzione));
ELSE IF NEW.stato = 'successo' THEN
	signal sqlstate '70006' SET MESSAGE_TEXT = 'Chiamare la procedure OP2_registrazione_neonato per registrare il neonato e prenotargli una visita';
END IF;
SET NEW.attributo = ();
END $$
DELIMITER ;

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
  SET GPS_ = first_available_GPS();
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
END $$
DELIMITER ;
