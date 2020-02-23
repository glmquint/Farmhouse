INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (20, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);

INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);

INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (11, 62, 20, 0);

INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (12, 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-04-07', 10, '10:57:01');

INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (11, 12);

INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (7, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');

INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta, codLatte)
	VALUES ('Mozzarella', 'Settesoldi', 30, 7, 1);

INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (10, 2, 641, 12, '2022-07-22', 1, 'Mozzarella', 'Settesoldi');

INSERT INTO Account (utente, password, domandaRec, rispostaRec, numTelefono, codFiscale, nome, cognome, scadenzaDoc, numDoc, dataIscrizione, codDoc, enteRilascio, tipoDoc, indirizzo, codiceCarta)
	VALUES ('Ivan34', 'mypass', 'id tincidun.Donec fermentum porttitor urna nec ullamcorpe. Nunc blandit libero vitae sem cursus molesti. Quisque commodo non lacus at eleifen. Nunc iaculis lorem ligul  at fringilla nulla laoreet . In porta mi eu aliquet congu. Morbi volutpat quam lacu  quis luctus orci ', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 1146215520, 'RSSCRL94C07G224Y', 'Carlo', 'Rossetti', '2025-03-26', 'v07tr75yu82gj80d', '2018-09-16', 'i95se15mt65hi67p', 'Proin accumsan vitae arcu eu convalli. Quisque suscipit eros a augue rhoncus vestibulu. Mauris posuere risus a consequat gravid. Aenean ultricies metus quis lorem bibendu  sit amet ornare ante hendreri. In hac habitasse platea dictums. Suspendisse efficitur sollicitudin magn  at dictum velit efficitur eget.', 'Pellentesque nec lacinia orc. Donec consectetur nunc in odio laoreet fermentu. Morbi elementum in est sed luctu.Pellentesque ut justo non magna volutpat pulvina. Cras accumsan auctor ex id vehicul. Pellentesque vel aliquet magn. Sed non nunc odi. Mauris condimentu  nulla ac tincidunt ', 'via Moretti n.23', 'a30si59rr95jh99l');

INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (default, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Ivan34', 'mypass', 10);

INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (66, 'evaso', '2019-09-17', 1, 'Domenica307', 'xforge', 3);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (67, 'evaso', '2019-09-18', 1, 'Domenica307', 'xforge', 4);
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (68, 'evaso', '2019-09-18', 0, 'Domenica307', 'xforge', 5);


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
