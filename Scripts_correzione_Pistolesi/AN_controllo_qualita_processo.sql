 USE FarmHouse;

 /* -- rimuovere questo commento per eseguire il popolamento per il testing

INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (20, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (19, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (18, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);

-- animale piuttosto sano
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-07', 92, 94, 95, 98, 92, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-06', 93, 98, 95, 95, 91, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (20, '2019-02-05', 92, 95, 95, 98, 92, 103, 967, 878, 10, 5);
-- animale frequentemente malato
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (19, '2019-02-04', 12, 34, 95, 47, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (19, '2019-02-03', 12, 38, 55, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (19, '2019-02-02', 12, 34, 95, 48, 62, 103, 967, 878, 10, 5);
-- animale che partecipa alla produzione di un altro lotto
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


/*--------------Fine script di testing,-----------------*/
/*rimuovere il commento all'inizio del file per eseguire*/

-- Ranking dei lotti che hanno saputo meglio rispettare le procedure di processo e la purezza degli ingredienti utilizzati
--
-- Vengono stilate due classifiche. La prima indica per ogni lotto un indice di discostamento rispetto al parametro da rispettare (i.e minore è meglio)
-- ed affianca un punteggio finale (generale) che tiene conto delle penalità da assegnare nel caso in cui le informazioni siano mancanti (di default +100 pt).
-- La seconda classifica è una semplice tabella pivot della prima che aumenta la leggibilità indicando, per ogni categoria valutata, il lotto che meglio si è posizionato

SET SESSION group_concat_max_len = 1000000;
CREATE OR REPLACE VIEW Ranking AS
WITH DevianzaFase AS (
SELECT CPF.codLotto, 
		F.codiceFase, 
        2*ABS(CAST(CPF.durata_fase_effettiva AS SIGNED) - CAST(F.durata_fase_ideale AS SIGNED))/(CPF.durata_fase_effettiva + F.durata_fase_ideale) AS DifferenzaDurataRelativa,
		2*ABS(CAST(CPF.temperatura_latte_effettiva AS SIGNED) - CAST(F.temperatura_latte_ideale AS SIGNED))/(CPF.temperatura_latte_effettiva + F.temperatura_latte_ideale) AS DifferenzaTemperaturaLatteRelativa ,
        2*ABS(CAST(CPF.tempo_riposo_effettiva AS SIGNED) - CAST(F.tempo_riposo_ideale AS SIGNED))/(CPF.tempo_riposo_effettiva + F.tempo_riposo_ideale) AS DifferenzaTempoRiposoRelativa
FROM ControlloParametriFase CPF INNER JOIN Fasi F ON CPF.codFase = F.codiceFase),
DevianzaParametriCantine AS (
SELECT SC.codLotto, P.codCantina, STD(P.temperatura) AS temperatura, STD(P.umidità) AS umidità
FROM stoccaggiocantine SC INNER JOIN Parametri P ON SC.codCantina = P.codCantina
GROUP BY P.codCantina),
SaluteMediaLocale AS (
	SELECT SM.*, AnimaliProduttori.codLotto 
	FROM (SELECT Ins.codAnimale, 
			AVG(Ins.tipologiaRespirazione) AS tipologiaRespirazione, 
            AVG(Ins.lucentezzaPelo) AS lucentezzaPelo, 
            AVG(Ins.vigilanza) AS vigilanza, 
            AVG(Ins.idratazione) AS idratazione, 
            AVG(Ins.deambulazione) AS deambulazione
		FROM indicisalute InS
		GROUP BY InS.codAnimale) SM INNER JOIN (SELECT Distinct(A.codice) AS codAnimale, PC.codLotto
									FROM prodottocon PC INNER JOIN Latte La ON PC.codLatte = La.codiceLatte
										INNER JOIN Animale A ON La.codAnimale = A.codice) AnimaliProduttori
									ON SM.codAnimale = AnimaliProduttori.codAnimale
)
SELECT Lo.codiceLotto, 
	ROUND(SUM(DF.DifferenzaDurataRelativa),3) AS Discostamento_medio_totale_durata_fase, 
	ROUND(SUM(DF.DifferenzaTemperaturaLatteRelativa),3) AS Discostamento_medio_totaleo_temperatura_latte, 
	ROUND(SUM(DF.DifferenzaTempoRiposoRelativa) ,3) AS Discostamento_medio_totale_tempo_riposo, 
    ROUND(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte),3) AS Deviazione_standard_relativa_sostanza_latte, 
    ROUND(AVG(DPC.temperatura),3) AS Deviazione_standard_media_temperatura, 
    ROUND(AVG(DPC.umidità),3) AS Deviazione_standard_media_umidità, 
    ROUND(1 - AVG(SML.tipologiaRespirazione) / 100 ,3)AS Discostamento_medio_da_tipologiaRespirazione_ottimale, 
    ROUND(1 - AVG(SML.lucentezzaPelo) / 100,3) AS Discostamento_medio_da_lucentezzaPelo_ottimale, 
    ROUND(1 - AVG(SML.vigilanza) / 100,3) AS Discostamento_medio_da_vigilanza_ottimale, 
    ROUND(1 - AVG(SML.idratazione) / 100,3) AS Discostamento_medio_da_idratazione_ottimale, 
    ROUND(1 - AVG(SML.deambulazione) / 100,3) AS Discostamento_medio_da_deambulazione_ottimale,
    IFNULL(ROUND(SUM(DF.DifferenzaDurataRelativa),3), 100) + -- modificare 100 con la penalità da infliggere per mancata informazione nelle varie categorie
		IFNULL(ROUND(SUM(DF.DifferenzaTemperaturaLatteRelativa),3), 100) + 
		IFNULL(ROUND(SUM(DF.DifferenzaTempoRiposoRelativa) ,3), 100) + 
		IFNULL(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte), 100) + 
		IFNULL(AVG(DPC.temperatura), 100) + 
		IFNULL(AVG(DPC.umidità),100) + 
		IFNULL(1 - AVG(SML.tipologiaRespirazione) / 100, 100) + 
		IFNULL(1 - AVG(SML.lucentezzaPelo) / 100, 100) + 
		IFNULL(1 - AVG(SML.vigilanza) / 100, 100) + 
		IFNULL(1 - AVG(SML.idratazione) / 100, 100) + 
		IFNULL(1 - AVG(SML.deambulazione) / 100, 100) AS Generale
