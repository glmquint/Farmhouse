SELECT *
FROM ContenutoOrdine CO LEFT OUTER JOIN FormaggioProdotto FP ON CO.codFormaggioprodotto = FP.codiceProdotto
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