/*Test Script per il vincolo XIV*/

INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 1, '2019-12-28 06:25:53', 94); -- funziona

INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (1, 1, '2019-12-28 06:25:53', 94); -- non funziona
