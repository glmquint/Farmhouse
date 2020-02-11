DROP TRIGGER IF EXISTS controllo_genitori;
DELIMITER $$ 
CREATE TRIGGER controllo_genitori
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
	
	
	IF new.dataDiNascita NOT IN (SELECT data_orario + INTERVAL 9 MONTH
	                           FROM Riproduzione R INNER JOIN Animale A ON A.codice=R.codAnimale
	                           WHERE new.idMadre=R.codice AND new.idPadre=R.codicepadre) THEN
    signal sqlstate '70006' SET MESSAGE_TEXT='la data di nascita non è valida';
	END IF;
END $$	
DELIMITER ;










DROP TRIGGER IF EXISTS codicePadre_riproduzione;
DELIMITER $$ 
CREATE TRIGGER codicePadre_riproduzione
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











DROP TRIGGER IF EXISTS aggiornamento_ambientali;
DELIMITER $$ 
CREATE TRIGGER aggiornamento_ambientali
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







DROP TRIGGER IF EXISTS calcolo_kcal;
DELIMITER $$ 
CREATE TRIGGER calcolo_kcal
BEFORE INSERT ON Foraggio FOR EACH ROW
BEGIN 
	SET new.kcalkg=new.proteine*3.8+new.glucidi*3.8 ;
END $$	
DELIMITER ;








DROP TRIGGER IF EXISTS aggiornamento_terapie;
DELIMITER $$ 
CREATE TRIGGER aggiornamento_terapie
BEFORE INSERT ON Terapia FOR EACH ROW
BEGIN 
	IF (SELECT COUNT(*)
    FROM Terapia T INNER JOIN Animale A ON  T.codAnimale=A.codice
	WHERE dataInizio+INTERVAL(durata)DAY<=CURRENT_DATE)>1 AND secondaTerapiaConsecutiva IS NULL THEN
	    SET new.secondaTerapiaConsecutiva=TRUE;
	ELSE
	    SET new.secondaTerapiaConsecutiva=FALSE;
    END IF;
END $$
DELIMITER ;



