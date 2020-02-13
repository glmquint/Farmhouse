/*Test script per l'operazione 5*/

/*----primo locale-----*/

-- i valori rientrano nei limiti del locale -> nessun problema

INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (10, 28, 39, 'S', 8, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);


INSERT INTO Visivi (codiceVisivo, livelloSporcizia, orarioRilevazione, codLocale)
	VALUES (default, 1, '2019-09-16 23:39:20', 10);
INSERT INTO Visivi (codiceVisivo, livelloSporcizia, orarioRilevazione, codLocale)
	VALUES (default, 2, '2019-09-16 23:39:20', 10);

INSERT INTO Ambientali (codiceAmbientale, temperatura, umidità, orarioRilevazione, codLocale)
	VALUES (default, 15, 48, '2019-09-27 21:35:52', 10);
INSERT INTO Ambientali (codiceAmbientale, temperatura, umidità, orarioRilevazione, codLocale)
	VALUES (default, 16, 46, '2019-09-27 21:35:52', 10);

INSERT INTO CompostiVolatili (codiceVolatili, concentrazioneMetano, concentrazioneAzoto, orarioRilevazione, codLocale)
	VALUES (default, 1, 2, '2019-05-23 22:55:56', 10);
INSERT INTO CompostiVolatili (codiceVolatili, concentrazioneMetano, concentrazioneAzoto, orarioRilevazione, codLocale)
	VALUES (default, 1, 3, '2019-05-23 22:55:56', 10);


/*----secondo locale-----*/

-- i valori rilevati sono chiaramente oltre i limiti -> nuova richiesta d'intervento di pulizia

INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (11, 28, 39, 'S', 8, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);


INSERT INTO Visivi (codiceVisivo, livelloSporcizia, orarioRilevazione, codLocale)
	VALUES (default, 78, '2019-09-16 23:39:20', 11);
INSERT INTO Visivi (codiceVisivo, livelloSporcizia, orarioRilevazione, codLocale)
	VALUES (default, 92, '2019-09-16 23:39:20', 11);

INSERT INTO Ambientali (codiceAmbientale, temperatura, umidità, orarioRilevazione, codLocale)
	VALUES (default, 15, 48, '2019-09-27 21:35:52', 11);
INSERT INTO Ambientali (codiceAmbientale, temperatura, umidità, orarioRilevazione, codLocale)
	VALUES (default, 16, 46, '2019-09-27 21:35:52', 11);

INSERT INTO CompostiVolatili (codiceVolatili, concentrazioneMetano, concentrazioneAzoto, orarioRilevazione, codLocale)
	VALUES (default, 80, 90, '2019-05-23 22:55:56', 11);
INSERT INTO CompostiVolatili (codiceVolatili, concentrazioneMetano, concentrazioneAzoto, orarioRilevazione, codLocale)
	VALUES (default, 75, 89, '2019-05-23 22:55:56', 11);


SELECT L.temperatura, L.umidità, PL.* FROM Locale L INNER JOIN PuliziaLocale PL ON L.codiceLocale = PL.codLocale;

CALL OP5_controllo_igiene_locali();

SELECT L.temperatura, L.umidità, PL.* FROM Locale L INNER JOIN PuliziaLocale PL ON L.codiceLocale = PL.codLocale;