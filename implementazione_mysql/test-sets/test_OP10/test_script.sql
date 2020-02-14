/*Test script per l'operazione 10*/

INSERT INTO Stalla (numProgressivo, nomeAgriturismo)
	VALUES (5, 'Settesoldi');


INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (28, 20, 39, 'S', 18, 5, 5, 5, 'Settesoldi', 'bos lobe', 486, 2299, 1096);

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (10, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 28);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (11, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 28);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (12, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 28);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (13, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 28);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (14, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 28);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (15, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 28);

SELECT codLocale, COUNT(codice) FROM Animale GROUP BY codLocale;

-- nuovo locale!!
INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (29, 20, 39, 'S', 18, 5, 5, 5, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
    
SELECT codLocale, COUNT(codice) FROM Animale GROUP BY codLocale;

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (16, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 29);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (17, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 29);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (18, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 29);

INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (30, 20, 39, 'S', 18, 5, 5, 5, 'Settesoldi', 'bos lobe', 486, 2299, 1096);

SELECT codLocale, COUNT(codice) FROM Animale GROUP BY codLocale;
