
SET SESSION group_concat_max_len = 1000000;

CREATE OR REPLACE VIEW Ranking AS
WITH DevianzaFase AS (
SELECT CPF.codLotto, 
		F.codiceFase, 
        2*ABS(CAST(CPF.parametriEffettivi AS SIGNED) - CAST(F.parametriProcesso AS SIGNED))/(CPF.parametriEffettivi + F.parametriProcesso) AS DifferenzaRelativa -- TODO:da ripetere per ogni parametro da controllare!!
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
	ROUND(DF.differenzaRelativa /AVG(DF.codiceFase),3) AS Discostamento_totale_medio_parametri_di_processo, 
    ROUND(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte),3) AS Deviazione_standard_relativa_sostanza_latte, 
    ROUND(AVG(DPC.temperatura),3) AS Deviazione_standard_media_temperatura, 
    ROUND(AVG(DPC.umidità),3) AS Deviazione_standard_media_umidità, 
    ROUND(1 - AVG(SML.tipologiaRespirazione) / 100 ,3)AS Discostamento_medio_da_tipologiaRespirazione_ottimale, 
    ROUND(1 - AVG(SML.lucentezzaPelo) / 100,3) AS Discostamento_medio_da_lucentezzaPelo_ottimale, 
    ROUND(1 - AVG(SML.vigilanza) / 100,3) AS Discostamento_medio_da_vigilanza_ottimale, 
    ROUND(1 - AVG(SML.idratazione) / 100,3) AS Discostamento_medio_da_idratazione_ottimale, 
    ROUND(1 - AVG(SML.deambulazione) / 100,3) AS Discostamento_medio_da_deambulazione_ottimale,
    IFNULL((DF.differenzaRelativa /AVG(DF.codiceFase)), 100) + IFNULL(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte), 100) + IFNULL(AVG(DPC.temperatura), 100) + IFNULL(AVG(DPC.umidità),100) + IFNULL(1 - AVG(SML.tipologiaRespirazione) / 100, 100) + IFNULL(1 - AVG(SML.lucentezzaPelo) / 100, 100) + IFNULL(1 - AVG(SML.vigilanza) / 100, 100) + IFNULL(1 - AVG(SML.idratazione) / 100, 100) + IFNULL(1 - AVG(SML.deambulazione) / 100, 100) AS Generale
FROM Lotto Lo INNER JOIN DevianzaFase DF ON Lo.codiceLotto = DF.codLotto
	LEFT OUTER JOIN Latte La ON La.codiceLatte IN (SELECT PC.codLatte FROM prodottocon PC WHERE PC.codLotto = Lo.codiceLotto)
    LEFT OUTER JOIN DevianzaParametriCantine DPC ON Lo.codiceLotto = DPC.codLotto
    LEFT OUTER JOIN SaluteMediaLocale SML ON Lo.codiceLotto = SML.codLotto
GROUP BY Lo.codiceLotto
ORDER BY IFNULL((DF.differenzaRelativa /AVG(DF.codiceFase)), 100) + IFNULL(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte), 100) + IFNULL(AVG(DPC.temperatura), 100) + IFNULL(AVG(DPC.umidità),100) + IFNULL(1 - AVG(SML.tipologiaRespirazione) / 100, 100) + IFNULL(1 - AVG(SML.lucentezzaPelo) / 100, 100) + IFNULL(1 - AVG(SML.vigilanza) / 100, 100) + IFNULL(1 - AVG(SML.idratazione) / 100, 100) + IFNULL(1 - AVG(SML.deambulazione) / 100, 100);


SELECT * FROM Ranking;

/*
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


PREPARE sql_statement FROM @pivot_query;
EXECUTE sql_statement;