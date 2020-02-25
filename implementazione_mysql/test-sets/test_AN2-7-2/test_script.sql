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

INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (50, 'Inizio', 57, 65, 32, '23:22:48');
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (51, 'Svolgimento', 58, 67, 31, '23:22:48');
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (52, 'Fine', 56, 64, 33, '23:22:48');

INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (58, 66, 32, 10, 50);
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (57, 67, 30, 10, 51);
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (57, 62, 34, 10, 52);

INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (18, 23, 89, 11, 50);
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (17, 43, 82, 11, 51);
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (17, 44, 39, 11, 52);

INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (60, 'prima meta', 37, 65, 29, '23:22:48');
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (61, 'seconda meta', 38, 37, 11, '23:22:48');

INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (18, 60, 40, 12, 60);
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (17, 40, 20, 12, 61);


INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (30, 'Veneto', 'ricetta prima', '20:33:55');
INSERT INTO divisain (codRicetta, codFase)
	VALUES (30, 50);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (30, 51);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (30, 52);

INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (40, 'Puglia', 'ricetta seconda', '20:33:55');
INSERT INTO divisain (codRicetta, codFase)
	VALUES (40, 60);
INSERT INTO divisain (codRicetta, codFase)
	VALUES (40, 61);

INSERT INTO Cantine (codice)
	VALUES (17);
INSERT INTO Cantine (codice)
	VALUES (18);

INSERT INTO stoccaggiocantine (codLotto, codCantina)
	VALUES (12, 17);
INSERT INTO stoccaggiocantine (codLotto, codCantina)
	VALUES (12, 18);

INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-05', 67, 26, 17, 17);
INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-06', 68, 26, 17, 17);

INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-07', 69, 16, 37, 18);
INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-08', 70, 36, 27, 18);
INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-09', 71, 26, 17, 18);


INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta)
	VALUES ('Parmigiano', 'Settesoldi', 15, 30);

INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta)
	VALUES ('Burrata', 'Settesoldi', 20, 40);
