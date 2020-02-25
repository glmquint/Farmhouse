-- Analisi della salute generale dei gruppi di animali che si trovano in vicinanza

USE FarmHouse;
-- COMPORTAMENTO DEGLI ANIMALI
-- la funzionalità comporta un analisi delle posizioni GPS atta a capire quali sono le zone più frequentate
-- dagli animali.(si ordinano le posizioni (rank in un certo range) e si contano gli animali in ogni zona) 
-- Si valuta poi effettivamente lo stato di salute degli animali che hanno pascolato in quelle zone
-- (si estraggono poi gli animali suddetti ed i loro indici di salute e si fa un ranking anche di questi) 
-- e si calcola la probabilità (come numero degli animali che effettivamente ci pascolano più volte in
-- un anno sugli animali totali) con la quale un animale pascolerà in quella zona per capire se effettivamente
-- convenga cercare di convogliare i pascoli in quella zona.

/*
INSERT INTO Animale VALUES(1,'M','SDC','SDS',NULL,NULL,'1999/12/27',27,27,'ghh',30.2,30.3,NULL,0,0);
INSERT INTO Locale VALUES(0,NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO Stalla VALUES(1,NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
*/

-- creo le tabelle di appoggio
DROP TABLE IF EXISTS Indici_per_gruppo;
CREATE TABLE	Indici_per_gruppo(codAnimale INTEGER,
								indiceMedio FLOAT DEFAULT 0.0,
                                PRIMARY KEY (codAnimale))ENGINE=InnoDB DEFAULT CHARSET = latin1;
DROP TABLE IF EXISTS Valori_medi_per_gruppo;
CREATE TABLE	Valori_medi_per_gruppo(codGruppo INTEGER AUTO_INCREMENT,
									indiceMedioGruppo FLOAT DEFAULT 0.0,
                                    PRIMARY KEY (codGruppo))ENGINE=InnoDB DEFAULT CHARSET = latin1;  


