/*Test script per l'operazione 8*/

-- per non sconvolgere le distribuzioni nei locali, si elimina la redistribuzione automatica
DROP TRIGGER IF EXISTS OP10_ridistribuzione_animali;


INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (45, 20, 39, 'S', 18, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (40, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, 60.780, '2019-05-12 18:13:15', 30, 45);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (41, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, 60.780, '2019-05-12 18:13:15', 31, 45);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (42, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, 60.780, '2019-05-12 18:13:15', 32, 45);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (43, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', -117.249, 60.780, '2019-05-12 18:13:15', 33, 45); -- disperso
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (44, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 17.249, 160.780, '2019-05-12 18:13:15', 34, 45); -- disperso

INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (55, 20, 39, 'S', 18, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (50, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 35, 55);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (51, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 36, 55);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (52, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', -216.249, 11.780, '2019-05-12 18:13:15', 37, 55); -- disperso
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (53, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 38, 55);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (54, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 39, 55);

INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (65, 20, 39, 'S', 18, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (60, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 35, 65);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (61, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 36, 65);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (62, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 37, 65);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (63, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 38, 65);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (64, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 216.249, 11.780, '2019-05-12 18:13:15', 39, 65);
-- nessun disperso

INSERT INTO AreaPascolo (codiceArea)
	VALUES (10);
INSERT INTO AreaPascolo (codiceArea)
	VALUES (11);
INSERT INTO AreaPascolo (codiceArea)
	VALUES (12);


-- baricentro della zona: 60, 117
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (22, 10, 62.948, 110.393);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (23, 10, 58.948, 116.393);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (24, 10, 60.948, 126.393);

-- baricentro della zona: 11, 216
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (32, 11, 12.948, 216.393);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (33, 11, 10.948, 215.393);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (34, 11, 11.948, 219.393);

-- baricentro della zona: 11, 216
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (42, 12, 12.948, 216.393);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (43, 12, 10.948, 215.393);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (44, 12, 11.948, 219.393);



INSERT INTO AttivitaPascolo (codiceAttivita, giorno_orario, codLocale, codArea)
	VALUES (60, '2019-05-12 08:50:44', 45, 10);

INSERT INTO AttivitaPascolo (codiceAttivita, giorno_orario, codLocale, codArea)
	VALUES (61, '2019-05-12 07:50:44', 55, 11);

INSERT INTO AttivitaPascolo (codiceAttivita, giorno_orario, codLocale, codArea)
	VALUES (62, '2019-05-12 07:50:44', 65, 12);



CALL attivita_in_data('2019-05-12', @void);
INSERT INTO animali_dispersi VALUES('2019-05-12 19:13:37', @void);
SELECT * FROM animali_dispersi;

-- reimposta trigger dopo il test

DELIMITER $$
CREATE TRIGGER OP10_ridistribuzione_animali
AFTER INSERT ON Locale
FOR EACH ROW 
BEGIN 
	CALL ridistrubuzione_in_stalla(NEW.codiceStalla, NEW.codiceLocale);
END $$
DELIMITER ;
