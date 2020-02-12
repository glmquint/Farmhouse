/*Test Script per il vincolo XI*/

INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (14, 'in processazione', '2019-09-16', 0, 'Domenica307', 'xforge', 1);

INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (14, 1, 10, 0);
    
UPDATE contenutoordine
SET reso = 1 -- il prodotto viene reso e il vincolo XI aggiorna l'informazione in OrdineProdotti
WHERE codOrdine = 14
	AND codFormaggioProdotto = 1;
    
SELECT * FROM OrdineProdotti WHERE codiceOrdine = 14;
