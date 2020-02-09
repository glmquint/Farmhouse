


INSERT INTO Agriturismo (Nome)
	VALUES ('Borgo Tramonte');
INSERT INTO Agriturismo (Nome)
	VALUES ('Le Valli di Castelfiorentino');
INSERT INTO Agriturismo (Nome)
	VALUES ('Campetroso');
INSERT INTO Agriturismo (Nome)
	VALUES ('Fattoria I Ricci - Agriresort & SPA');
INSERT INTO Agriturismo (Nome)
	VALUES ('Selvoli');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Palazzino');
INSERT INTO Agriturismo (Nome)
	VALUES ('Le Murelle');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Castelluccio Country Resort');
INSERT INTO Agriturismo (Nome)
	VALUES ('Renello');
INSERT INTO Agriturismo (Nome)
	VALUES ('Eco Organic Resort and Luxury Glamping Sant Egle');
INSERT INTO Agriturismo (Nome)
	VALUES ('Podere la Piana');
INSERT INTO Agriturismo (Nome)
	VALUES ('Renai e Monte');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Greppo');
INSERT INTO Agriturismo (Nome)
	VALUES ('I Pianelli');
INSERT INTO Agriturismo (Nome)
	VALUES ('Pieve Sprenna');
INSERT INTO Agriturismo (Nome)
	VALUES ('Settesoldi');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Piaggione');
INSERT INTO Agriturismo (Nome)
	VALUES ('La Landuccia');
INSERT INTO Agriturismo (Nome)
	VALUES ('La Palazzina');
INSERT INTO Agriturismo (Nome)
	VALUES ('Poggiacolle');

INSERT INTO Stalla (numProgressivo, nomeAgriturismo)
	VALUES (default, 'Settesoldi');
INSERT INTO CaratteristichePerTipoLocale (specieOspitata, altezza, lunghezza, larghezza, capienzaMax, pavimentazione)
	VALUES ('bos lobe', 486, 2299, 1096, 45, 'trattamento antiscivolo con resine epissidiche');
INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (default, 28, 39, 'S', 8, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (default, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1967-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (default, 'F', 'bos lobe', 'tetracerus', NULL, NULL, '1967-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2013-04-12 19:43:25', 2, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (default, 'F', 'bos lobe', 'tetracerus', 1, 2, '1967-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);
INSERT INTO Fornitore (ragioneSociale, indirizzo, partitaIva)
	VALUES ('Bellini S.p.a. ', 'viale Fiore n.20', 96179312746);
INSERT INTO acquistoanimale (codiceAnimale, ragioneSocialeFornitore, dataAcquisto, dataArrivo)
	VALUES (1, 'Bellini S.p.a. ', '1941-06-14', '1959-03-04');
INSERT INTO Veterinario (codiceFiscale, nome, cognome, contatto)
	VALUES ('BLLDNC38A18E290R', 'Domenico', 'Bellini', 6773261698);
INSERT INTO Riproduzione (codiceRiproduzione, complicanza, data_orario, stato, codVeterinario, codiceMadre, codicePadre)
	VALUES (default, 'Sed ut ligula sit amet dolor ultrices efficitu. Cras varius nisl mollis mollis tempo. Nullam velit m  fermentum vitae lacinia u  consectetur vitae null. Suspendisse sed arcu vel eros convallis sagittis non ut torto. Sed sed tortor in erat facilisis pretium commodo in nis. ', '2019-03-20 18:13:15', 'successo', 'BLLDNC38A18E290R', 1, 2);
INSERT INTO SchedaGestazione (codiceGestazione, codRiproduzione, codVeterinario)
	VALUES (default, 1, 'BLLDNC38A18E290R');
INSERT INTO Visivi (codiceVisivo, livelloSporcizia, orarioRilevazione, codLocale)
	VALUES (default, 1, '2019-09-16 23:39:20', 1);
INSERT INTO Ambientali (codiceAmbientale, temperatura, umidità, orarioRilevazione, codLocale)
	VALUES (default, 1, 48, '2019-09-27 21:35:52', 1);
INSERT INTO CompostiVolatili (codiceVolatili, concentrazioneMetano, concentrazioneAzoto, orarioRilevazione, codLocale)
	VALUES (default, 1, 18, '2019-05-23 22:55:56', 1);
INSERT INTO PuliziaLocale (codLocale, data_orarioRilevazione, stato, personale)
	VALUES (1, '2019-10-22 20:42:53', 'effettuato', 'Donec vulputate risus du  in faucibus libero tempor i. Proin quis erat condimentu  aliquet dolor eleifen  interdum dolo. Vivamus condimentum lorem nec libero convalli  sed auctor quam malesuad. Maecenas eget nibh sit amet ante efficitur aliqua. Mauris eu cursus sapie. Nulla sit ');
INSERT INTO Foraggio (fibre, proteine, glucidi, cereali, frutta, piante, forma, kcalkg)
	VALUES (103, 967, 878, 39, 3, 10, 'insilato', 5500);
INSERT INTO Acqua (concentrazioneSali, concentrazioneVitamine)
	VALUES (10, 5);
INSERT INTO Pasto (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (103, 967, 878, 10, 5);
INSERT INTO PastoPerLocale (giorno_orario, codLocale, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES ('2019-01-04 01:39:20', 1, 103, 967, 878, 10, 5);
INSERT INTO Mangiatoia (codice, quantitàRestante, codLocale)
	VALUES (default, 5, 1);
INSERT INTO Abbeveratoio (codice, quantitàRestante, codLocale)
	VALUES (default, 49, 1);
INSERT INTO AreaPascolo (codiceArea)
	VALUES (default);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (default, 1, 62.948, 116.393);
INSERT INTO AttivitaPascolo (codiceAttivita, giorno_orario, codLocale, codArea)
	VALUES (default, '2019-05-12 07:50:44', 1, 1);
INSERT INTO Mungitrice (codice, longitudine, latitudine, marca, modello)
	VALUES (default, 121.995, 20.170, 'laoreet i. Sed id consectetur ipsu. Vivamus mollis magna in lectus finibu  quis vulputate turpis facilisi.Proin vitae imperdiet nequ. Pellentesque nisl veli  congue a consequat i  sollicitudin efficitur ero. Nulla facilis. Sed viverra velit eget velit vehicula loborti. Pellentesque semper ', 'ut ullamcorpe. Quisque sit amet augue eget purus tincidunt port. Vestibulum vel tortor molesti  ullamcorper felis i  aliquet ero. Morbi magna sapie  pharetra nec pretium i  sollicitudin quis metu. Sed porttitor condimentum nisl quis suscipi. Etiam et orci risu. Integer sed ');
INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (1, 1, '2019-12-18 06:25:53', 94);
INSERT INTO Silos (codice, capacità, livello)
	VALUES (default, 488, 661);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (default, 62, 1, 0);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (1, 1);
INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (default, 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-04-07', 10, '10:57:01');
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (1, 1);
INSERT INTO Cantine (codice)
	VALUES (default);
INSERT INTO stoccaggiocantine (codLotto, codCantina)
	VALUES (1, 1);
INSERT INTO Magazzini (codice)
	VALUES (default);
INSERT INTO stoccaggiomagazzini (codLotto, codMagazzino)
	VALUES (1, 1);
INSERT INTO Scaffalature (codCantina, codice)
	VALUES (1, 4);
INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-04', 67, 26, 17, 1);
INSERT INTO Scaffali (codice, codMagazzino)
	VALUES (0, 1);
INSERT INTO Fasi (codiceFase, nome, parametriProcesso, durata)
	VALUES (default, 'Maecenas mattis ex id elementum molesti. Donec in facilisis just. Nam vel leo a sem sodales vestibulu. Nulla pharetra erat a justo dignissi  quis volutpat nulla rutru. Proin convallis urna laoreet mollis matti. Vivamus id placerat ligul. Aliquam nunc nis  vestibulum et lorem ', 'Duis consequat aliquet augu  non pulvinar eni. Suspendisse sagittis tellus vitae nibh sodales volutpa. Duis lobortis arcu dolo  in rhoncus magna dapibus maximu. Aliquam quis nisi eu ligula suscipit ultricies sit amet quis eni. Morbi nec lorem magn.Aliquam vestibulum risus metu  et ', '23:22:48');
INSERT INTO ControlloParametriFase (parametriEffettivi, codLotto, codFase)
	VALUES ('Class aptent taciti sociosqu ad litora torquent per conubia nostr  per inceptos himenaeo. Aliquam sit amet est mass. Proin eget accumsan dolo. Aliquam erat volutpa. Pellentesque lobortis lorem vel nisi iaculis euismod id quis mauri.Nullam tincidunt lorem eu dolor dapibus pretiu. In vehicula ', 1, 1);
INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (default, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');
INSERT INTO divisain (codRicetta, codFase)
	VALUES (1, 1);
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta, codLatte)
	VALUES ('Bitto', 'Settesoldi', '03:38:18', 1, 1);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (2, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Visita (codiceVisita, esito, descrizione, dataEffettiva, dataProgrammata, codAnimale, codVeterinario)
	VALUES (default, 'positiva', 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-05-20', '2019-03-06', 3, 'BLLDNC38A18E290R');
INSERT INTO Esame (codiceEsame, descrizione, dataEsame, macchinario, nome, codAnimale, codVeterinario)
	VALUES (default, 'Vivamus urna feli  scelerisque quis neque e  ornare dapibus nun. Morbi in nulla vel risus iaculis lacini. Proin eget mauris vel urna dapibus gravid. In at pharetra lore. Quisque at facilisis ipsu. Cras vehicula ut velit in aucto. Ut risus arc  maximus ', '2019-09-12', 'amet varius risu  nec accumsan ligul. Cras feugiat urna non rhoncus posuer.Mauris sagittis risus in metus feugia  et tempus mi aliqua. Donec quis eros veli. Cras sollicitudin felis eget orci consequa  at sodales magna tincidun. Mauris quis mauris qua. Lorem ipsum ', 'est sed pulvina. Vestibulum vitae velit vehicul  finibus dui i  convallis turpi.Vivamus et enim torto. Ut facilisis finibus sempe. Curabitur blandit rutrum metu. Nulla rutrum nibh sed ante euismod cursu. Donec vitae ligula molli  pretium nisl ege  hendrerit mass. ', 3, 'BLLDNC38A18E290R');
INSERT INTO Terapia (codiceTerapia, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)
	VALUES (default, '2019-04-12', 14, 0, 2);
INSERT INTO Farmaco (nome, principioAttivo, dosaggio)
	VALUES ('VITAMINA E 30 MG FIALA 1 ML >10<','TOCOFEROLO ACETATO ALFA','30MG');
INSERT INTO compostada (codTerapia, nomeFarmaco, posologia)
	VALUES (1, 'VITAMINA E 30 MG FIALA 1 ML >10<', 'Nunc pretium arcu cursu  fringilla ex sagitti  volutpat just. Nullam magna puru  feugiat in dui ne  gravida scelerisque nis. Aliquam in risus consequa  ullamcorper est sit ame  rhoncus se. Duis id maximus le.Nullam sed ex aliquet risus imperdiet porttito. ');
INSERT INTO SchedaMedica (codiceScheda, massaMagra, carenze, patologie, dataScheda, rispostaOculare, emocromo, spessoreZoccolo, fegato, cuore, pancreas, codAnimale, codVeterinario)
	VALUES (default, 'Nam placerat ligula ant  in ', 'commod  feugiat ex a  dignissim ', 'du. Morbi faucibus molestie ', '2019-08-25', 'pharetra eget dia. Aliquam ', '.Proin suscipit dolor le  ', 'Donec eu semper arc.', 'sollicitudin neque nec elit scelerisque ', 'tristiqu  nisi nisi suscipit torto  ', 'ornare fermentu.Cras a ', 2, 'BLLDNC38A18E290R');
INSERT INTO DisturbiComportamentali (entità, nome, codScheda)
	VALUES ('Aenean cursus magna mauri  vel euismod ex sagittis a. Nulla rutrum dui nec semper lacini. Etiam porta sit amet lectus ac condimentu. Morbi nibh le  semper nec enim qui  tincidunt tempor ligul. Curabitur sed imperdiet es.Proin aliquam leo vel rutrum loborti. ', 'est sed pulvina. Vestibulum vitae velit vehicul  finibus dui i  convallis turpi.Vivamus et enim torto. Ut facilisis finibus sempe. Curabitur blandit rutrum metu. Nulla rutrum nibh sed ante euismod cursu. Donec vitae ligula molli  pretium nisl ege  hendrerit mass. ', 1);
INSERT INTO Lesioni (tipologia, parteDelCorpo, entità, codScheda)
	VALUES ('Aenean cursus magna mauri  vel euismod ex sagittis a. Nulla rutrum dui nec semper lacini. Etiam porta sit amet lectus ac condimentu. Morbi nibh le  semper nec enim qui  tincidunt tempor ligul. Curabitur sed imperdiet es.Proin aliquam leo vel rutrum loborti. ', 'Fusce et faucibus feli. Phasellus sempe  orci sed mattis consequa  massa libero ultricies tellu  at ultrices nisi mi eu dolo.Pellentesque vitae congue lectu. In id nunc bibendu  feugiat arcu a  lobortis tellu. Nunc eget sapien ac arcu facilisis mattis quis at ', 'at est ut magna vestibulum varius eu a ligul. Maecenas laoreet orci id est aliquam tincidun. Nullam aliquet nec orci eget porttito. Quisque iaculis id neque a commod. Phasellus aliquet enim sed sapien feugia  ut iaculis urna vehicul. Sed ex urn  pretium vitae ligula ', 1);
INSERT INTO Cliente (codCarta, anticipo)
	VALUES ('a30si59rr95jh99l', 41);
INSERT INTO Pagamenti (codPagamento, tipoPagamento, totaleCosto, dataPagamento, codCliente)
	VALUES (default, 'Donec vulputate risus du  in faucibus libero tempor i. Proin quis erat condimentu  aliquet dolor eleifen  interdum dolo. Vivamus condimentum lorem nec libero convalli  sed auctor quam malesuad. Maecenas eget nibh sit amet ante efficitur aliqua. Mauris eu cursus sapie. Nulla sit ', 689, '2019-08-26 20:13:25', 'a30si59rr95jh99l');
INSERT INTO Stanza (numStanza, codAgriturismo, costoGiornaliero, suite, numLetti, tipoLetti)
	VALUES (0, 'Settesoldi', 109, 'singola', 8, 'velit in hendreri. Aenean eu hendrerit just. Nulla pellentesque quis odio sed hendreri. Morbi non erat eu nulla semper tincidun. Vestibulum vel mi a nibh mollis eleifen.Aenean malesuada sollicitudin dapibu. Pellentesque posuere maximus sapie  vitae rhoncus nibh tempus no. Donec lobortis luctus ');
INSERT INTO PrenotazioneStanza (dataArrivo, numStanza, nomeAgriturismo, codCliente, dataPartenza)
	VALUES ('2019-01-05', 0, 'Settesoldi', 'a30si59rr95jh99l', '2019-07-07 06:01:55');
INSERT INTO ServizioAggiuntivo (tipoServizio, costo)
	VALUES ('catering', 78);
INSERT INTO ServizioperStanza (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio, dataFineUtilizzo)
	VALUES ('2019-01-03', '2019-01-05', 0, 'Settesoldi', 'a30si59rr95jh99l', 'catering', '2019-03-02');
INSERT INTO Guida (codFisc, nome, cognome, contatto)
	VALUES ('GRSMGH82H54E897X', 'Margherita', 'Grassi', 4306886115);
INSERT INTO Escursione (codice, giorno_orario, codGuida)
	VALUES (default, '2019-12-14 20:59:04', 'GRSMGH82H54E897X');
INSERT INTO PrenotazioneEscursione (dataPrenotazione, codEscursione, codCliente)
	VALUES ('2019-01-03', 1, 'a30si59rr95jh99l');
INSERT INTO Itinerario (codice, numSentieri, codAgriturismo)
	VALUES (default, 'voglia famoso', 'Settesoldi');
INSERT INTO legataa (codEscursione, codItinerario)
	VALUES (1, 1);
INSERT INTO Tappe (nome, tempoPermanenza)
	VALUES ('braccio secondo', '06:52:43');
INSERT INTO compostoda (codItinerario, nomeTAppa)
	VALUES (1, 'braccio secondo');
INSERT INTO Account (utente, password, domandaRec, rispostaRec, numTelefono, codFiscale, nome, cognome, scadenzaDoc, numDoc, dataIscrizione, codDoc, enteRilascio, tipoDoc, indirizzo, codiceCarta)
	VALUES ('Domenica307', 'xforge', 'id tincidun.Donec fermentum porttitor urna nec ullamcorpe. Nunc blandit libero vitae sem cursus molesti. Quisque commodo non lacus at eleifen. Nunc iaculis lorem ligul  at fringilla nulla laoreet . In porta mi eu aliquet congu. Morbi volutpat quam lacu  quis luctus orci ', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 1146215520, 'RSSCRL94C07G224Y', 'Carlo', 'Rossetti', '2025-03-26', 'v07tr75yu82gj80d', '2018-09-16', 'i95se15mt65hi67p', 'Proin accumsan vitae arcu eu convalli. Quisque suscipit eros a augue rhoncus vestibulu. Mauris posuere risus a consequat gravid. Aenean ultricies metus quis lorem bibendu  sit amet ornare ante hendreri. In hac habitasse platea dictums. Suspendisse efficitur sollicitudin magn  at dictum velit efficitur eget.', 'Pellentesque nec lacinia orc. Donec consectetur nunc in odio laoreet fermentu. Morbi elementum in est sed luctu.Pellentesque ut justo non magna volutpat pulvina. Cras accumsan auctor ex id vehicul. Pellentesque vel aliquet magn. Sed non nunc odi. Mauris condimentu  nulla ac tincidunt ', 'via Moretti n.23', 'a30si59rr95jh99l');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (default, 2, 641, 62, '2022-07-22', 1, 'Bitto', 'Settesoldi');
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (default, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Domenica307', 'xforge', 1);
INSERT INTO Spedizione (codice, dataConsegnaEffettiva, dataConsegnaPrevista, percorso, stato)
	VALUES (default, '2019-10-06', '2019-09-03', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'spedita');
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (default, 'in processazione', '2019-09-16', 0, 'Domenica307', 'xforge', 1);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (1, 1, 10, 0);
INSERT INTO CentridiSmistamento (codice, nome, indirizzo, contatto)
	VALUES (default, 'sagittis ipsum ultricies u. Integer ultricies magna eget justo volutpat consequa.Phasellus vulputate ultricies matti. Nunc laoreet odio urn  ut posuere sem porttitor e. Integer et leo augu. Phasellus ut porta era. Etiam vel sem molesti  mollis felis a  molestie ero. ', 'strada Russo n.83', 9184236689);
INSERT INTO processatada (codSpedizione, codcentro) 
	VALUES (1, 1);