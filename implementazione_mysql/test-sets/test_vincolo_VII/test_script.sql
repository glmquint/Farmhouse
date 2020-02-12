/*Test script per il vincolo VII*/

INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (10, 'dipendenti per il lotto 10', '2019-04-07', 7, '10:57:01');
    
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta, codLatte)
VALUES ('Gorgonzola', 'Settesoldi', 30, 1, 1);

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (20, 25, 640, 62, '2022-07-22', 10, 'Gorgonzola', 'Settesoldi'); -- la scadenza è errata ma viene corretta
    
SELECT * FROM FormaggioProdotto WHERE codiceProdotto = 20; -- tutti i valori sono validi

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (20, 25, 640, 62, '2022-07-22', 11, 'Gorgonzola', 'Settesoldi'); -- lotto di appartenenza inesistente