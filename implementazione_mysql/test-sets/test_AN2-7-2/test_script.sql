INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (20, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (19, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (18, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);

/*animale piuttosto sano*/
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-07', 92, 94, 95, 98, 92, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-06', 93, 98, 95, 95, 91, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-05', 92, 95, 95, 98, 92, 103, 967, 878, 10, 5);
/*animale frequentemente malato*/
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (19, '2019-02-04', 12, 34, 95, 47, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (19, '2019-02-03', 12, 38, 55, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (19, '2019-02-02', 12, 34, 95, 48, 62, 103, 967, 878, 10, 5);
/*animale che partecipa alla produzione di un altro lotto*/
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (18, '2019-02-04', 99, 99, 99, 99, 99, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (18, '2019-02-03', 98, 98, 98, 98, 98, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (18, '2019-02-02', 97, 97, 97, 97, 97, 103, 967, 878, 10, 5);

INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (5, 62, 20, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (6, 63, 19, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (7, 64, 20, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (8, 22, 19, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (9, 32, 20, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (10, 99, 18, 0);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos) -- non usato per alcuna produzione
	VALUES (11, 99, 18, 0);


INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (10, 'Scodice dei dipendenti del primo lotto', '2019-04-07', 10, '10:57:01');
INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (11, 'codice dei dipendenti del secondo lotto', '2019-04-08', 11, '10:57:01');
INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (12, 'codice dei dipendenti del terzo lotto', '2019-04-06', 12, '10:57:01');

INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (5, 10);
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (6, 10);
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (7, 10);
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (8, 11);
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (9, 11);
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (10, 12);
/*
INSERT INTO Fasi (codiceFase, nome, parametriProcesso, durata)
	VALUES (50, 'Inizio', 57, '23:22:48');
INSERT INTO ControlloParametriFase (parametriEffettivi, codLotto, codFase)
	VALUES (59, 1, 1);
INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (30, 'Veneto', 'ricetta prima', '20:33:55');
INSERT INTO divisain (codRicetta, codFase)
	VALUES (1, 1);
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta, codLatte)
	VALUES ('Parmigiano', 'Settesoldi', 30, 30);
INSERT INTO composizioneformaggio ('Parmigiano', 'Settesoldi', 
*/