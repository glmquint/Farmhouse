/*Test Script per il vincolo XII*/

INSERT INTO Spedizione (codice, dataConsegnaEffettiva, dataConsegnaPrevista, percorso, stato)
	VALUES (24, '2019-10-06', '2019-09-03', 'percorso 1, percorso 2, percorso 3', 'in preparazione');
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (34, 'in processazione', '2019-09-16', 0, 'Domenica307', 'xforge', 24);
    
SET @res = '';

SELECT CONCAT(@res, stato)
FROM OrdineProdotti
WHERE codiceOrdine = 34 INTO @res; -- inizialmente l'ordine è in processazione

UPDATE Spedizione
SET stato = 'spedita'
WHERE codice = 24;

SELECT CONCAT(@res, '->', stato)
FROM OrdineProdotti
WHERE codiceOrdine = 34 INTO @res; -- l'ordine passa a spedito

UPDATE Spedizione
SET stato = 'consegnata'
WHERE codice = 24;

SELECT CONCAT(@res, '->', stato)
FROM OrdineProdotti
WHERE codiceOrdine = 34 INTO @res; -- infine l'ordine è considerato evaso

SELECT @res;