DROP PROCEDURE IF EXISTS Analisi_comportamentale_animali;
DELIMITER $$
CREATE PROCEDURE Analisi_comportamentale_animali(IN tipo BOOLEAN, IN dist_range FLOAT UNSIGNED)
BEGIN
    DECLARE previous_value_lat	FLOAT DEFAULT 0.0;
	DECLARE previous_value_long	FLOAT DEFAULT 0.0;
    DECLARE finished INTEGER DEFAULT 0;
	DECLARE counter INTEGER DEFAULT 0;
	DECLARE counter_prev INTEGER DEFAULT 0;
    
    DECLARE valore_medio FLOAT DEFAULT 0;
    
    
    DECLARE lat FLOAT;
    DECLARE longi FLOAT;
    DECLARE codice SMALLINT UNSIGNED;
     -- declare cursor for employee email
    DECLARE currecord CURSOR FOR 
		SELECT A.codice,A.latitudine,A.longitudine
		FROM Animale A
		ORDER BY A.latitudine,A.longitudine;
     -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	-- WITH ordered_pos AS (
	--    ) -- ordino gli animali per posizione crescente*/

   
    -- CALL LOG("Inizio While");
    OPEN currecord;
   --  WHILE finished=0 DO  -- apro il ciclo che mi consente di individuare più di un gruppo
   --      OPEN currecord;
			/*WHILE  counter<counter_prev DO -- riparto dal punto in cui mi ero fermato al punto precedente
				FETCH currecord INTO codice,lat,longi; -- faccio avanzare il cursore
                CALL LOG(CONCAT("dopo fetch: ", codice));
				SET counter=counter+1; 
			END WHILE;
	*/
    FETCH currecord INTO codice ,lat,longi;
	-- CALL LOG(CONCAT("dopo primo fetch codice: ", IFNULL(codice, 'niente'), " lat: ", IFNULL(lat, 'niente'), " longi: ", IFNULL(longi, 'niente')));

    SET previous_value_lat=lat;
	SET previous_value_long=longi;
    SET valore_medio = (SELECT IFNULL(AVG((I.vigilanza+I.idratazione+I.deambulazione)/3), 0) AS AVG_value FROM IndiciSalute I WHERE codAnimale=codice GROUP BY I.codAnimale);
    SET counter =1;
    
	getgroup: LOOP -- apro il ciclo per formare il nuovo gruppo
		FETCH currecord INTO codice ,lat,longi; -- carico i valori dell'animale da cercare
		-- CALL LOG(CONCAT("dopo secondo fetch codice: ", IFNULL(codice, 'niente'), " lat: ", IFNULL(lat, 'niente'), " longi: ", IFNULL(longi, 'niente')));

		IF finished = 1 THEN 
			LEAVE getgroup;
		END IF;
		

		IF (previous_value_lat<=lat+dist_range AND previous_value_lat>lat-dist_range) 
				AND  
			(previous_value_long<=longi+dist_range AND previous_value_long>longi-dist_range) THEN
            CALL LOG("primo branch");
			SET previous_value_lat=lat;
			SET previous_value_long=longi;

			REPLACE INTO Indici_per_gruppo 
				SELECT I.codAnimale,
						AVG((I.vigilanza+I.idratazione+I.deambulazione)/3) AS AVG_value 
				FROM IndiciSalute I 
					WHERE I.codAnimale=codice
				GROUP BY I.codAnimale;
			SET valore_medio=valore_medio+(SELECT AVG((I.vigilanza+I.idratazione+I.deambulazione)/3) AS AVG_value FROM IndiciSalute I WHERE codAnimale=codice GROUP BY I.codAnimale)/counter;
			SET counter=counter+1;
            -- CALL LOG(CONCAT("now valore_medio: ", IFNULL(valore_medio, 'niente'), " couter: ", IFNULL(counter, 'niente')));
			-- se i valori sono in un certo range carico in una delle tabelle d'appoggio gli indici di salute medi e il codice di ogni animale
		ELSE 
			-- CALL LOG("else branch");
			-- SET counter_prev=counter;
			SET counter=1;
            REPLACE INTO Valori_medi_per_gruppo VALUES(DEFAULT,valore_medio); -- dopo aver separato un gruppo inserisco il valore medio per quel gruppo in una tabella d'appoggio
			SET valore_medio=0;
			SET previous_value_lat=lat;
			SET previous_value_long=longi;
			SET valore_medio = (SELECT IFNULL(AVG((I.vigilanza+I.idratazione+I.deambulazione)/3), 0) AS AVG_value FROM IndiciSalute I WHERE codAnimale=codice GROUP BY I.codAnimale);

			-- LEAVE getgroup;  -- resetto tutto e esco dal ciclo
		END IF	;	
	END LOOP getgroup;
    REPLACE INTO Valori_medi_per_gruppo VALUES(DEFAULT,valore_medio);
	CLOSE currecord;
	-- CALL LOG(CONCAT("NUOVO WHILE codice: ", codice, " lat: ", lat, " longi: ", longi));
  -- END WHILE;  -- e riparto
  /*
  IF tipo=TRUE THEN  -- stampa una delle due tabelle a seconda del tipo di richiesta
    SELECT *
	FROM Indici_per_gruppo;
  ELSE
    SELECT *
	FROM Valori_medi_per_gruppo;
  END IF;
  */
END $$
DELIMITER ;
	
 
	











