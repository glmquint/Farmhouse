/*Test script per l'operazione 6*/

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (5, 25, 50, 62, '2022-07-22', 1, 'Bitto', 'Settesoldi');

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (6, 30, 80, 62, '2022-07-22', 1, 'Bitto', 'Settesoldi');

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (7, 10, 15, 62, '2022-07-22', 1, 'Bitto', 'Settesoldi');

INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (43, 'in processazione', '2019-09-16', 0, 'Domenica307', 'xforge', 1);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (43, 5, 2, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (43, 6, 1, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (43, 7, 3, 0);
    
-- 2*25€ + 1*30€ + 3*10€ = 110€
    
SELECT * FROM Pagamenti;
CALL OP6_processamento_ordini(43);
SELECT * FROM Pagamenti;
