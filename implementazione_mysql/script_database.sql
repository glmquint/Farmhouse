/* Di ciascun attributo è necessario specificarne il tipo [VARCHAR(n) | [tiny]int(m)..], il valore di default [default 0 | user | null...], e i vincoli [NOT NULL | unique]*/
/*I valori percentuali sono espressi con TINYINT UNSIGNED, il cui valor massimo è 255. Servono quindi dei triggers per verificare che il valore non superi il 100(%)*/
DROP DATABASE IF EXISTS FarmHouse;
CREATE DATABASE FarmHouse;
USE FarmHouse;


DROP TABLE IF EXISTS Agriturismo;
CREATE TABLE Agriturismo
(
	Nome	VARCHAR(30) NOT NULL unique,
	primary key(Nome)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Stalla;
CREATE TABLE Stalla
(
	numProgressivo	TINYINT UNSIGNED NOT NULL auto_increment,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	primary key (numProgressivo, nomeAgriturismo),
	foreign key (nomeAgriturismo) references Agriturismo(nome)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS CaratteristichePerTipoLocale;
CREATE TABLE CaratteristichePerTipoLocale
(
	specieOspitata	VARCHAR(30), -- check(specieOspitata in (select distinct(specie) from Animale)),
	altezza	SMALLINT UNSIGNED NOT NULL, /*in cm*/
	lunghezza	SMALLINT UNSIGNED NOT NULL, /*in cm*/
	larghezza	SMALLINT UNSIGNED NOT NULL, /*in cm*/
	capienzaMax	TINYINT UNSIGNED NOT NULL,
	pavimentazione	VARCHAR(30),
	primary key (specieOspitata, altezza, lunghezza, larghezza)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Locale;
CREATE TABLE Locale
(
	codiceLocale	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	temperatura	FLOAT,
	umidità	FLOAT,
	orientazioneFinestre	ENUM('N','NE', 'E', 'SE', 'S', 'SO', 'O', 'NO'),
	/*Tutte le soglie di tollerabilità sono espresse in valori percentuali*/
	tollerabilitaAzoto	TINYINT UNSIGNED,
	tollerabilitaSporcizia	TINYINT UNSIGNED,
	tollerabilitaMetano	TINYINT UNSIGNED,
	codiceStalla	TINYINT UNSIGNED NOT NULL,
	nomeAgriturismo	VARCHAR(50) NOT NULL,
	specieOspitata	VARCHAR(30), -- check(specieOspitata in (select distinct(specie) from Animale)),
	altezza	SMALLINT UNSIGNED NOT NULL, /*in cm*/
	lunghezza	SMALLINT UNSIGNED NOT NULL, /*in cm*/
	larghezza	SMALLINT UNSIGNED NOT NULL, /*in cm*/
	primary key (codiceLocale),
	foreign key (codiceStalla, nomeAgriturismo) references Stalla(numProgressivo, nomeAgriturismo), 
	foreign key (specieOspitata, altezza, lunghezza, larghezza) references CaratteristichePerTipoLocale(specieOspitata, altezza, lunghezza, larghezza)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Animale;
CREATE TABLE Animale
(
	codice	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	sesso	ENUM('M', 'F') NOT NULL,
	specie	VARCHAR(30),
	famiglia	VARCHAR(30),
	idMadre	SMALLINT UNSIGNED,
	idPadre	SMALLINT UNSIGNED,
	dataDiNascita	DATE,
	altezza	TINYINT UNSIGNED, /*Si suppone che nessun animale superi i 255 cm in altezza*/
	peso	SMALLINT UNSIGNED, /*Si suppone che nessun animale superi le 65 tonnelate*/
	razza	VARCHAR(30),
	latitudine	FLOAT,
	longitudine	FLOAT,
	orario	timestamp, 
	codiceGps	SMALLINT UNSIGNED NOT NULL unique,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	primary key (codice),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Fornitore;
CREATE TABLE Fornitore
(
	ragioneSociale	VARCHAR(40) NOT NULL unique,
	indirizzo	VARCHAR(60),
	partitaIva	DEC(11),
	primary key(ragioneSociale)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS acquistoanimale;
CREATE TABLE acquistoanimale
(
	codiceAnimale	SMALLINT UNSIGNED NOT NULL unique,
	ragioneSocialeFornitore	VARCHAR(40),
	dataAcquisto DATE NOT NULL,
	dataArrivo	DATE,
	primary key (codiceAnimale),
	foreign key (codiceAnimale) references Animale(codice),
	foreign key (ragioneSocialeFornitore) references Fornitore(ragioneSociale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Veterinario ;
CREATE TABLE  Veterinario 
(
	codiceFiscale	CHAR(16) NOT NULL UNIQUE,
	nome	VARCHAR(20),
	cognome	VARCHAR(20),
	contatto	VARCHAR(40),
	primary key(codiceFiscale)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Riproduzione;
CREATE TABLE Riproduzione
(
	codiceRiproduzione	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	complicanza	VARCHAR(100),
	data_orario	timestamp,
	stato	ENUM('successo', 'insuccesso'),
	codVeterinario	char(16) NOT NULL,
	codiceMadre	SMALLINT UNSIGNED NOT NULL,
	codicePadre	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceRiproduzione),
	foreign key (codVeterinario) references Veterinario(codiceFiscale), 
	foreign key (codiceMadre) references Animale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS SchedaGestazione;
CREATE TABLE SchedaGestazione
(
	codiceGestazione	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	codRiproduzione	SMALLINT UNSIGNED NOT NULL unique,
	codVeterinario	CHAR(16) NOT NULL ,
	primary key (codiceGestazione),
	foreign key (codRiproduzione) references Riproduzione(codiceRiproduzione), 
	foreign key (codVeterinario) references Veterinario(codiceFiscale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Visivi;
CREATE TABLE Visivi
(
	codiceVisivo	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	livelloSporcizia	TINYINT UNSIGNED, /*percentuale*/
	orarioRilevazione	timestamp NOT NULL,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceVisivo),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Ambientali;
CREATE TABLE Ambientali
(
	codiceAmbientale INT UNSIGNED NOT NULL unique auto_increment,
	temperatura	FLOAT,
	umidità	TINYINT UNSIGNED, /*percentuale*/
	orarioRilevazione	timestamp NOT NULL,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceAmbientale),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS CompostiVolatili;
CREATE TABLE CompostiVolatili
(
	codiceVolatili INT UNSIGNED NOT NULL unique auto_increment,
	concentrazioneMetano	TINYINT UNSIGNED, /*percentuale*/
	concentrazioneAzoto	TINYINT UNSIGNED, /*percentuale*/
    orarioRilevazione	timestamp NOT NULL,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceVolatili),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS PuliziaLocale;
CREATE TABLE PuliziaLocale
(
	codLocale	SMALLINT UNSIGNED NOT NULL,
	data_orarioRilevazione	timestamp,
	stato	ENUM('pendente', 'effettuato') NOT NULL,
	personale	VARCHAR(255) NOT NULL,
	primary key (codLocale, data_orarioRilevazione),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Foraggio;
CREATE TABLE Foraggio
(
	fibre INT UNSIGNED,
	proteine INT UNSIGNED,
	glucidi INT UNSIGNED,
	cereali	TINYINT UNSIGNED,/*percentuale*/
	frutta	TINYINT UNSIGNED,/*percentuale*/
	piante	TINYINT UNSIGNED,/*percentuale*/
	forma	ENUM('insilato', 'fieno'),
	kcalkg INT UNSIGNED,
	primary key (fibre, proteine, glucidi)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Acqua;
CREATE TABLE Acqua
(
	concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	concentrazioneVitamine	TINYINT UNSIGNED,/*percentuale*/
	primary key (concentrazioneSali, concentrazioneVitamine)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Pasto;
CREATE TABLE Pasto
(
	fibre INT UNSIGNED,
	proteine INT UNSIGNED,
	glucidi INT UNSIGNED,
	concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	concentrazioneVitamine	TINYINT UNSIGNED,/*percentuale*/
	primary key (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine),
	foreign key (fibre, proteine, glucidi) references Foraggio(fibre, proteine, glucidi), 
	foreign key (concentrazioneSali, concentrazioneVitamine) references Acqua(concentrazioneSali, concentrazioneVitamine)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS PastoPerLocale;
CREATE TABLE PastoPerLocale
(
	giorno_orario	timestamp,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	fibre INT UNSIGNED,
	proteine INT UNSIGNED,
	glucidi INT UNSIGNED,
	concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	concentrazioneVitamine	TINYINT UNSIGNED,/*percentuale*/
	primary key (giorno_orario,  codLocale),
	foreign key (codLocale) references Locale(codiceLocale), 
	foreign key (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine) references Pasto(fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Mangiatoia;
CREATE TABLE Mangiatoia
(
	codice	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	quantitàRestante	TINYINT UNSIGNED,/*percentuale*/
	codLocale	SMALLINT UNSIGNED,
	primary key (codice),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Abbeveratoio;
CREATE TABLE Abbeveratoio
(
	codice	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	quantitàRestante TINYINT UNSIGNED,/*percentuale*/
	codLocale	SMALLINT UNSIGNED,
	primary key (codice),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS AreaPascolo;
CREATE TABLE AreaPascolo
(
	codiceArea	TINYINT UNSIGNED NOT NULL unique auto_increment,
	primary key(codiceArea)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS RecinzioneDivisoriaeZoneDiPascolo;
CREATE TABLE RecinzioneDivisoriaeZoneDiPascolo
(
	codiceZona	TINYINT UNSIGNED NOT NULL unique auto_increment,
	codArea	TINYINT UNSIGNED,
	longitudine	FLOAT,
	latitudine	FLOAT,
	primary key (codiceZona, codArea),
	foreign key (codArea) references AreaPascolo(codiceArea)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS AttivitaPascolo;
CREATE TABLE AttivitaPascolo
(
	codiceAttivita	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	giorno_orario	timestamp,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	codArea	TINYINT UNSIGNED,
	primary key (codiceAttivita),
	foreign key (codLocale) references Locale(codiceLocale), 
	foreign key (codArea) references AreaPascolo(codiceArea)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Mungitrice;
CREATE TABLE Mungitrice
(
	codice	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	longitudine	FLOAT,
	latitudine	FLOAT,
	marca	VARCHAR(20),
	modello	VARCHAR(50),
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Mungitura;
CREATE TABLE Mungitura
(
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	codMungitrice	SMALLINT UNSIGNED NOT NULL,
	data_orario	timestamp NOT NULL,
	quantità INT UNSIGNED,
	primary key (codAnimale, codMungitrice, data_orario),
	foreign key (codAnimale) references Animale(codice), 
	foreign key (codMungitrice) references Mungitrice(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Silos;
CREATE TABLE Silos
(
	codice	TINYINT UNSIGNED NOT NULL unique ,
	capacità	SMALLINT NOT NULL,
	livello	SMALLINT NOT NULL,
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Latte;
CREATE TABLE Latte
(
	codiceLatte	SMALLINT UNSIGNED NOT NULL unique auto_increment,
	quantitàSostanzeDisciolte	TINYINT UNSIGNED NOT NULL,
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	codSilos	TINYINT UNSIGNED,
	primary key (codiceLatte),
	foreign key (codAnimale) references Animale(codice), 
	foreign key (codSilos) references Silos(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS chemunge;
CREATE TABLE chemunge
(
	codLatte	SMALLINT UNSIGNED NOT NULL,
	codMungitrice	SMALLINT UNSIGNED NOT NULL,
	primary key (codLatte, codMungitrice),
	foreign key (codLatte) references Latte(codiceLatte), 
	foreign key (codMungitrice) references Mungitrice(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS prodottocon;
CREATE TABLE prodottocon
(
	codLatte	SMALLINT UNSIGNED NOT NULL,
	codLotto	SMALLINT UNSIGNED NOT NULL,
	primary key (codLatte, codLotto),
	foreign key (codLatte) references Latte(codiceLatte), 
	foreign key (codLotto) references Lotto(codiceLotto)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Cantine;
CREATE TABLE Cantine
(
	codice	TINYINT UNSIGNED NOT NULL unique auto_increment,
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS stoccaggiocantine;
CREATE TABLE stoccaggiocantine
(
	codLotto	SMALLINT UNSIGNED NOT NULL,
	codCantina	TINYINT UNSIGNED NOT NULL,
	primary key (codLotto, codCantina),
	foreign key (codLotto) references Lotto(codiceLotto), 
	foreign key (codCantina) references Cantine(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Magazzini;
CREATE TABLE Magazzini
(
	codice	TINYINT UNSIGNED NOT NULL unique auto_increment,
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS stoccaggiomagazzini;
CREATE TABLE stoccaggiomagazzini
(
	codLotto	SMALLINT UNSIGNED NOT NULL,
	codMagazzino	TINYINT UNSIGNED NOT NULL,
	primary key (codLotto, codMagazzino),
	foreign key (codLotto) references Lotto(codiceLotto), 
	foreign key (codMagazzino) references Magazzini(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Scaffalature;
CREATE TABLE Scaffalature
(
	codCantina	TINYINT UNSIGNED NOT NULL unique,
	codice	SMALLINT UNSIGNED NOT NULL unique,
	primary key (codCantina, codice),
	foreign key (codCantina) references Cantine(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Parametri;
CREATE TABLE Parametri
(
	dataParametri DATE NOT NULL,
	idSensore INT UNSIGNED NOT NULL,
	temperatura	FLOAT,
	umidità	FLOAT,
	codCantina	TINYINT UNSIGNED NOT NULL,
	primary key (dataParametri, idSensore),
	foreign key (codCantina) references Cantine(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS  Scaffali ;
CREATE TABLE  Scaffali 
(
	codice	TINYINT UNSIGNED NOT NULL,
	codMagazzino TINYINT UNSIGNED NOT NULL,
	primary key (codice, codMagazzino),
	foreign key (codMagazzino) references Magazzini(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Fasi ;
CREATE TABLE  Fasi 
(
	codiceFase	INTEGER UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	nome	VARCHAR(30),
	parametriProcesso 	VARCHAR(200),
	durata	TIME NOT NULL,
	primary key(codiceFase)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ControlloParametriFase ;
CREATE TABLE  ControlloParametriFase 
(
	parametriEffettivi	VARCHAR(200) UNIQUE,
	codLotto	SMALLINT UNSIGNED NOT NULL,
	codFase		INTEGER UNSIGNED NOT NULL,
	primary key (parametriEffettivi, codLotto, codFase),
	foreign key (codFase) references Fasi(codiceFase),
	foreign key (codLotto) references Lotto(codiceLotto)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Ricetta ;
CREATE TABLE  Ricetta 
(
	codiceRicetta	INTEGER UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	collocazioneGeografica	VARCHAR(30),
	ricetta	VARCHAR(4096) NOT NULL,
	durataStagionatura	TIME,
	primary key(codiceRicetta)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  divisain ;
CREATE TABLE  divisain 
(
	codRicetta	INTEGER UNSIGNED NOT NULL UNIQUE,
	codFase	INTEGER UNSIGNED NOT NULL UNIQUE,
	primary key (codRicetta, codFase),
	foreign key (codRicetta) references Ricetta(codiceRicetta),
	foreign key (codFase) references Fasi(codiceFase)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Formaggio ;
CREATE TABLE  Formaggio 
(
	nome	VARCHAR(30) NOT NULL UNIQUE,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	deperibilita	INT, -- da intendere come giorni prima della deperibilità
	codRicetta	INTEGER NOT NULL,
	codLatte	INTEGER NOT NULL,
	primary key (nome, nomeAgriturismo),
	foreign key (nomeAgriturismo) references Agriturismo(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Indicisalute ;
CREATE TABLE  Indicisalute 
(
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	dataRilevazione	DATE NOT NULL UNIQUE,
	tipologiaRespirazione	SMALLINT UNSIGNED,
	lucentezzaPelo	SMALLINT UNSIGNED,
	vigilanza	SMALLINT UNSIGNED,
	idratazione	SMALLINT UNSIGNED,
	deambulazione	SMALLINT UNSIGNED,
	/*Per la ridondanza Qualità pasto*/
	fibre INT UNSIGNED,
	proteine INT UNSIGNED,
	glucidi INT UNSIGNED,
	concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	concentrazioneVitamine	TINYINT UNSIGNED,/*percentuale*/
	primary key (codAnimale, dataRilevazione),
	foreign key (codAnimale) references Animale(codice),
	foreign key (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine) references Pasto(fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Visita ;
CREATE TABLE  Visita 
(
	codiceVisita	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	esito	CHAR(8),
	descrizione	VARCHAR(500),
	dataEffettiva	DATE,
	dataProgrammata	DATE,
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	codVeterinario	CHAR(16) NOT NULL,
	primary key (codiceVisita),
	foreign key (codAnimale) references Animale(codice),
	foreign key (codVeterinario) references Veterinario(codiceFiscale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Esame ;
CREATE TABLE  Esame 
(
	codiceEsame	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	descrizione	VARCHAR(500),
	dataEsame	DATE,
	macchinario	VARCHAR(20),
	nome	VARCHAR(20),
	codAnimale SMALLINT UNSIGNED NOT NULL	,
	codVeterinario	CHAR(16) NOT NULL,
	primary key (codiceEsame),
	foreign key (codAnimale) references Animale(codice),
	foreign key (codVeterinario) references Veterinario(codiceFiscale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Terapia ;
CREATE TABLE  Terapia 
(
	codiceTerapia	INTEGER UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT ,
	dataInizio	DATE,
	durata	TIME,
	secondaTerapiaConsecutiva	BOOLEAN,
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	primary key (codiceTerapia),
	foreign key (codAnimale) references Animale(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Farmaco ;
CREATE TABLE  Farmaco 
(
	nome	VARCHAR(255) NOT NULL UNIQUE,
	principioAttivo	VARCHAR(50),
	dosaggio	VARCHAR(20),
	primary key(nome)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  compostada ;
CREATE TABLE  compostada 
(
	codTerapia	INTEGER UNSIGNED NOT NULL,
	nomeFarmaco	VARCHAR(255) NOT NULL,
	posologia	VARCHAR(500),
	primary key (codTerapia, nomeFarmaco),
	foreign key (codTerapia) references Terapia(codiceTerapia),
	foreign key (nomeFarmaco) references Farmaco(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  SchedaMedica ;
CREATE TABLE  SchedaMedica 
(
	codiceScheda	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	massaMagra	VARCHAR(255),
	carenze	VARCHAR(255),
	patologie	VARCHAR(255),
	dataScheda	DATE,
	rispostaOculare	VARCHAR(255),
	emocromo	VARCHAR(255),
	spessoreZoccolo	VARCHAR(255),
	fegato	VARCHAR(255),
	cuore	VARCHAR(255),
	pancreas	VARCHAR(255),
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	codVeterinario	CHAR(16) NOT NULL,
	primary key (codiceScheda),
	foreign key (codAnimale) references Animale(codice),
    foreign key (codVeterinario) references Veterinario(codiceFiscale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  DisturbiComportamentali ;
CREATE TABLE  DisturbiComportamentali 
(
    entità	VARCHAR(255) NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	codScheda	SMALLINT UNSIGNED NOT NULL, 
	primary key (entità, nome, codScheda), 
	foreign key (codScheda) references SchedaMedica(codiceScheda)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Lesioni ;
CREATE TABLE  Lesioni 
(
	tipologia	VARCHAR(255) NOT NULL,
	parteDelCorpo	VARCHAR(20) NOT NULL,
	entità	VARCHAR(255) NOT NULL,
	codScheda	SMALLINT UNSIGNED NOT NULL,
	primary key (tipologia, parteDelCorpo, entità, codScheda),
	foreign key (codScheda) references SchedaMedica(codiceScheda)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
	dataPagamento	DATE,
	codCliente	CHAR(16) NOT NULL,
	primary key (codPagamento),
	foreign key (codCliente) references Cliente(codCarta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Stanza ;
CREATE TABLE  Stanza 
(
	numStanza	TINYINT UNSIGNED NOT NULL,
	codAgriturismo	VARCHAR(30) NOT NULL,
	costoGiornaliero	TINYINT UNSIGNED NOT NULL,
	suite	ENUM('singola','doppia','suite') NOT NULL,
	numLetti	TINYINT UNSIGNED NOT NULL,
	tipoLetti	VARCHAR(100),
	primary key (numStanza, codAgriturismo),
	foreign key (codAgriturismo) references Agriturismo(Nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  PrenotazioneStanza ;
CREATE TABLE  PrenotazioneStanza 
(
	dataArrivo	DATE NOT NULL,
	numStanza	TINYINT UNSIGNED NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	codCliente	CHAR(16) NOT NULL,
	dataPartenza	DATE NOT NULL,
	/*CHECK(numStanza,nomeAgriturismo IN (SELECT numStanza,codAgriturismo FROM Stanza))*/
	primary key (dataArrivo, numStanza, nomeAgriturismo, codCliente),
	foreign key (numStanza,nomeAgriturismo) references Stanza(numStanza,codAgriturismo),
	foreign key (codCliente) references Cliente(codCarta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ServizioAggiuntivo ;
CREATE TABLE  ServizioAggiuntivo 
(
	tipoServizio	VARCHAR(20) NOT NULL UNIQUE,
	costo	TINYINT UNSIGNED NOT NULL,
	primary key(tipoServizio)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ServizioperStanza ;
CREATE TABLE  ServizioperStanza 
(
	dataInizioUtilizzo DATE NOT NULL,
	dataArrivo	DATE NOT NULL,
	numStanza	TINYINT UNSIGNED NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	codCliente	CHAR(16) NOT NULL,
	codServizio	VARCHAR(20) NOT NULL,
	dataFineUtilizzo	DATE NOT NULL,
	primary key (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio),
	foreign key (dataArrivo, numStanza, nomeAgriturismo, codCliente) references PrenotazioneStanza(dataArrivo, numStanza, nomeAgriturismo, codCliente),
    foreign key (codServizio) references ServizioAggiuntivo(tipoServizio)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Guida ;
CREATE TABLE  Guida 
(
	codfisc	CHAR(16) NOT NULL UNIQUE,
	nome	VARCHAR(20) NOT NULL,
	cognome	VARCHAR(20) NOT NULL,
	contatto 	CHAR(11) NOT NULL UNIQUE,
	primary key(codfisc)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Escursione ;
CREATE TABLE  Escursione 
(
	codice	TINYINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	giorno_orario	TIMESTAMP,
	codGuida	CHAR(16) NOT NULL,
	primary key (codice),
	foreign key (codGuida) references Guida(codFisc)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  PrenotazioneEscursione ;
CREATE TABLE  PrenotazioneEscursione 
(
	dataPrenotazione	DATE NOT NULL ,
	codEscursione	TINYINT UNSIGNED NOT NULL,
	codCliente	CHAR(16) NOT NULL,
	primary key (dataPrenotazione, codEscursione, codCliente),
	foreign key (codEscursione) references Escursione(codice),
	foreign key (codCliente) references Cliente(codCarta)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Itinerario ;
CREATE TABLE  Itinerario 
(
	codice	SMALLINT NOT NULL UNIQUE AUTO_INCREMENT,
	numSentieri	VARCHAR(255),
	codAgriturismo VARCHAR(30) NOT NULL,
	primary key (codice),
	foreign key (codAgriturismo) references Agriturismo(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  legataa ;
CREATE TABLE  legataa 
(
	codEscursione	TINYINT UNSIGNED NOT NULL,
	codItinerario	SMALLINT NOT NULL,
	primary key (codEscursione, codItinerario),
	foreign key (codEscursione) references Escursione(codice),
	foreign key (codItinerario) references Itinerario(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Tappe ;
CREATE TABLE  Tappe 
(
	nome		VARCHAR(30) NOT NULL UNIQUE,
	tempoPermanenza	TIME,
	primary key(nome) 	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  compostoda ;
CREATE TABLE  compostoda 
( 
	codItinerario SMALLINT NOT NULL,
	nomeTappa VARCHAR(30) NOT NULL,
	primary key (codItinerario, nomeTappa),
	foreign key (codItinerario) references Itinerario(codice),
	foreign key (nomeTappa) references Tappe(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Account ;
CREATE TABLE  Account 
(
	utente	VARCHAR(20) NOT NULL UNIQUE,
	password	VARCHAR(16)NOT NULL UNIQUE,
	domandaRec	VARCHAR(100) NOT NULL,
	rispostaRec	VARCHAR(255) NOT NULL,
	numTelefono	VARCHAR(10) NOT NULL,
	codFiscale	CHAR(16) NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	cognome	VARCHAR(30) NOT NULL,
	scadenzaDoc	DATE NOT NULL,
	numDoc	VARCHAR(15) NOT NULL,
	dataIscrizione	DATE NOT NULL,
	codDoc	VARCHAR(15) NOT NULL,
	enteRilascio	VARCHAR(30) NOT NULL,
	tipoDoc	VARCHAR(30) NOT NULL,
	indirizzo	VARCHAR(50) NOT NULL,
	codiceCarta	CHAR(16) NOT NULL,
	primary key (utente, password),
	foreign key (codiceCarta) references Cliente(codCarta)
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

DROP TABLE IF EXISTS  Recensione ;
CREATE TABLE  Recensione 
(
	codiceRecensione	INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	gradimentoGenerale	TINYINT NOT NULL,
	qualitaPercepita	TINYINT NOT NULL,
	conservazione	VARCHAR(30),
	campoTestuale	VARCHAR(255),
	gusto	TINYINT NOT NULL,
	utente	VARCHAR(20) NOT NULL,
	password	VARCHAR(16) NOT NULL,
	codProdotto INT UNSIGNED NOT NULL,
	primary key (codiceRecensione),
	foreign key (utente) references Account(utente),
	foreign key (password) references Account(password),
	foreign key (codProdotto) references FormaggioProdotto(codiceProdotto)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS  CentridiSmistamento ;
CREATE TABLE  CentridiSmistamento 
(
	codice	TINYINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	nome	VARCHAR(30),
	indirizzo	VARCHAR(40),
	contatto	VARCHAR(10),
	primary key(codice)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  processatada ;
CREATE TABLE  processatada 
(
	codSpedizione	SMALLINT UNSIGNED NOT NULL,
	codcentro	TINYINT UNSIGNED NOT NULL,
	primary key (codSpedizione, codcentro),
	foreign key (codSpedizione) references Spedizione(codice),
	foreign key (codcentro) references CentridiSmistamento(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