/*
-- TRACCIABILITA' DI FILIERA
-- si fa un rank delle decensioni negative e poi si fa group by per prodotto, poi si risale al lotto di appartenenza 
-- per quel lotto si calcola la percentuale di attinenza al processo produttivo facendo qualche calcolo tra i parametri
-- effetrtivi e quelli ideali per ogni fase del processo, inoltre si traccia una percentuale dei prodotti che hanno processo di produzione simile
-- e si confrontano le vendite con recensione negativa e positiva di questi ultimi per capire quale fase del processo produttivo è quella 
-- problematica


WITH Recensioni_negative R AS (
			SELECT codProdotto, COUNT DISTINCT AS num_rec_neg
			FROM Recensione
			GROUP BY codProdotto
			WHERE campoTestuale LIKE '%comprato%formaggio%prodotto%deperito%scaduto%marcio%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 OR gusto<=2 OR conservazione<=2
			)  -- si costruisce una derived table che contiene le quantità di ogni prodotto venduto
	
	
	SELECT F.codiceFase,L.codiceLotto,L.codLab,L.codDipendenti,M.quantitàSostanzeDisciolte
	FROM Lotto L 
			INNER JOIN ControlloParametriFase C ON C.codLotto=L.codiceLotto INNER JOIN Fasi F ON F.codiceFase=C.codFase 
					INNER JOIN prodottocon P ON L.codicelotto=P.codLotto INNER JOIN Latte M ON P.codLatte=M.codiceLatte
	WHERE CONCAT(C.parametriEffettivi,M.quantitàSostanzeDisciolte) NOT LIKE CONCAT(F.parametriProcesso,M.quantitàSostanzeDisciolte) AND C.codProdotto=R.codProdotto;
	
	
	
	
	
	
	
	
	
-- ANALISI DELLE VENDITE
-- si raggruppano gli ordini per prodotti comprati tenendo conto del numero di unità di prodotto acquistate da ciascun cliente
-- sul totale di unità per ogni prodotto acquistate si calcola la percentuale sul totale delle vendite e si calcola un fattore 
-- di scarto percentuale delle vendite dovuto a delle recensioni negative degli utenti che avevano in ordine quel prodotto così
-- da valutare se vale la pena alzare il prezzo (ed eventualmente di quanto) oppure se creare un'offerta per ristabilire i valori
-- ideali.

-- 1)in contenuto ordine si raggruppa per codice formaggio e si fa select sum(quantità);
-- 2) dopo di che si fa rank percentuale della quantità sul gruppo ottenuto (per capire in base alla quantità di unità vendute per ogni prodotto,
-- qual'è quello con più vendite)
-- 3) si contano le recensioni negative per ogni prodotto in percentuale rispetto a quelle totali si considerano le recensioni negative come persone che non compreranno
-- più il prodotto
-- 4) e si calcola in base alla percentuale di chi non lo comprerà più (in maniera direttamente proporzionale e del tutto slegata dal mercato) 
-- di quanto andrà scontato il singolo prodotto

DELIMITER $$
CREATE PROCEDURE Analisi_vendite(IN tipo BOOLEAN)
BEGIN
   IF tipo=TRUE THEN
		WITH Vendite_percentuali AS (
			SELECT SUM(quantità) AS totale_vendite_per_prodotto
			FROM contenutoordine
			GROUP BY codiceProdotto)  -- si costruisce una derived table che contiene le quantità di ogni prodotto venduto
	 
	 
			SELECT codiceProdotto,ROUND(PERCENT_RANK() OVER (ORDER BY codiceProdotto),2) AS percentuale_di_vendita
			FROM Vendite_percentuali; -- si compie un ordinamento percentuale dei prodotti venduti per avere il prospetto delle vendite
   ELSE
	 
		 WITH Rec_neg_servizi AS (
			SELECT COUNT(*) AS num_rec_neg,
			CASE
				WHEN campoTestuale LIKE '%comprato%formaggio%prodotto%deperito%scaduto%marcio%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 OR gusto<=2 OR conservazione<=2 THEN 'recensioni negative associate ai prodotti'
				WHEN campoTestuale LIKE '%stanza%camera%soggiorno%servizio%pagamenti%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 AND gusto IS NULL AND conservazione IS NULL THEN 'recensioni negative associate ai pagamenti%'
				WHEN campoTestuale LIKE '%escursione%gita%percorso%sentiero%guida%passeggiata%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 AND gusto IS NULL AND conservazione IS NULL THEN 'recensioni negative associate alle escursioni'
				WHEN campoTestuale LIKE '%corriere%spedizione%perso%smarrito%hub%spese%doganali%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 AND gusto IS NULL AND conservazione IS NULL THEN 'recensioni negative associate alle camere'
			END 
	
			FROM Recensione
	
			GROUP BY campotestuale 
			HAVING 
				campoTestuale LIKE '%comprato%formaggio%prodotto%deperito%scaduto%marcio%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 OR gusto<=2 OR conservazione<=2,
				campoTestuale LIKE '%stanza%camera%soggiorno%servizio%pagamenti%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 AND gusto IS NULL AND conservazione IS NULL,
				campoTestuale LIKE '%escursione%gita%percorso%sentiero%guida%passeggiata%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 AND gusto IS NULL AND conservazione IS NULL,
				campoTestuale LIKE '%corriere%spedizione%perso%smarrito%hub%spese%doganali%' AND  gradimentoGenerale<=2 OR qualitàPercepita<=2 AND gusto IS NULL AND conservazione IS NULL
	    ) -- si determinano le recensioni negative per ogni servizio e il servizio a cui sono correlate
	
			SELECT * ,ROUND(PERCENT_RANK() OVER (ORDER BY num_rec_neg),2) AS percentuale_di_recensioni_negative
			FROM Rec_neg_servizi; -- si compie un ordinamento percentuale delle recensioni per servizio per capire quali sono le carenze delle aziende di farmhouse 4.0
	END IF
END $$
DELIMITER ;*/
	