WITH DevianzaFase AS (
SELECT CPF.codLotto, F.codiceFase, 2*ABS(CAST(CPF.parametriEffettivi AS SIGNED) - CAST(F.parametriProcesso AS SIGNED))/(CPF.parametriEffettivi + F.parametriProcesso) AS DifferenzaRelativa -- TODO:da ripetere per ogni parametro da controllare!!
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
    ROUND(AVG(SML.tipologiaRespirazione),3) AS tipologiaRespirazione_media, 
    ROUND(AVG(SML.lucentezzaPelo),3) AS lucentezzaPelo_media, 
    ROUND(AVG(SML.vigilanza),3) AS vigilanza_media, 
    ROUND(AVG(SML.idratazione),3) AS idratazione_media, 
    ROUND(AVG(SML.deambulazione),3) AS deambulazione_media,
    IFNULL((DF.differenzaRelativa /AVG(DF.codiceFase)), 100) + IFNULL(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte), 100) + IFNULL(AVG(DPC.temperatura), 100) + IFNULL(AVG(DPC.umidità),100) + IFNULL(100 - AVG(SML.tipologiaRespirazione), 100) + IFNULL(100 - AVG(SML.lucentezzaPelo), 100) + IFNULL(100 - AVG(SML.vigilanza), 100) + IFNULL(100 - AVG(SML.idratazione), 100) + IFNULL(100 - AVG(SML.deambulazione), 100) AS tot
FROM Lotto Lo INNER JOIN DevianzaFase DF ON Lo.codiceLotto = DF.codLotto
	LEFT OUTER JOIN Latte La ON La.codiceLatte IN (SELECT PC.codLatte FROM prodottocon PC WHERE PC.codLotto = Lo.codiceLotto)
    LEFT OUTER JOIN DevianzaParametriCantine DPC ON Lo.codiceLotto = DPC.codLotto
    LEFT OUTER JOIN SaluteMediaLocale SML ON Lo.codiceLotto = SML.codLotto
GROUP BY Lo.codiceLotto
ORDER BY IFNULL((DF.differenzaRelativa /AVG(DF.codiceFase)), 100) + IFNULL(STD(La.quantitàSostanzeDisciolte) / AVG(La.codiceLatte), 100) + IFNULL(AVG(DPC.temperatura), 100) + IFNULL(AVG(DPC.umidità),100) + IFNULL(100 - AVG(SML.tipologiaRespirazione), 100) + IFNULL(100 - AVG(SML.lucentezzaPelo), 100) + IFNULL(100 - AVG(SML.vigilanza), 100) + IFNULL(100 - AVG(SML.idratazione), 100) + IFNULL(100 - AVG(SML.deambulazione), 100)
