/*Test script per l'operazione 9*/

-- account con cliente già registrato (x30si59xx95xx99l)
INSERT INTO Cliente (codCarta, anticipo)
	VALUES ('x30si59xx95xx99l', 41);
INSERT INTO Account (utente, password, domandaRec, rispostaRec, numTelefono, codFiscale, nome, cognome, scadenzaDoc, numDoc, dataIscrizione, codDoc, enteRilascio, tipoDoc, indirizzo, codiceCarta)
	VALUES ('capo844', 'yaggyd0g', 'Quale era la tua password prima che tu te la dimenticassi?', 'Una password facilmente dimenticabile', 1146215520, 'RSSCRL94C07G224Y', 'Marco', 'Felici', '2025-03-26', 'v07tr75yu82gj80d', '2018-09-16', 'i95se15mt65hi67p', 'Ente di rilascio di documenti d\'identità', 'Documento cartaceo', 'via Moretti n.23', 'x30si59xx95xx99l');

-- cliente non registrato (l96hr40ny03xy95a)
INSERT INTO Account (utente, password, domandaRec, rispostaRec, numTelefono, codFiscale, nome, cognome, scadenzaDoc, numDoc, dataIscrizione, codDoc, enteRilascio, tipoDoc, indirizzo, codiceCarta)
VALUES ('anima866', 'odessa44', 'Domanda di recuero non inizializzata', 'Risposta alla domanda di recupero', 4592720333, 'PLMPLA92R12L049V', 'Paolo', 'Palmieri', '2020-04-12', 'o57sr75ye77gj23m', '2007-05-14', 'u34ab81oh65rf69d', 'Ente di rilascio di documenti d\'identità', 'Documento digitale', 'via Gatti n.85', 'l96hr40ny03xy95a');

SELECT * FROM Cliente;