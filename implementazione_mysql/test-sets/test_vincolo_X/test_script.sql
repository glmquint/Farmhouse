/*Test Script per il vincolo X*/
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta, codLatte)
	VALUES ('Mozzarellona1', 'Settesoldi', '03:38:18', 1, 1);
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta, codLatte)
	VALUES ('Mozzarellona2', 'Settesoldi', '03:38:18', 1, 1);

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (2, 2, 641, 5, '2022-07-22', 1, 'Mozzarellona1', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (3, 2, 641, 99, '2022-07-22', 1, 'Mozzarellona2', 'Settesoldi');

INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (default, 'richiesta online', CURRENT_DATE(), 0, 'Domenica307', 'xforge', 1),
			(default, 'richiesta online', CURRENT_DATE(), 0, 'Domenica307', 'xforge', 1),
            (default, 'richiesta online', CURRENT_DATE(), 0, 'Domenica307', 'xforge', 1),
            (default, 'richiesta online', CURRENT_DATE(), 0, 'Domenica307', 'xforge', 1);

INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (2, 3, 10, 0), /*solo questo ordine deve andare in preparazione*/
			(3, 2, 10, 0), 
            (4, 3, 10, 0), (4, 2, 10, 0), 
            (5, 2, 10, 0), (5, 3, 10, 0);



SELECT * 
FROM OrdineProdotti OP INNER JOIN ContenutoOrdine CO ON OP.codiceOrdine = CO.codOrdine
						INNER JOIN FormaggioProdotto FP ON codFormaggioProdotto = FP.codiceProdotto;
