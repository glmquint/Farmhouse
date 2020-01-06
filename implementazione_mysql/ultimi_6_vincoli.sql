/* --MODULE--

DROP TRIGGER IF EXISTS nome_trigger;
DELIMITER $$
CREATE TRIGGER nome_trigger
BEFORE INSERT ON Tabella
FOR EACH ROW 
BEGIN 
IF  THEN
signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE Madre non è femmina';
END IF
END $$
DELIMITER;

*/

DROP TRIGGER IF EXISTS scadenza_formaggio_prodotto;
DELIMITER $$
CREATE TRIGGER scadenza_formaggio_prodotto
BEFORE INSERT ON FormaggioProdotto
FOR EACH ROW 
BEGIN 
/*
DATE_ADD('2012-01-01', INTERVAL Matricola Day)
DATE_ADD('2012-01-01 12:12:12', INTERVAL Matricola Minute)
*/
SET NEW.scadenza = (SELECT * /*DATE_ADD(DataProd, INTERVAL datediff(0, durata) DAY)*/ FROM Lotto INNER JOIN formaggioprodotto ON StockAppartenenza = codiceLotto WHERE stockAppartenenza = codiceLotto LIMIT 1);
END $$
DELIMITER ;

INSERT INTO FormaggioProdotto VALUES (default, 2, 641, 62, 41, '2022-07-22', 'Bitto', 'Settesoldi');

SELECT * FROM formaggioprodotto

SELECT * FROM formaggioprodotto
SELECT DATE_ADD(day, DATEDIFF(day, 0, '2019-03-20 18:13:15'), '18:13:15')

SELECT DATE_ADD(day, '2019-03-20', EXTRACT(DAY FROM '18:13:15') DAY) FROM Lotto