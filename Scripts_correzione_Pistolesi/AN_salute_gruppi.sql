-- Analisi della salute generale dei gruppi di animali che si trovano in vicinanza

USE FarmHouse;
-- COMPORTAMENTO DEGLI ANIMALI
-- la funzionalità comporta un' analisi delle posizioni GPS atta a capire quali sono le zone più frequentate
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
			SET valore_medio=valore_medio+
            (SELECT AVG((I.vigilanza+I.idratazione+I.deambulazione)/3) AS AVG_value FROM IndiciSalute I WHERE codAnimale=codice GROUP BY I.codAnimale)/counter;
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
	
 
	/*Inizio script di testing,                             */
    /*terminare il commento di questa riga per eseguire     *

-- Primo grupo di animali vicini

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (80, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', -117.249, -178.780, '2012-03-11 18:33:37', 1, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (80, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (80, '2019-02-08', 22, 44, 85, 58, 72, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (80, '2019-02-09', 32, 54, 75, 68, 62, 103, 967, 878, 10, 5);


INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (81, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', -118.249, -178.680, '2012-03-11 18:33:37', 1, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (81, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (81, '2019-02-08', 22, 44, 85, 58, 72, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (81, '2019-02-09', 32, 54, 75, 68, 62, 103, 967, 878, 10, 5);


INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (82, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', -117.749, -179.780, '2012-03-11 18:33:37', 1, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (82, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (82, '2019-02-08', 22, 44, 85, 58, 72, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (82, '2019-02-09', 32, 54, 75, 68, 62, 103, 967, 878, 10, 5);

-- Secondo gruppo di animli vicini 

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (91, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 18.249, -78.680, '2012-03-11 18:33:37', 1, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (91, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (91, '2019-02-08', 22, 44, 85, 58, 72, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (91, '2019-02-09', 32, 54, 75, 68, 62, 103, 967, 878, 10, 5);


INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (92, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 17.749, -79.780, '2012-03-11 18:33:37', 1, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (92, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (92, '2019-02-08', 22, 54, 85, 58, 72, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (92, '2019-02-09', 32, 54, 75, 68, 62, 103, 967, 878, 10, 5);
    
    
CALL Analisi_comportamentale_animali(1, 3);

-- SELECT * FROM logtable;

SELECT * FROM Indici_per_gruppo;

SELECT * FROM Valori_medi_per_gruppo;

	