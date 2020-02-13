/*Test script per l'operazione 4*/

-- setup
INSERT INTO Mungitrice (codice, longitudine, latitudine, marca, modello)
	VALUES (17, 121.995, 20.170, 'andretti', 'mungitrix 9000');
INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 17, '2019-12-28 06:25:53', 50);


-- 3 silos di prova
INSERT INTO Silos (codice, capacità, livello)
	VALUES (5, 50, 20);
INSERT INTO Silos (codice, capacità, livello)
	VALUES (6, 50, 15);
INSERT INTO Silos (codice, capacità, livello)
	VALUES (7, 50, 0);

-- nel primo silos
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (5, 52, 2, 5);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (6, 51, 2, 5);

-- nel secondo silos
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (7, 22, 2, 6);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (8, 19, 2, 6);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (9, 23, 2, 6);

INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (7, 17);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (8, 17);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (9, 17);


-- test
INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 17, '2019-02-10 06:25:53', 21);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (10, 55, 2, NULL); -- composizione simile al silos 5


INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 17, '2019-02-11 06:25:53', 31);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (11, 20, 2, NULL); -- composizione simile al silos 6


INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 17, '2019-02-12 06:25:53', 45);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (12, 20, 2, NULL); -- composizione simile al silos 6 ma non c'è più spazio, quindi trabocca
							  -- nel primo silo vuoto, ossia il 7
                       
                       
INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 17, '2019-02-13 06:25:53', 45);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (13, 20, 2, NULL); -- composizione simile al silos 6 ma non c'è più spazio, e siccome
							  -- non ci sono silo vuoti, ne viene creato uno con valori di default



INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (10, 17);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (11, 17);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (12, 17);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (13, 17);





CALL OP4_stoccaggio_latte('2019-02-10 06:25:53', 2, 17, 10);
CALL OP4_stoccaggio_latte('2019-02-11 06:25:53', 2, 17, 11);
CALL OP4_stoccaggio_latte('2019-02-12 06:25:53', 2, 17, 12);
CALL OP4_stoccaggio_latte('2019-02-13 06:25:53', 2, 17, 13);


SELECT * FROM Latte L INNER JOIN Silos S ON L.codSilos = S.codice;

-- SELECT * FROM logtable;
