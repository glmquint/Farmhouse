
SELECT RANK() OVER (ORDER BY SUM(IF(CO.reso, 0, CO.quantità*FP.prezzo)) DESC) AS Ranking,F.nome,
		F.nomeAgriturismo,
		CONCAT(MIN(FP.prezzo), '-', MAX(FP.prezzo)) AS Fasciaprezzo,
        AVG(FP.peso) AS peso,
        GROUP_CONCAT(DISTINCT FP.lottoAppartenenza) AS lottiAppartenenza,
        F.codRicetta,
        AVG(R.gradimentoGenerale) AS gradimentoGeneraleMedio,
        AVG(R.qualitaPercepita) AS qualitaPercepitaMedia,
        AVG(R.gusto) AS gustoMedio,
		SUM(CO.quantità) AS VenditeTotali,
		100*SUM(IF(CO.reso, CO.quantità, 0 ))/SUM(CO.quantità) AS rapportoReso,
        SUM(IF(CO.reso, 0, CO.quantità)) AS NonResi,
        SUM(IF(CO.reso, 0, CO.quantità*FP.prezzo)) AS IncassoEffettivo
FROM FormaggioProdotto FP
	INNER JOIN Formaggio F ON FP.nome = F.nome AND FP.nomeAgriturismo = F.nomeAgriturismo
	INNER JOIN contenutoOrdine CO ON FP.codiceProdotto = CO.codFormaggioprodotto
    LEFT OUTER JOIN Recensione R ON FP.codiceProdotto = R.codProdotto
GROUP BY F.nome, F.nomeAgriturismo
ORDER BY SUM(IF(CO.reso, 0, CO.quantità*FP.prezzo)) DESC;

