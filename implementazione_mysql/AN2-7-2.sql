WITH DevianzaFase AS (
SELECT CPF.codLotto, F.codiceFase, 2*ABS(CPF.parametriEffettivi - F.parametriProcesso)/(CPF.parametriEffettivi + F.parametriProcesso) AS DifferenzaRelativa -- TODO:da ripetere per ogni parametro da controllare!!
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
SELECT Lo.codiceLotto, DF.codiceFase, DF.differenzaRelativa, STD(La.quantitàSostanzeDisciolte), AVG(DPC.temperatura), AVG(DPC.umidità), AVG(SML.tipologiaRespirazione), AVG(SML.lucentezzaPelo), AVG(SML.vigilanza), AVG(SML.idratazione), AVG(SML.deambulazione)
FROM Lotto Lo INNER JOIN DevianzaFase DF ON Lo.codiceLotto = DF.codLotto
	INNER JOIN Latte La ON La.codiceLatte IN (SELECT PC.codLatte FROM prodottocon PC WHERE PC.codLotto = Lo.codiceLotto)
    INNER JOIN DevianzaParametriCantine DPC ON Lo.codiceLotto = DPC.codLotto
    INNER JOIN SaluteMediaLocale SML ON Lo.codiceLotto = SML.codLotto
GROUP BY Lo.codiceLotto