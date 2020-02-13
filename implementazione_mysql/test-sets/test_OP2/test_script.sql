/*Test script per l'operazione 2*/

INSERT INTO Riproduzione (codiceRiproduzione, complicanza, data_orario, stato, codVeterinario, codiceMadre, codicePadre)
	VALUES (23, 'XXXXXX', '1977-05-19 18:13:15', '', 'BLLDNC38A18E290R', 2, 1);
    
UPDATE Riproduzione
SET complicanza = "Informazioni sulla complicanza",
	stato = 'insuccesso'
WHERE codiceRiproduzione = 23;


INSERT INTO Riproduzione (codiceRiproduzione, complicanza, data_orario, stato, codVeterinario, codiceMadre, codicePadre)
	VALUES (24, '', '1977-05-19 18:13:15', '', 'BLLDNC38A18E290R', 2, 1);

UPDATE Riproduzione
SET complicanza = "Nessuna complicanza",
	stato = 'successo'
WHERE codiceRiproduzione = 24;

SELECT * FROM riproduzione;

-- CALL OP2_registrazione_neonato(24, 'M', 'bos lobe', 'tetracerus',CURRENT_DATE(), 22, 14, 'tedesca'); -- dataDiNascita non valida
CALL OP2_registrazione_neonato(24, 'M', 'bos lobe', 'tetracerus','1977-05-19', 22, 14, 'tedesca');

SELECT * FROM Visita; -- 2 nuove visite: la madre per l'insuccesso, e il piccolo per il successo

