/*Test script per l'operazione 7*/

INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (10001, 20, 39, 'S', 18, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (55, 'F', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2013-04-12 19:43:25', 2, 1);


SELECT A.codLocale, T.* FROM Terapia T INNER JOIN Animale A ON T.codAnimale = A.codice WHERE A.codice = 55;

INSERT INTO Terapia (codiceTerapia, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)
	VALUES (default, '2019-03-12', 14, 0, 55);

SELECT A.codLocale, T.* FROM Terapia T INNER JOIN Animale A ON T.codAnimale = A.codice WHERE codAnimale = 55;

INSERT INTO Terapia (codiceTerapia, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)
	VALUES (default, '2019-04-12', 14, 0, 55); -- un mese di distanza, non è consecutiva

SELECT A.codLocale, T.* FROM Terapia T INNER JOIN Animale A ON T.codAnimale = A.codice WHERE codAnimale = 55;

INSERT INTO Terapia (codiceTerapia, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)
	VALUES (default, '2019-04-13', 14, 0, 55); -- consecutiva

SELECT A.codLocale, T.* FROM Terapia T INNER JOIN Animale A ON T.codAnimale = A.codice WHERE codAnimale = 55;

INSERT INTO Terapia (codiceTerapia, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)
	VALUES (default, '2019-04-14', 14, 0, 55); -- terzaconsecutiva -> quarantena

SELECT A.codLocale, T.* FROM Terapia T INNER JOIN Animale A ON T.codAnimale = A.codice WHERE codAnimale = 55;
