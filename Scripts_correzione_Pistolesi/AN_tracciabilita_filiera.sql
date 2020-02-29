 USE FarmHouse;

 /* -- rimuovere questo commento per eseguire il popolamento per il testing

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (20, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-08', 13, 24, 85, 47, 62, 103, 967, 878, 10, 5);

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (21, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (21, '2019-02-07', 52, 34, 85, 48, 72, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (21, '2019-02-08', 13, 29, 85, 57, 62, 103, 967, 878, 10, 5);


INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (11, 62, 20, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (12, 65, 21, 0);

INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (12, 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-04-07', 10, '10:57:01');

INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (11, 12);
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (12, 12);

INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (7, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');
INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (8, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');
INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (9, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');

INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (20, 'prima fase', 35, 22, 96, '23:22:48');
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (36, 29, 49, 12, 20);
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (21, 'seconda fase', 25, 28, 56, '23:22:48');
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (36, 29, 49, 12, 21);
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (22, 'seconda fase', 25, 28, 56, '23:22:48');
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (36, 29, 49, 12, 22);
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (23, 'seconda fase', 25, 28, 56, '23:22:48');
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (36, 29, 49, 12, 23);

INSERT INTO divisain (codRicetta, codFase)
	VALUES (7, 20);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (7, 21);

INSERT INTO divisain (codRicetta, codFase)
	VALUES (8, 20);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (8, 23);

INSERT INTO divisain (codRicetta, codFase)
	VALUES (9, 21);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (9, 22);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (9, 23);

INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta)
	VALUES ('Mozzarella', 'Settesoldi', 30, 7);
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta)
	VALUES ('Parmigiano', 'Settesoldi', 30, 8);
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta)
	VALUES ('Pecorino', 'Settesoldi', 30, 9);

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (10, 2, 641, 12, '2022-07-22', 12, 'Mozzarella', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (11, 5, 541, 12, '2022-07-22', 12, 'Parmigiano', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (12, 7, 441, 12, '2022-07-22', 12, 'Pecorino', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (20, 3, 645, 12, '2022-07-22', 12, 'Mozzarella', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (21, 4, 543, 12, '2022-07-22', 12, 'Parmigiano', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (22, 9, 448, 12, '2022-07-22', 12, 'Pecorino', 'Settesoldi');

INSERT INTO Account (utente, password, domandaRec, rispostaRec, numTelefono, codFiscale, nome, cognome, scadenzaDoc, numDoc, dataIscrizione, codDoc, enteRilascio, tipoDoc, indirizzo, codiceCarta)
	VALUES ('Ivan34', 'mypass', 'id tincidun.Donec fermentum porttitor urna nec ullamcorpe. Nunc blandit libero vitae sem cursus molesti. Quisque commodo non lacus at eleifen. Nunc iaculis lorem ligul  at fringilla nulla laoreet . In porta mi eu aliquet congu. Morbi volutpat quam lacu  quis luctus orci ', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 1146215520, 'RSSCRL94C07G224Y', 'Carlo', 'Rossetti', '2025-03-26', 'v07tr75yu82gj80d', '2018-09-16', 'i95se15mt65hi67p', 'Proin accumsan vitae arcu eu convalli. Quisque suscipit eros a augue rhoncus vestibulu. Mauris posuere risus a consequat gravid. Aenean ultricies metus quis lorem bibendu  sit amet ornare ante hendreri. In hac habitasse platea dictums. Suspendisse efficitur sollicitudin magn  at dictum velit efficitur eget.', 'Pellentesque nec lacinia orc. Donec consectetur nunc in odio laoreet fermentu. Morbi elementum in est sed luctu.Pellentesque ut justo non magna volutpat pulvina. Cras accumsan auctor ex id vehicul. Pellentesque vel aliquet magn. Sed non nunc odi. Mauris condimentu  nulla ac tincidunt ', 'via Moretti n.23', 'a30si59rr95jh99l');

INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (6, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Domenica307', 'xforge', 10);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (7, 8, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Ivan34', 'mypass', 10);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (8, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Domenica307', 'xforge', 11);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (9, 8, 7, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Ivan34', 'mypass', 11);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (10, 3, 4, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Domenica307', 'xforge', 12);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (11, 2, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 3, 'Ivan34', 'mypass', 12);

INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (12, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 8, 'Domenica307', 'xforge', 20);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (13, 8, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 9, 'Ivan34', 'mypass', 20);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (14, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ',7, 'Domenica307', 'xforge', 21);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (15, 8, 7, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Ivan34', 'mypass', 21);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (16, 3, 4, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 1, 'Domenica307', 'xforge', 22);
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (17, 2, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 7, 'Ivan34', 'mypass', 22);


INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (66, 'evaso', '2019-09-17', 1, 'Domenica307', 'xforge', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (67, 'evaso', '2019-09-18', 1, 'Domenica307', 'xforge', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (68, 'evaso', '2019-09-18', 0, 'Domenica307', 'xforge', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (69, 'evaso', '2019-09-17', 1, 'Ivan34', 'mypass', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (70, 'evaso', '2019-09-18', 1, 'Ivan34', 'mypass', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (71, 'evaso', '2019-09-18', 0, 'Ivan34', 'mypass', 1);


INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (66, 10, 10, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (66, 11, 5, 1);
    
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (67, 10, 7, 1);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (67, 11, 5, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (67, 12, 10, 0);

INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (68, 20, 15, 0);

INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (69, 20, 10, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (69, 21, 5, 1);
    
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (70, 20, 10, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (70, 21, 5, 1);
    
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (71, 20, 10, 0);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (71, 21, 5, 1);
    
    
/*--------------Fine script di testing,-----------------*/
/*rimuovere il commento all'inizio del file per eseguire*/


