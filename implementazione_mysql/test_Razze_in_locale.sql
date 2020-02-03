/*In verità non so bene cosa faccia questo script,
  non mi ricordo quando è stato fatto,
  ma in ogni caso non dovrebbe essere di interesse per il progetto!*/
WITH MaxLocale AS
(select COUNT(*) AS NumAnimali
from Animale A INNER JOIN Locale L ON A.codLocale = L.CodiceLocale
GROUP BY L.codiceLocale
ORDER BY COUNT(*) DESC)
SELECT A.Razza, COUNT(*)
FROM Animale A INNER JOIN (SELECT L.codiceLocale
						FROM Locale L INNER JOIN Animale A1 ON A1.codLocale = L.CodiceLocale
						GROUP BY L.codiceLocale
						HAVING COUNT(*) >= ALL (SELECT ML.NumAnimali
							FROM MaxLocale ML)) AS D
						ON A.codLocale = D.codiceLocale
GROUP BY A.Razza
ORDER BY COUNT(*) DESC