/*Test script per il vincolo VIII*/

INSERT INTO Cliente (codCarta, anticipo)
	VALUES ('a30si59rr95jh99g', 50);

INSERT INTO Stanza (numStanza, codAgriturismo, costoGiornaliero, suite, numLetti, tipoLetti)
	VALUES (4, 'Settesoldi', 110, 'suite', 2, 'Matrimoniale, king-size');

INSERT INTO ServizioAggiuntivo (tipoServizio, costo)
	VALUES ('piscina', 20);
    
INSERT INTO ServizioAggiuntivo (tipoServizio, costo)
	VALUES ('discoteca', 40);
    
INSERT INTO PrenotazioneStanza (dataArrivo, numStanza, nomeAgriturismo, codCliente, dataPartenza)
	VALUES ('2019-05-05', 4, 'Settesoldi', 'a30si59rr95jh99g', '2019-05-15');

INSERT INTO ServizioperStanza (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio, dataFineUtilizzo)
	VALUES ('2019-05-05', '2019-05-05', 4, 'Settesoldi', 'a30si59rr95jh99g', 'piscina', '2019-05-07');
INSERT INTO ServizioperStanza (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio, dataFineUtilizzo)
	VALUES ('2019-05-10', '2019-05-05', 4, 'Settesoldi', 'a30si59rr95jh99g', 'discoteca', '2019-05-13');


INSERT INTO Pagamenti (codPagamento, tipoPagamento, totaleCosto, dataPagamento, codCliente)
	VALUES (30, 'stanza', 1320, '', 'a30si59rr95jh99g'); -- vincolo VIII compila la data di pagamento, vincolo IX si occupa dell'anticipo
    
SELECT * FROM pagamenti WHERE codPagamento = 30;