FROM Lotto Lo INNER JOIN DevianzaFase DF ON Lo.codiceLotto = DF.codLotto
	LEFT OUTER JOIN Latte La ON La.codiceLatte IN (SELECT PC.codLatte FROM prodottocon PC WHERE PC.codLotto = Lo.codiceLotto)
    LEFT OUTER JOIN DevianzaParametriCantine DPC ON Lo.codiceLotto = DPC.codLotto
    LEFT OUTER JOIN SaluteMediaLocale SML ON Lo.codiceLotto = SML.codLotto
GROUP BY Lo.codiceLotto
ORDER BY IFNULL(ROUND(SUM(DF.DifferenzaDurataRelativa),3), 100) + -- se si è modificata la penalità nel SELECT, rispecchiare le modifiche anche quì
	IFNULL(ROUND(SUM(DF.DifferenzaTemperaturaLatteRelativa),3), 100) + 
    IFNULL(ROUND(SUM(DF.DifferenzaTempoRiposoRelativa) ,3), 100) + 
    IFNULL(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte), 100) + 
    IFNULL(AVG(DPC.temperatura), 100) + 
    IFNULL(AVG(DPC.umidità),100) + 
    IFNULL(1 - AVG(SML.tipologiaRespirazione) / 100, 100) + 
    IFNULL(1 - AVG(SML.lucentezzaPelo) / 100, 100) + 
    IFNULL(1 - AVG(SML.vigilanza) / 100, 100) + 
    IFNULL(1 - AVG(SML.idratazione) / 100, 100) + 
    IFNULL(1 - AVG(SML.deambulazione) / 100, 100);

-- la prima tabella
SELECT * FROM Ranking;

/* -- un singolo modulo
SELECT GROUP_CONCAT('Discostamento_totale_medio_parametri_di_processo') AS Categoria, R.codiceLotto AS Miglior_lotto
FROM Ranking R
WHERE R.Discostamento_totale_medio_parametri_di_processo = (SELECT MAX(R1.Discostamento_totale_medio_parametri_di_processo)
															FROM Ranking R1)
GROUP BY R.Discostamento_totale_medio_parametri_di_processo
UNION ... */

SELECT GROUP_CONCAT(CONCAT("SELECT GROUP_CONCAT('", CN.COLUMN_NAME ,
							"') AS Categoria, R.codiceLotto AS Miglior_lotto
							FROM Ranking R
							WHERE R.", CN.COLUMN_NAME ," IN (SELECT MIN(R1.", CN.COLUMN_NAME ,")
															FROM Ranking R1)
							GROUP BY ", CN.COLUMN_NAME)
    SEPARATOR ' UNION ')
FROM (SELECT COLUMN_NAME
		FROM Information_Schema.columns
		WHERE table_name = 'Ranking'
			AND COLUMN_NAME <> 'codiceLotto') CN
INTO @pivot_query;

-- SELECT @pivot_query;

-- la seconda tabella
PREPARE sql_statement FROM @pivot_query;
EXECUTE sql_statement;
