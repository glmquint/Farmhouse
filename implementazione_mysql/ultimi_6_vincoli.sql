/* --MODULE--

DROP TRIGGER IF EXISTS nome_trigger;
DELIMITER $$
CREATE TRIGGER nome_trigger
BEFORE INSERT ON Tabella
FOR EACH ROW 
BEGIN 
IF  THEN
	signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE: ';
END IF;
SET NEW.attributo = ();
END $$
DELIMITER ;

*/

/*-------------------------------------------------------------OK

Esiste un vincolo di integrità che lega dataProd e durata in Lotto e deperi-bilità in Formaggio a scadenza in Formaggio Prodotto

DROP TABLE IF EXISTS Lotto;
CREATE TABLE Lotto
(
	codiceLotto	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	codDipendenti	 VARCHAR(255),
	dataProd DATE NOT NULL,
	codLab	TINYINT UNSIGNED NOT NULL,
	durata	INT, -- da intendere in giorni prima della deperibilità
	primary key(codiceLotto)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS  FormaggioProdotto ;
CREATE TABLE  FormaggioProdotto 
(
	codiceProdotto	INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	prezzo	TINYINT NOT NULL,
	peso	VARCHAR(6),
	rimastiInStock	SMALLINT,
	scadenza	DATE NOT NULL,
	lottoAppartenenza	SMALLINT UNSIGNED NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	primary key (codiceProdotto),
    foreign key (lottoAppartenenza) references Lotto(codiceLotto),
	foreign key (nome) references Formaggio(nome),
	foreign key (nomeAgriturismo) references Formaggio(nomeAgriturismo)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

*/

DROP TRIGGER IF EXISTS VII_scadenza_formaggio_prodotto;
DELIMITER $$
CREATE TRIGGER VII_scadenza_formaggio_prodotto
BEFORE INSERT ON FormaggioProdotto
FOR EACH ROW 
BEGIN
IF (SELECT L.codiceLotto FROM Lotto L WHERE L.codiceLotto = NEW.LottoAppartenenza ) IS NULL THEN
	signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE: Impossibile trovare il lotto di appartenenza del formaggio';
ELSE
	SET NEW.Scadenza = (SELECT L.DataProd FROM Lotto L WHERE L.codiceLotto = NEW.LottoAppartenenza)
		+ INTERVAL (SELECT F.deperibilita FROM Formaggio F WHERE F.nome = NEW.nome AND F.nomeAgriturismo = NEW.nomeAgriturismo)DAY;
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------

Esiste un vincolo di integrità che lega dataPartenza in PrenotazioneStanza a data in Pagamenti

