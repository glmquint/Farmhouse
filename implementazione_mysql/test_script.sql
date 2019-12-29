DROP DATABASE IF EXISTS FarmHouseTest;
CREATE DATABASE FarmHouseTest;
USE FarmHouseTest;

DROP TABLE IF EXISTS Locale;
CREATE TABLE Locale
(
	codice INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    PRIMARY KEY (codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO Locale VALUES (2);

DROP TABLE IF EXISTS Animale;
CREATE TABLE Animale
(
	codice	INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	sesso ENUM('iwjendi', 'ciawediuwbefiaubef') NOT NULL,
    specie VARCHAR(3),
    famiglia TINYTEXT,
    idMadre TINYINT(1) UNSIGNED,
    codLocale INT UNSIGNED NOT NULL,
    PRIMARY KEY (codice),
    FOREIGN KEY (codLocale) REFERENCES Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO Animale VALUES (default, 1, 'quest bella specie', 'famigliola lunga tinytext', 1, 2);
INSERT INTO Animale VALUES (default, 2, 'quest bella speciiiiie', 'famigliooooooooooola lunga tinytext', 38, 2);

DROP TABLE IF EXISTS Terapia;
CREATE TABLE Terapia
(
	codTerapia INT UNSIGNED NOT NULL AUTO_INCREMENT,
    codLocale INT UNSIGNED,
    codAnimale INT UNSIGNED,
    PRIMARY KEY (codTerapia, codAnimale), 
	FOREIGN KEY (codLocale) REFERENCES Locale(codice),
    FOREIGN KEY (codAnimale) REFERENCES Animale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO Terapia VALUES (35, 2, 2);
INSERT INTO Terapia VALUES (36, 2, 2);
