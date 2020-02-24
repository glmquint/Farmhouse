CREATE OR REPLACE VIEW Valori_prodotti_venduti AS
	SELECT CO.codOrdine,
		CO.codFormaggioProdotto,
		AVG(R.gradimentoGenerale) AS gradimentoGenerale,
        AVG(R.qualitaPercepita) AS qualitaPercepita,
        AVG(R.gusto) AS gusto,
        AVG(CAST(Fa.durata_fase_ideale AS SIGNED) - CAST(CPF.durata_fase_effettiva AS SIGNED)) AS durata_fase,
        AVG(CAST(Fa.temperatura_latte_ideale  AS SIGNED)- CAST(CPF.temperatura_latte_effettiva AS SIGNED)) AS temperatura_latte,
        AVG(CAST(Fa.tempo_riposo_ideale AS SIGNED) - CAST(CPF.tempo_riposo_effettiva AS SIGNED))AS tempo_riposo,
        STD(L.quantitàSostanzeDisciolte)/AVG(L.quantitàSostanzeDisciolte)AS quantitàSostanzeDisciolte,
        AVG(INS.lucentezzaPelo) AS lucentezzaPelo,
        AVG(INS.tipologiaRespirazione) AS tipologiaRespirazione,
        AVG(INS.vigilanza) AS vigilanza,
        AVG(INS.idratazione) AS idratazione,
        AVG(INS.deambulazione) AS deambulazione,
        AVG(INS.fibre) AS fibre,
        AVG(INS.proteine) AS proteine,
        AVG(INS.glucidi) AS glucidi,
        AVG(INS.concentrazioneSali) AS concentrazioneSali,
        AVG(INS.concentrazioneVitamine) AS concentrazioneVitamine,
        CO.reso
FROM ContenutoOrdine CO LEFT OUTER JOIN FormaggioProdotto FP ON CO.codFormaggioprodotto = FP.codiceProdotto
	LEFT OUTER JOIN Recensione R ON CO.codFormaggioprodotto = R.codProdotto
	LEFT OUTER JOIN Formaggio F ON FP.nome = F.nome AND FP.nomeAgriturismo = F.nomeAgriturismo
    LEFT OUTER JOIN Lotto Lo ON FP.lottoAppartenenza = Lo.codiceLotto
    LEFT OUTER JOIN ControlloParametriFase CPF ON CPF.codLotto = Lo.codiceLotto AND CPF.codFase IN (
		SELECT DI.codFase
        FROM DivisaIn DI
        WHERE DI.codRicetta = F.codRicetta)
	LEFT OUTER JOIN Fasi Fa ON Fa.codiceFase = CPF.codFase
    LEFT OUTER JOIN Latte L ON L.codiceLatte IN (
		SELECT PC.codLatte
        FROM ProdottoCon PC
        WHERE PC.codLotto = Lo.codiceLotto)
	LEFT OUTER JOIN Animale A ON L.codAnimale = A.codice
    LEFT OUTER JOIN Indicisalute INS ON INS.codAnimale = A.codice
    GROUP BY CO.codFormaggioprodotto, CO.codOrdine;
    
    
    
/*
SELECT 'gradimentoGenerale' AS Prior, 'reso' AS reso, 'non reso' AS non_reso UNION
SELECT gradimentoGenerale,
		SUM(VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 1) AS reso, 
		SUM(1 - VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 0) AS Non_reso, 
        
       --  SUM(IF (lens = 'hard', 1, 0)) *100/ 24 + SUM(IF (lens = 'none', 1, 0)) *100/ 24 + SUM(IF (lens = 'soft', 1, 0)) *100/ 24 AS Total
FROM Valori_prodotti_venduti VPV
GROUP BY gradimentoGenerale 
UNION */

SELECT GROUP_CONCAT(CONCAT("SELECT '", column_name, "' AS Prior, 'reso' AS reso, 'non reso' AS non_reso UNION
SELECT ", column_name, ",
		CONCAT(ROUND(SUM(VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 1), 2), '%') AS reso, 
		CONCAT(ROUND(SUM(1 - VPV.reso) * 100 / (SELECT COUNT(*) FROM Valori_prodotti_venduti VPV WHERE VPV.reso = 0), 2), '%') AS Non_reso
        FROM Valori_prodotti_venduti VPV
		GROUP BY gradimentoGenerale") SEPARATOR " UNION ") 
FROM Information_schema.columns 
WHERE table_name = 'Valori_prodotti_venduti' 
	AND column_name <> 'codOrdine' 
    AND column_name <> 'codFormaggioProdotto' 
    AND column_name <> 'reso' INTO @pivot_query;
    
-- SELECT @pivot_query;

PREPARE sql_statement FROM @pivot_query;
EXECUTE sql_statement;

