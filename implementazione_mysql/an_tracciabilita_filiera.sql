SELECT *
FROM ContenutoOrdine CO INNER JOIN FormaggioProdotto FP ON CO.codFormaggioprodotto = FP.codiceProdotto
	INNER JOIN Formaggio F ON FP.nome = F.nome AND FP.nomeAgriturismo = F.nomeAgriturismo
    INNER JOIN Lotto Lo ON FP.lottoAppartenenza = Lo.codiceLotto
    INNER JOIN ControlloParametriFase CPF ON CPF.codLotto = Lo.codiceLotto AND CPF.codFase IN (
		SELECT DI.codFase
        FROM DivisaIn DI
        WHERE DI.codRicetta = F.codRicetta)
	INNER JOIN Fasi Fa ON Fa.codiceFase = CPF.codFase
    INNER JOIN Latte L ON L.codiceLatte IN (
		SELECT PC.codLatte
        FROM ProdottoCon PC
        WHERE PC.codLotto = Lo.codiceLotto)
	INNER JOIN Animale A ON L.codAnimale = A.codice
    INNER JOIN Indicisalute INS ON INS.codAnimale = A.codice