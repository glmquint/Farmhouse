/*vincolo I*/
-- Esiste un vincolo di integrità che lega il codice di un animale al codice dellamadre e del padre (idMadre,idPadre)
DROP TRIGGER IF EXISTS I_controllo_genitori;
DELIMITER $$ 
CREATE TRIGGER I_controllo_genitori
BEFORE INSERT ON Animale FOR EACH ROW
BEGIN 
	IF new.idMadre NOT IN (
	                         SELECT codice 
                             FROM Animale A
	                         WHERE A.sesso='F')
	    AND new.idMadre IS NOT NULL THEN
	    signal sqlstate '70006' SET MESSAGE_TEXT='il codice madre inserito non è valido';
	END IF;
	
	
	
	IF new.idPadre NOT IN (
	                         SELECT codice 
                             FROM Animale A
	                         WHERE A.sesso='M')
	    AND new.idPadre IS NOT NULL THEN
	    signal sqlstate '70006' SET MESSAGE_TEXT='il codice padre inserito non è valido';
	END IF;
	

END $$	
DELIMITER ;


/*vincolo II*/
DROP TRIGGER IF EXISTS II_controllo_data_nascita;
DELIMITER $$
CREATE TRIGGER II_controllo_data_nascita
BEFORE INSERT ON Animale FOR EACH ROW
BEGIN 

    -- Esiste un vincolo di integrità che lega l’attributo data in diproduzione conl’attributo dataDiNascita in Animale
	IF NEW.idMadre IS NOT NULL AND NEW.idPadre IS NOT NULL AND new.dataDiNascita NOT IN (SELECT DATE_FORMAT(R.data_orario, '%Y-%m-%d')
							   FROM Riproduzione R 
							   WHERE new.idMadre=R.codiceMadre AND new.idPadre=R.codicepadre) THEN

		signal sqlstate '70006' SET MESSAGE_TEXT='la data di nascita non è valida';
	END IF;
END $$	
DELIMITER ;






/*vincolo III*/
-- Esiste un vincolo di integrità che lega l’attributo codicePadre in coinvolgecon l’attributo codice in Animale
DROP TRIGGER IF EXISTS III_codicePadre_riproduzione;
DELIMITER $$ 
CREATE TRIGGER III_codicePadre_riproduzione
BEFORE INSERT ON Riproduzione FOR EACH ROW
BEGIN 
    
	IF new.codicePadre NOT IN (
	                         SELECT codice 
                             FROM Animale A
	                         WHERE A.sesso='M')
	    OR new.codicePadre IS NULL THEN
	    signal sqlstate '70006' SET MESSAGE_TEXT='il codice padre associato alla riproduzione non è valido';
	END IF;	
END $$
DELIMITER ;










/*vincolo IV*/
-- Esiste un vincolo di integrità che lega gli attributi temperatura e umidità inLocale con temperatura e umidità in Ambientali
DROP TRIGGER IF EXISTS IV_aggiornamento_ambientali;
DELIMITER $$ 
CREATE TRIGGER IV_aggiornamento_ambientali
BEFORE UPDATE ON Ambientali FOR EACH ROW
BEGIN 
UPDATE Locale
	SET new.temperatura=( SELECT AVG(temperatura) 
                      FROM Locale L INNER JOIN Ambientali A ON A.codLocale=L.codice 
	                  WHERE A.temperatura IS NOT NULL AND A.orarioRilevazione=CURRENT_TIMESTAMP());
	  
	SET new.umidità=( SELECT AVG(umidità) 
                      FROM Locale L INNER JOIN Ambientali A ON A.codLocale=L.codice 
	                  WHERE A.umidità IS NOT NULL AND A.orarioRilevazione=CURRENT_TIMESTAMP());
END $$	
DELIMITER ;






/*vincolo V*/
-- Esiste un vincolo di integrità che lega gli attributi fibre proteine glucidi inForaggio e kcal/kg in Foraggio
DROP TRIGGER IF EXISTS V_calcolo_kcal;
DELIMITER $$ 
CREATE TRIGGER V_calcolo_kcal
BEFORE INSERT ON Foraggio FOR EACH ROW
BEGIN 
	SET new.kcalkg=new.proteine*3.8+new.glucidi*3.8 ;
END $$	
DELIMITER ;







/*vincolo VI*/
-- Esiste un vincolo di integrità che lega gli attributi dataInizio durata e secon-daTerapiaConsecutiva in Terapia
DROP TRIGGER IF EXISTS VI_aggiornamento_terapie;
DELIMITER $$ 
CREATE TRIGGER VI_aggiornamento_terapie
BEFORE INSERT ON Terapia FOR EACH ROW
BEGIN 
	IF (SELECT COUNT(*)
    FROM Terapia T INNER JOIN Animale A ON  T.codAnimale=A.codice
	WHERE T.dataInizio+INTERVAL(T.durata)DAY<=NEW.dataInizio)>1 AND NEW.secondaTerapiaConsecutiva IS NULL THEN
	    SET new.secondaTerapiaConsecutiva=TRUE;
	ELSE
	    SET new.secondaTerapiaConsecutiva=FALSE;
    END IF;
END $$
DELIMITER ;



