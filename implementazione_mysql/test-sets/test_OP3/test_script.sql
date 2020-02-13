/*Test script per l'operazione 3*/

INSERT INTO Cliente (codCarta, anticipo)
	VALUES ('a30si59rr95jh99h', 50); -- anticipo da detrarre al pagamento totale (-50€)

INSERT INTO Stanza (numStanza, codAgriturismo, costoGiornaliero, suite, numLetti, tipoLetti)
	VALUES (5, 'Settesoldi', 110, 'suite', 2, 'Matrimoniale, king-size'); -- costo giornaliero della stanza (110€)

INSERT INTO ServizioAggiuntivo (tipoServizio, costo)
	VALUES ('piscina', 20); -- costo del servizio (20€)
    
INSERT INTO ServizioAggiuntivo (tipoServizio, costo)
	VALUES ('degustazione', 40); -- costo del servizio (40€)
    
INSERT INTO PrenotazioneStanza (dataArrivo, numStanza, nomeAgriturismo, codCliente, dataPartenza)
	VALUES ('2019-05-05', 5, 'Settesoldi', 'a30si59rr95jh99h', '2019-05-15'); -- 10 notti

INSERT INTO ServizioperStanza (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio, dataFineUtilizzo)
	VALUES ('2019-05-05', '2019-05-05', 5, 'Settesoldi', 'a30si59rr95jh99h', 'piscina', '2019-05-07'); -- 3 giorni di utilizzo
INSERT INTO ServizioperStanza (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio, dataFineUtilizzo)
	VALUES ('2019-05-10', '2019-05-05', 5, 'Settesoldi', 'a30si59rr95jh99h', 'degustazione', '2019-05-13'); -- 4 giorni di utilizzo


CALL OP3_incassa_prenotazioni_del_giorno('2019-05-15'); -- normalmente lo scheduler chiama giornalmente questa funzione


-- pagamento totale: 110€*10 + 20€*3 + 40€*4 - 50€ = 1270€
SELECT * FROM Pagamenti;
