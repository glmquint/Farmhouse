WITH DevianzaFase AS (
SELECT F.codiceFase, 
FROM ControlloParametriFase CPF INNER JOIN Fasi F ON CPF.codFase = F.codiceFase)
SELECT *
FROM DevianzaFase;