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
	VALUES (11, 2, 641, 12, '2022-07-22', 12, 'Parmigiano', 'Settesoldi');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (12, 2, 641, 12, '2022-07-22', 12, 'Pecorino', 'Settesoldi');

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
	VALUES (11, 2, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Ivan34', 'mypass', 12);

INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (66, 'evaso', '2019-09-17', 1, 'Domenica307', 'xforge', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (67, 'evaso', '2019-09-18', 1, 'Domenica307', 'xforge', 1);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (68, 'evaso', '2019-09-18', 0, 'Domenica307', 'xforge', 1);


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
	VALUES (68, 10, 15, 0);