DROP TABLE IF EXISTS  Pagamenti ;
CREATE TABLE  Pagamenti 
(
	codPagamento	INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	tipoPagamento	VARCHAR(20),
	totaleCosto	SMALLINT NOT NULL,
	data_ora_Pagamento	TIMESTAMP,
	codCliente	CHAR(16) NOT NULL,
	primary key (codPagamento),
	foreign key (codCliente) references Cliente(codCarta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS  PrenotazioneStanza ;
CREATE TABLE  PrenotazioneStanza 
(
	dataArrivo	DATE NOT NULL,
	numStanza	TINYINT UNSIGNED NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	codCliente	CHAR(16) NOT NULL,
	dataPartenza	DATE NOT NULL,
	primary key (dataArrivo, numStanza, nomeAgriturismo, codCliente),
	foreign key (numStanza,nomeAgriturismo) references Stanza(numStanza,codAgriturismo),
	foreign key (codCliente) references Cliente(codCarta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/

DROP TRIGGER IF EXISTS VIII_data_pagamento_prenotazione_stanza;
DELIMITER $$
CREATE TRIGGER VIII_data_pagamento_prenotazione_stanza
BEFORE INSERT ON Pagamenti
FOR EACH ROW 
BEGIN 
IF NEW.tipoPagamento = 'stanza' THEN
	SET NEW.dataPagamento = (SELECT PS.dataPartenza FROM PrenotazioneStanza PS WHERE PS.codCliente = NEW.codCliente ORDER BY PS.dataPartenza DESC);
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------

Esiste un vincolo di integrità che lega anticipo in cliente, a tipoPagamentoe a totaleCosto in Pagamenti.

DROP TABLE IF EXISTS  Cliente ;
CREATE TABLE  Cliente 
(
	codCarta	CHAR(16) NOT NULL UNIQUE,
	anticipo	SMALLINT ,
	primary key(codCarta)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Pagamenti ;
CREATE TABLE  Pagamenti 
(
	codPagamento	INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	tipoPagamento	VARCHAR(20),
	totaleCosto	SMALLINT NOT NULL,
	data_ora_Pagamento	TIMESTAMP,
	codCliente	CHAR(16) NOT NULL,
	primary key (codPagamento),
	foreign key (codCliente) references Cliente(codCarta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

*/

DROP TRIGGER IF EXISTS IX_anticipo_su_pagamento;
DELIMITER $$
CREATE TRIGGER IX_anticipo_su_pagamento
BEFORE INSERT ON Pagamenti
FOR EACH ROW 
BEGIN 
/*TODO: controllare se l'anticipo deve essere considerato anche per pagamenti di escursioni e di acquisti online*/
SET NEW.totaleCosto = NEW.totaleCosto - (SELECT C.anticipo FROM Cliente C WHERE C.codCarta = NEW.codCliente);
END $$
DELIMITER ;

/*-------------------------------------------------------------

Esiste un vincolo tra quantità in contenutoordine, rimastiinstock in Formag-gioProdotto e stato in OrdineProdotti.

DROP TABLE IF EXISTS  contenutoordine ;
CREATE TABLE  contenutoordine 
(
	codOrdine	SMALLINT UNSIGNED NOT NULL,
	codFormaggioprodotto	INT UNSIGNED NOT NULL,
	quantità	TINYINT NOT NULL,
	reso	BOOLEAN NOT NULL,
	primary key (codOrdine, codFormaggioprodotto),
	foreign key (codFormaggioprodotto) references FormaggioProdotto(codiceProdotto),
	foreign key (codOrdine) references OrdineProdotti(codiceOrdine)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  FormaggioProdotto ;
CREATE TABLE  FormaggioProdotto 
(
	codiceProdotto	INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	prezzo	TINYINT NOT NULL,
	peso	VARCHAR(6),
	rimastiInStock	SMALLINT,
	scadenza	DATE NOT NULL,
	lottoAppartenenza	SMALLINT UNSIGNED NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	primary key (codiceProdotto),
    foreign key (lottoAppartenenza) references Lotto(codiceLotto),
	foreign key (nome) references Formaggio(nome),
	foreign key (nomeAgriturismo) references Formaggio(nomeAgriturismo)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  OrdineProdotti ;
CREATE TABLE  OrdineProdotti 
(
	codiceOrdine	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	stato	ENUM('in processazione','in preparazione','spedito','evaso'),
	data_ordine	DATE NOT NULL,
	tipoConsegnaReso	BOOLEAN,
	utente	VARCHAR(20) NOT NULL,
	password	VARCHAR(16)NOT NULL,
	codSpedizione	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceOrdine),
	foreign key (utente) references Account(utente),
	foreign key (password) references  Account(password),
	foreign key (codSpedizione) references Spedizione(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

*/
DROP PROCEDURE IF EXISTS aggiorna_rimasti_in_stock;
DELIMITER $$
CREATE PROCEDURE aggiorna_rimasti_in_stock
	(IN _ordine SMALLINT UNSIGNED)
BEGIN
	DECLARE finito INTEGER DEFAULT 0;
	DECLARE prodotto INT UNSIGNED;
	DECLARE cursore CURSOR FOR
		SELECT CO.codFormaggioProdotto
        FROM contenutoOrdine CO
        WHERE CO.codOrdine = _ordine;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO prodotto;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
		UPDATE FormaggioProdotto
        SET rimastiInStock = rimastiInStock - (SELECT quantità 
												FROM contenutoOrdine 
                                                WHERE codOrdine = _ordine 
													AND codFormaggioProdotto = prodotto)
		WHERE codiceProdotto = prodotto;
	END LOOP preleva;
	CLOSE cursore;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS X_controllo_disponibilita_ordine;
DELIMITER $$
CREATE TRIGGER X_controllo_disponibilita_ordine
AFTER INSERT ON ContenutoOrdine
FOR EACH ROW
BEGIN
/*se c'è almeno un prodotto ordinato che non è disponibile in stock*/
IF 0 < (SELECT COUNT(*)
		FROM contenutoOrdine CO INNER JOIN FormaggioProdotto FP ON CO.codFormaggioProdotto = FP.codiceProdotto
		WHERE CO.codOrdine = NEW.codOrdine
			AND CO.quantità > FP.rimastiInStock) THEN
	UPDATE OrdineProdotti
    SET stato = 'in processazione'
    WHERE codiceOrdine = NEW.codOrdine;
ELSE
 
    /*Aggiorna la quantità di rimasti in stock per ogni prodotto ordinato*/  
	/*MAKE SURE THAT secure.mode IS DISABLED IN Preferences-->SQL.Editor!!*/
    CALL aggiorna_rimasti_in_stock(NEW.codOrdine);
                            
    /*Infine aggiorna lo stato dell'ordine*/
	UPDATE OrdineProdotti
    SET stato = 'in preparazione'
    WHERE codiceOrdine = NEW.codOrdine;
END IF;


END $$
DELIMITER ;

/*-------------------------------------------------------------

Esiste un vincolo di integrità tra reso in contenutoordine e stato e tipoCon-segnaReso in Ordine Prodotti

DROP TABLE IF EXISTS  contenutoordine ;
CREATE TABLE  contenutoordine 
(
	codOrdine	SMALLINT UNSIGNED NOT NULL,
	codFormaggioprodotto	INT UNSIGNED NOT NULL,
	quantità	TINYINT NOT NULL,
	reso	BOOLEAN NOT NULL,
	primary key (codOrdine, codFormaggioprodotto),
	foreign key (codFormaggioprodotto) references FormaggioProdotto(codiceProdotto),
	foreign key (codOrdine) references OrdineProdotti(codiceOrdine)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  OrdineProdotti 
(
	codiceOrdine	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	stato	ENUM('in processazione','in preparazione','spedito','evaso'),
	data_ordine	DATE NOT NULL,
	tipoConsegnaReso	BOOLEAN,
	utente	VARCHAR(20) NOT NULL,
	password	VARCHAR(16)NOT NULL,
	codSpedizione	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceOrdine),
	foreign key (utente) references Account(utente),
	foreign key (password) references  Account(password),
	foreign key (codSpedizione) references Spedizione(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

*/

DROP TRIGGER IF EXISTS XI_stato_ordine;
DELIMITER $$
CREATE TRIGGER XI_stato_ordine
AFTER UPDATE ON contenutoordine
FOR EACH ROW 
BEGIN 
IF NEW.reso = 1 THEN
	UPDATE OrdineProdotti
    SET tipoConsegnaReso = 1
    WHERE codiceOrdine = NEW.codOrdine;
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------

Esiste un vincolo di integrità tra stato in Spedizione e stato in OrdineProdot

DROP TABLE IF EXISTS  Spedizione ;
CREATE TABLE  Spedizione 
(
	codice	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	dataConsegnaEffettiva	DATE NOT NULL,
	dataConsegnaPrevista	DATE NOT NULL,
	percorso	VARCHAR(255),
	stato	ENUM('spedita','in consegna','consegnata'),
	primary key(codice)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  OrdineProdotti 
(
	codiceOrdine	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	stato	ENUM('in processazione','in preparazione','spedito','evaso'),
	data_ordine	DATE NOT NULL,
	tipoConsegnaReso	BOOLEAN,
	utente	VARCHAR(20) NOT NULL,
	password	VARCHAR(16)NOT NULL,
	codSpedizione	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceOrdine),
	foreign key (utente) references Account(utente),
	foreign key (password) references  Account(password),
	foreign key (codSpedizione) references Spedizione(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/

DROP TRIGGER IF EXISTS XII_stato_spedizione;
DELIMITER $$
CREATE TRIGGER XII_stato_spedizione
AFTER UPDATE ON Spedizione
FOR EACH ROW 
BEGIN 
IF NEW.stato = 'spedita' THEN
	UPDATE OrdineProdotti
    SET stato = 'spedito'
    WHERE codSpedizione = NEW.codice;
ELSEIF NEW.stato = 'consegnata' THEN
	UPDATE OrdineProdotti
    SET stato = 'evaso'
    WHERE codSpedizione = NEW.codice;
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------

Trigger non ancora espresso ma estremamente utile nella registrazione di nuovi animali
Descrizione: ad ogni nuovo animale viene associato il numero più basso disponibile come codice GPS,
	di fatto implementando un AUTO-INCREMENT su un valore non chiave*/
    
DROP TRIGGER IF EXISTS XIII_nuovo_GPS;
DELIMITER $$
CREATE TRIGGER XIII_nuovo_GPS
BEFORE INSERT ON Animale
FOR EACH ROW
BEGIN
	SET NEW.codiceGPS = first_available_GPS();
END $$
DELIMITER ;