-- Analisi dei singoli prodotti venduti alla ricerca di pattern per prevedere le caratteristiche fonte di reso
--
-- Il risultato è un filtro bayesiano che indica, per ogni caratteristica rilevata (evento a priori),
-- la distribuzione rispetto all'evento di reso (evento a posteriori).
-- In linea di massima, se la distribuzione è omogenea (i.e il verificarsi di una caratteristica ha la
-- stessa probabilità di verificare un reso rispetto alle altre), allora non è presente una relazione tra i due eventi,
-- mentre se la distribuzione è concentrata sul verificarsi di una condizione a priori, allora potrebbe esserci una
-- forte correlazione tra quella caratteristica ed il fenomeno di reso.

SET SESSION group_concat_max_len = 1000000;

CREATE OR REPLACE VIEW Valori_prodotti_venduti AS
	SELECT CO.codOrdine,
		CO.codFormaggioProdotto,
		AVG(R.gradimentoGenerale) AS gradimentoGenerale,
        AVG(R.qualitaPercepita) AS qualitaPercepita,
        AVG(R.gusto) AS gusto,
        AVG(CAST(Fa.durata_fase_ideale AS SIGNED) - CAST(CPF.durata_fase_effettiva AS SIGNED)) AS durata_fase,
        AVG(CAST(Fa.temperatura_latte_ideale  AS SIGNED)- CAST(CPF.temperatura_latte_effettiva AS SIGNED)) AS temperatura_latte,
        AVG(CAST(Fa.tempo_riposo_ideale AS SIGNED) - CAST(CPF.tempo_riposo_effettiva AS SIGNED))AS tempo_riposo,
        100*STD(L.quantitàSostanzeDisciolte)/AVG(L.quantitàSostanzeDisciolte)AS quantitàSostanzeDisciolte,
        AVG(INS.lucentezzaPelo) AS lucentezzaPelo,
        AVG(INS.tipologiaRespirazione) AS tipologiaRespirazione,
        AVG(INS.vigilanza) AS vigilanza,
        AVG(INS.idratazione) AS idratazione,
        AVG(INS.deambulazione) AS deambulazione,
        AVG(INS.fibre) AS fibre,
        AVG(INS.proteine) AS proteine,
        AVG(INS.glucidi) AS glucidi,
        AVG(INS.concentrazioneSali) AS concentrazioneSali,
        AVG(INS.concentrazioneVitamine) AS concentrazioneVitamine,
        CO.reso
FROM ContenutoOrdine CO LEFT OUTER JOIN FormaggioProdotto FP ON CO.codFormaggioprodotto = FP.codiceProdotto
	LEFT OUTER JOIN Recensione R ON CO.codFormaggioprodotto = R.codProdotto
	LEFT OUTER JOIN Formaggio F ON FP.nome = F.nome AND FP.nomeAgriturismo = F.nomeAgriturismo
    LEFT OUTER JOIN Lotto Lo ON FP.lottoAppartenenza = Lo.codiceLotto
    LEFT OUTER JOIN ControlloParametriFase CPF ON CPF.codLotto = Lo.codiceLotto AND CPF.codFase IN (
		SELECT DI.codFase
        FROM DivisaIn DI
        WHERE DI.codRicetta = F.codRicetta)
	LEFT OUTER JOIN Fasi Fa ON Fa.codiceFase = CPF.codFase
    LEFT OUTER JOIN Latte L ON L.codiceLatte IN (
		SELECT PC.codLatte
        FROM ProdottoCon PC
        WHERE PC.codLotto = Lo.codiceLotto)
	LEFT OUTER JOIN Animale A ON L.codAnimale = A.codice
    LEFT OUTER JOIN Indicisalute INS ON INS.codAnimale = A.codice
    GROUP BY CO.codFormaggioprodotto, CO.codOrdine;
    
    
    
/*
SELECT 'gradimentoGenerale' AS Prior, 'reso' AS reso, 'non reso' AS non_reso UNION
SELECT gradimentoGenerale,
		SUM(VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 1) AS reso, 
		SUM(1 - VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 0) AS Non_reso, 
        
       --  SUM(IF (lens = 'hard', 1, 0)) *100/ 24 + SUM(IF (lens = 'none', 1, 0)) *100/ 24 + SUM(IF (lens = 'soft', 1, 0)) *100/ 24 AS Total
FROM Valori_prodotti_venduti VPV
GROUP BY gradimentoGenerale 
UNION */

SELECT GROUP_CONCAT(CONCAT("SELECT '", column_name, "' AS Prior, 'reso' AS reso, 'non reso' AS non_reso UNION
SELECT ROUND(", column_name, ", 1),
		CONCAT(ROUND(SUM(VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 1), 2), '%') AS reso, 
		CONCAT(ROUND(SUM(1 - VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 0), 2), '%') AS Non_reso
        FROM Valori_prodotti_venduti VPV
		GROUP BY ROUND(", column_name, ", 1)") SEPARATOR " UNION ") 
FROM Information_schema.columns 
WHERE table_name = 'Valori_prodotti_venduti' 
	AND column_name <> 'codOrdine' 
    AND column_name <> 'codFormaggioProdotto' 
    AND column_name <> 'reso' INTO @pivot_query;
    
-- SELECT @pivot_query;

PREPARE sql_statement FROM @pivot_query;
EXECUTE sql_statement;

