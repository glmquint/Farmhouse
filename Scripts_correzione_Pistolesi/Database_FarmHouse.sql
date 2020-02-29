/*----Definizione Tabelle-----*/


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

DROP TABLE IF EXISTS Illuminazione;
CREATE TABLE Illuminazione
(
	codice INT UNSIGNED NOT NULL unique auto_increment,
	consumoEnergetico	SMALLINT UNSIGNED,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	primary key (codice),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS CondizionatoreAria;
CREATE TABLE CondizionatoreAria
(
	codice INT UNSIGNED NOT NULL unique auto_increment,
	consumoEnergetico	SMALLINT UNSIGNED,
	codLocale	SMALLINT UNSIGNED NOT NULL,
	primary key (codice),
	foreign key (codLocale) references Locale(codiceLocale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS PuliziaLocale;
CREATE TABLE PuliziaLocale
(
	codLocale	SMALLINT UNSIGNED NOT NULL,
	data_orarioRilevazione	timestamp,
	stato	ENUM('pendente', 'effettuato') NOT NULL,
	personale	VARCHAR(255) NOT NULL,
    concentrazioneMetano	TINYINT UNSIGNED, /*percentuale*/
	concentrazioneAzoto	TINYINT UNSIGNED, /*percentuale*/
    livelloSporcizia	TINYINT UNSIGNED, /*percentuale*/
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
	durata_fase_ideale INT UNSIGNED,
    temperatura_latte_ideale INT UNSIGNED,
    tempo_riposo_ideale INT UNSIGNED,
	durata	TIME NOT NULL,
	primary key(codiceFase)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ControlloParametriFase ;
CREATE TABLE  ControlloParametriFase 
(
	durata_fase_effettiva INT UNSIGNED,
    temperatura_latte_effettiva INT UNSIGNED,
    tempo_riposo_effettiva INT UNSIGNED,
	codLotto	SMALLINT UNSIGNED NOT NULL,
	codFase		INTEGER UNSIGNED NOT NULL,
	primary key (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase),
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
	codRicetta	INTEGER UNSIGNED NOT NULL ,
	codFase	INTEGER UNSIGNED NOT NULL ,
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
	primary key (nome, nomeAgriturismo),
	foreign key (nomeAgriturismo) references Agriturismo(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Indicisalute ;
CREATE TABLE  Indicisalute 
(
	codAnimale	SMALLINT UNSIGNED NOT NULL,
	dataRilevazione	DATE NOT NULL,
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
	durata	INTEGER UNSIGNED, -- numero di giorni
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
	costoGiornaliero	SMALLINT UNSIGNED NOT NULL,
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
	quantità	TINYINT UNSIGNED NOT NULL,
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


/*----For debugging purpose-----*/

DROP TABLE IF EXISTS  logtable ;
CREATE TABLE  logtable
(
	id	INT AUTO_INCREMENT,
	info	TEXT(1024),
    ts TIMESTAMP,
	primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP PROCEDURE IF EXISTS LOG;
DELIMITER $$
CREATE PROCEDURE LOG(IN _msg TEXT(1024))
BEGIN
	INSERT INTO logtable (info, ts) VALUES (_msg, current_timestamp());
    
END $$
DELIMITER ;



/*----Definizione Vincoli-----*/

/*vincolo I*/
-- Esiste un vincolo di integrità che lega il codice di un animale al codice dellamadre e del padre (idMadre,idPadre)
DROP TRIGGER IF EXISTS I_controllo_genitori;
DELIMITER $$ 
CREATE TRIGGER I_controllo_genitori
BEFORE INSERT ON Animale FOR EACH ROW
BEGIN 
	IF new.idMadre NOT IN (
	                         SELECT codice 
                             FROM Animale A
	                         WHERE A.sesso='F')
	    AND new.idMadre IS NOT NULL THEN
	    signal sqlstate '70006' SET MESSAGE_TEXT='il codice madre inserito non è valido';
	END IF;
	
	
	
	IF new.idPadre NOT IN (
	                         SELECT codice 
                             FROM Animale A
	                         WHERE A.sesso='M')
	    AND new.idPadre IS NOT NULL THEN
	    signal sqlstate '70006' SET MESSAGE_TEXT='il codice padre inserito non è valido';
	END IF;
	

END $$	
DELIMITER ;


/*vincolo II*/
DROP TRIGGER IF EXISTS II_controllo_data_nascita;
DELIMITER $$
CREATE TRIGGER II_controllo_data_nascita
BEFORE INSERT ON Animale FOR EACH ROW
BEGIN 

    -- Esiste un vincolo di integrità che lega l’attributo data in diproduzione conl’attributo dataDiNascita in Animale
	IF NEW.idMadre IS NOT NULL AND NEW.idPadre IS NOT NULL AND new.dataDiNascita NOT IN (SELECT DATE_FORMAT(R.data_orario, '%Y-%m-%d')
							   FROM Riproduzione R 
							   WHERE new.idMadre=R.codiceMadre AND new.idPadre=R.codicepadre) THEN

		signal sqlstate '70006' SET MESSAGE_TEXT='la data di nascita non è valida';
	END IF;
END $$	
DELIMITER ;



/*vincolo III*/
-- Esiste un vincolo di integrità che lega l’attributo codicePadre in coinvolgecon l’attributo codice in Animale
DROP TRIGGER IF EXISTS III_codicePadre_riproduzione;
DELIMITER $$ 
CREATE TRIGGER III_codicePadre_riproduzione
BEFORE INSERT ON Riproduzione FOR EACH ROW
BEGIN 
    
	IF new.codicePadre NOT IN (
	                         SELECT codice 
                             FROM Animale A
	                         WHERE A.sesso='M')
	    OR new.codicePadre IS NULL THEN
	    signal sqlstate '70006' SET MESSAGE_TEXT='il codice padre associato alla riproduzione non è valido';
	END IF;	
END $$
DELIMITER ;


/*vincolo IV*/
-- Esiste un vincolo di integrità che lega gli attributi temperatura e umidità inLocale con temperatura e umidità in Ambientali
DROP TRIGGER IF EXISTS IV_aggiornamento_ambientali;
DELIMITER $$ 
CREATE TRIGGER IV_aggiornamento_ambientali
BEFORE UPDATE ON Ambientali FOR EACH ROW
BEGIN 
UPDATE Locale
	SET new.temperatura=( SELECT AVG(temperatura) 
                      FROM Locale L INNER JOIN Ambientali A ON A.codLocale=L.codice 
	                  WHERE A.temperatura IS NOT NULL AND A.orarioRilevazione=CURRENT_TIMESTAMP());
	  
	SET new.umidità=( SELECT AVG(umidità) 
                      FROM Locale L INNER JOIN Ambientali A ON A.codLocale=L.codice 
	                  WHERE A.umidità IS NOT NULL AND A.orarioRilevazione=CURRENT_TIMESTAMP());
END $$	
DELIMITER ;


/*vincolo V*/
-- Esiste un vincolo di integrità che lega gli attributi fibre proteine glucidi inForaggio e kcal/kg in Foraggio
DROP TRIGGER IF EXISTS V_calcolo_kcal;
DELIMITER $$ 
CREATE TRIGGER V_calcolo_kcal
BEFORE INSERT ON Foraggio FOR EACH ROW
BEGIN 
	SET new.kcalkg=new.proteine*3.8+new.glucidi*3.8 ;
END $$	
DELIMITER ;


/*vincolo VI*/
-- Esiste un vincolo di integrità che lega gli attributi dataInizio durata e secon-daTerapiaConsecutiva in Terapia
DROP TRIGGER IF EXISTS VI_aggiornamento_terapie;
DELIMITER $$ 
CREATE TRIGGER VI_aggiornamento_terapie
BEFORE INSERT ON Terapia FOR EACH ROW
BEGIN 
	IF (SELECT COUNT(*)
    FROM Terapia T INNER JOIN Animale A ON  T.codAnimale=A.codice
	WHERE T.dataInizio+INTERVAL(T.durata)DAY<=NEW.dataInizio)>1 AND NEW.secondaTerapiaConsecutiva IS NULL THEN
	    SET new.secondaTerapiaConsecutiva=TRUE;
	ELSE
	    SET new.secondaTerapiaConsecutiva=FALSE;
    END IF;
END $$
DELIMITER ;


/*-------------------------------------------------------------OK

Esiste un vincolo di integrità che lega dataProd e durata in Lotto e deperi-bilità in Formaggio a scadenza in Formaggio Prodotto

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

/*-------------------------------------------------------------OK

Esiste un vincolo di integrità che lega dataPartenza in PrenotazioneStanza a data in Pagamenti

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

/*-------------------------------------------------------------OK

Esiste un vincolo di integrità che lega anticipo in cliente, a tipoPagamentoe a totaleCosto in Pagamenti.

*/

DROP TRIGGER IF EXISTS IX_anticipo_su_pagamento;
DELIMITER $$
CREATE TRIGGER IX_anticipo_su_pagamento
BEFORE INSERT ON Pagamenti
FOR EACH ROW 
BEGIN 
IF NEW.tipoPagamento = 'stanza' THEN -- l'anticipo è da considerare solo per le prenotazioni di stanze
	SET NEW.totaleCosto = NEW.totaleCosto - (SELECT C.anticipo FROM Cliente C WHERE C.codCarta = NEW.codCliente);
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Esiste un vincolo tra quantità in contenutoordine, rimastiinstock in Formag-gioProdotto e stato in OrdineProdotti.

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

/*-------------------------------------------------------------OK

Esiste un vincolo di integrità tra reso in contenutoordine e stato e tipoConsegnaReso in Ordine Prodotti

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

/*-------------------------------------------------------------OK

Esiste un vincolo di integrità tra stato in Spedizione e stato in OrdineProdot

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

/*-------------------------------------------------------------OK

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


/*-------------------------------------------------------------

Descrizione: le mungiture possono essere effettuate ovviamente solo da animali femmina*/

DROP TRIGGER IF EXISTS XIV_mungitura_femmina;
DELIMITER $$
CREATE TRIGGER XIV_mungitura_femmina
BEFORE INSERT ON Mungitura
FOR EACH ROW
BEGIN
	IF (SELECT A.sesso FROM Animale A WHERE A.codice = NEW.codAnimale) <> 'F' THEN
		signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE: L\'animale da mungere deve essere femmina';
	END IF;
END $$
DELIMITER ;


/*----Definizione Operazioni-----*/

SET GLOBAL event_scheduler = ON;

/*-------------------------------------------------------------OK

/*Operazione 1: Controllo qualità del pasto
Descrizione:Viene controllato che il pasto che viene somministrato agli animali
	non abbia ripercussioni sul loro stato di salute: in particolare vengono 
    controllati gli indici di salute di tutti gli animali appartenenti ai locali
    nei quali è stato somministrato il pasto in esame
Input:composizione del pasto
Output:media degli indici di salute
Frequenza giornaliera:33
*/


DROP TRIGGER IF EXISTS cambio_pasto;
DELIMITER $$
CREATE TRIGGER cambio_pasto
BEFORE INSERT ON PastoPerLocale
FOR EACH ROW 
BEGIN 
	SET @fibre = 0;
    SET @proteine = 0;
    SET @glucidi = 0;
    SET @concentrazioneSali = 0;
    SET @concentrazioneVitamine = 0;
	SELECT PPL.fibre, PPL.proteine, PPL.glucidi, PPL.concentrazioneSali, PPL.concentrazioneVitamine
		INTO @fibre, @proteine, @glucidi, @concentrazioneSali, @concentrazioneVitamine
	FROM PastoPerLocale PPL
	WHERE PPL.codLocale = NEW.codLocale
	AND PPL.giorno_orario = (SELECT MAX(PPL1.giorno_orario)
							FROM PastoPerLocale PPL1
							WHERE PPL.codLocale = NEW.codLocale) ;
	CALL OP1_controllo_qualita_pasto(@fibre, @proteine, @glucidi, @concentrazioneSali, @concentrazioneVitamine);
END $$
DELIMITER ;


 
DROP FUNCTION IF EXISTS prima_somministrazione;
DELIMITER $$
CREATE FUNCTION prima_somministrazione(
	/*il pasto*/
    _fibre INT UNSIGNED,
	_proteine INT UNSIGNED,
	_glucidi INT UNSIGNED,
	_concentrazioneSali	TINYINT UNSIGNED,
	_concentrazioneVitamine	TINYINT UNSIGNED,
    /*il locale*/
    _codiceLocale	SMALLINT
) 
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE return_value TIMESTAMP;
    SELECT MIN(PPL.giorno_orario)
			FROM PastoPerLocale PPL
            WHERE PPL.fibre = _fibre
				AND PPL.proteine = _proteine
                AND PPL.glucidi = _glucidi
                AND PPL.concentrazioneSali = _concentrazioneSali
                AND PPL.concentrazioneVitamine = _concentrazioneVitamine
                AND PPL.codLocale = _codiceLocale
			LIMIT 1
            INTO return_value;
            
	IF return_value IS NOT NULL THEN
		RETURN(DATE_FORMAT(return_value, '%Y-%m-%d'));
	ELSE
		RETURN(NULL);
	END IF;

END$$
DELIMITER ;

DROP TABLE IF EXISTS log_qualita_pasto;
CREATE TABLE log_qualita_pasto
(
	fibre INT UNSIGNED,
    proteine INT UNSIGNED,
    glucidi INT UNSIGNED,
    sali TINYINT UNSIGNED,
    vitamine TINYINT UNSIGNED,
    media_respirazione SMALLINT UNSIGNED,
    media_deambulazione SMALLINT UNSIGNED,
    media_idratazione SMALLINT UNSIGNED,
    media_vigilanza SMALLINT UNSIGNED,
    media_lucentezza_pelo SMALLINT UNSIGNED,
	primary key (fibre, proteine, glucidi, sali, vitamine)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP PROCEDURE IF EXISTS OP1_controllo_qualita_pasto;
DELIMITER $$
CREATE PROCEDURE OP1_controllo_qualita_pasto
	(IN _fibre INT UNSIGNED,
	IN _proteine INT UNSIGNED,
	IN _glucidi INT UNSIGNED,
	IN _concentrazioneSali	TINYINT UNSIGNED,/*percentuale*/
	IN _concentrazioneVitamine	TINYINT UNSIGNED)
BEGIN
	IF _fibre IS NOT NULL 
		AND _proteine IS NOT NULL 
		AND _glucidi IS NOT NULL 
		AND _concentrazioneSali IS NOT NULL 
		AND _concentrazioneVitamine IS NOT NULL THEN
        
		/*Considera la media di tutti gli indici di salute rilevati dopo la prima sommisitrazione del pasto in ogni locale*/
		 REPLACE INTO log_qualita_pasto
         SELECT 
			_proteine AS proteine,
            _glucidi AS glucidi,
            _concentrazioneSali AS concentrazioneSali,
            _concentrazioneVitamine AS concentrazioneVitamine,
            L.codiceLocale AS Locale, 
			AVG(I.tipologiaRespirazione) AS tipologiaRespirazione, 
			AVG(I.deambulazione) AS deambulazione, 
			AVG(I.idratazione) AS idratazione, 
			AVG(I.vigilanza) AS vigilanza, 
			AVG(I.lucentezzaPelo) AS lucentezzaPelo
		 FROM Locale L INNER JOIN Animale A ON L.codiceLocale = A.codLocale
						INNER JOIN IndiciSalute I ON A.codice = I.codAnimale
		 WHERE L.codiceLocale IN (SELECT DISTINCT(PPL.codlocale)
									FROM PastoPerLocale PPL
									WHERE PPL.fibre = _fibre
										AND PPL.proteine = _proteine
										AND PPL.glucidi = _glucidi
										AND PPL.concentrazioneSali = _concentrazioneSali
										AND PPL.concentrazioneVitamine = _concentrazioneVitamine)
			AND IF(prima_somministrazione(_fibre,
											_proteine, 
											_glucidi, 
											_concentrazioneSali, 
											_concentrazioneVitamine, 
											L.codiceLocale) IS NOT NULL,
					I.dataRilevazione > prima_somministrazione(_fibre, 
																_proteine, 
																_glucidi, 
																_concentrazioneSali, 
																_concentrazioneVitamine, 
																L.codiceLocale),
					0)
		GROUP BY L.codiceLocale;
END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS aggiorna_ridondanza_pasto_in_IndiciSalute;
DELIMITER $$
CREATE TRIGGER aggiorna_ridondanza_pasto_in_IndiciSalute
BEFORE INSERT ON IndiciSalute
FOR EACH ROW
BEGIN
	DECLARE var_fibre INT UNSIGNED DEFAULT NULL;
	DECLARE var_proteine INT UNSIGNED DEFAULT NULL;
	DECLARE var_glucidi INT UNSIGNED DEFAULT NULL;
	DECLARE var_sali TINYINT UNSIGNED DEFAULT NULL;
	DECLARE var_vitamine TINYINT UNSIGNED DEFAULT NULL;
	SELECT fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine
				FROM Animale A INNER JOIN PastoPerLocale PPL ON A.codLocale = PPL.codLocale
                WHERE A.codice = NEW.codAnimale
                ORDER BY PPL.giorno_orario DESC
                LIMIT 1 INTO var_fibre, var_proteine, var_glucidi, var_sali, var_vitamine;
	SET NEW.fibre = var_fibre;
    SET NEW.proteine = var_proteine;
    SET NEW.glucidi = var_glucidi;
    SET NEW.concentrazioneSali = var_sali;
    SET NEW.concentrazioneVitamine = var_vitamine;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

/*
Operazione 2: Registrazione di una ripoduzione con successo
Descrizione:Al completamento di una riproduzione terminata con succeso, viene
	compilata l’anagrafica del neonato, viene aggiornato lo stato della riproduzione e
    viene programmata una visita per il nuovo nato
Input:codice della riproduzione avvenuta con successo e dati appartenenti al
	neonato (sesso, specie, famiglia, razza, peso, altezza)
Output:registrazione del neonato con programmazione di una nuova visita
Frequenza giornaliera:32
*/

DROP FUNCTION IF EXISTS first_available_code;
DELIMITER $$
CREATE FUNCTION first_available_code() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 1;
	WHILE (SELECT A.codice
			FROM Animale A
            WHERE codice = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DROP FUNCTION IF EXISTS first_available_GPS;
DELIMITER $$
CREATE FUNCTION first_available_GPS() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 1;
	WHILE (SELECT A.codiceGPS
			FROM Animale A
            WHERE codiceGPS = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS check_stato_riproduzione;
DELIMITER $$
CREATE TRIGGER check_stato_riproduzione
AFTER UPDATE ON Riproduzione
FOR EACH ROW 
BEGIN 
IF NEW.stato = 'insuccesso' THEN
	INSERT INTO
		Visita(descrizione,
				dataProgrammata,
				codAnimale,
				codVeterinario)
		VALUES('Visita di controllo automaticamente richiesta in seguito alla riproduzione fallita da parte dell\'animale',
				CURRENT_DATE + INTERVAL 3 DAY,
				NEW.codiceMadre,
				(SELECT R.codVeterinario
					FROM Riproduzione R
					WHERE R.codiceRiproduzione = NEW.codiceRiproduzione));
/*ELSEIF NEW.stato = 'successo' THEN
	signal sqlstate '45000' SET MESSAGE_TEXT = 'Chiamare la procedure OP2_registrazione_neonato per registrare il neonato e prenotargli una visita';
*/END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OP2_registrazione_neonato;
DELIMITER $$
CREATE PROCEDURE OP2_registrazione_neonato
	(IN _codRiproduzione SMALLINT UNSIGNED,
    IN _sesso	ENUM('M', 'F'),
	IN _specie	VARCHAR(30),
	IN _famiglia	VARCHAR(30),
	IN _dataDiNascita	DATE,
	IN _altezza	TINYINT UNSIGNED, /*Si suppone che nessun animale superi i 255 cm in altezza*/
	IN _peso	SMALLINT UNSIGNED, /*Si suppone che nessun animale superi le 65 tonnelate*/
	IN _razza	VARCHAR(30))
BEGIN
  DECLARE codice_ SMALLINT UNSIGNED;
  DECLARE GPS_ SMALLINT UNSIGNED;
  SET codice_ = first_available_code();
  CALL LOG(CONCAT("codice_neonato: ", codice_));
  SET GPS_ = first_available_GPS();
  -- START TRANSACTION;
  INSERT INTO 
  Animale(codice,
			sesso,
			specie,
			famiglia,
			idMadre,
			idPadre,
			dataDiNascita,
			altezza,
			peso,
			razza,
			codiceGPS,
			codLocale)
	VALUES(codice_,
			_sesso,
			_specie,
			_famiglia,
			(SELECT R.codiceMadre
				FROM Riproduzione R
				WHERE R.codiceRiproduzione = _codRiproduzione),
			(SELECT R.codicePadre
				FROM Riproduzione R
				WHERE R.codiceRiproduzione = _codRiproduzione),
			_dataDiNascita,
			_altezza,
			_peso,
			_razza,
			GPS_,
			(SELECT A.codLocale /*il neonato abita il locale della madre*/
				FROM Animale A INNER JOIN Riproduzione R ON A.codice = R.codiceMadre
				WHERE R.codiceRiproduzione = _codRiproduzione)); 
	-- COMMIT WORK;
  INSERT INTO 
	Visita(descrizione,
			dataProgrammata,
			codAnimale,
			codVeterinario)
	VALUES('Visita di controllo automaticamente richiesta in seguito alla nascita dell\' animale',
			CURRENT_DATE + INTERVAL 3 DAY,
            codice_,
            (SELECT R.codVeterinario
				FROM Riproduzione R
				WHERE R.codiceRiproduzione = _codRiproduzione));
	COMMIT;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Operazione 3: Pagamento delle stanze
Descrizione:Ogni giorno viene registrato il pagamento cumulativo di ogni cliente
	per ogni stanza prenotata e per ogni eventuale servizio aggiuntivo utilizzato
Input:la data odierna
Output:i pagamenti da effettuare
Frequenza giornaliera:1
*/

DROP PROCEDURE IF EXISTS OP3_incassa_prenotazioni_del_giorno;
DELIMITER $$
CREATE PROCEDURE OP3_incassa_prenotazioni_del_giorno
	(IN _day DATE)
BEGIN
  DECLARE finito INTEGER DEFAULT 0;
  DECLARE costo_stanze INTEGER UNSIGNED DEFAULT 0;
  DECLARE costo_servizi INTEGER UNSIGNED DEFAULT 0;
	DECLARE cliente VARCHAR(16) DEFAULT "";
	DECLARE cursore CURSOR FOR
		SELECT PS.codCliente
		FROM PrenotazioneStanza PS
        WHERE PS.dataPartenza = _day;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO cliente;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
        
        /*calcola costo delle stanze prenotate*/
        SELECT SUM(S.costoGiornaliero * DATEDIFF(PS.dataPartenza, PS.dataArrivo)) -- si considerano le notti, quindi la differenza in giorni
        FROM PrenotazioneStanza PS INNER JOIN Stanza S
			ON PS.numStanza = S.numStanza AND PS.nomeAgriturismo = S.codAgriturismo
        WHERE PS.codCliente = cliente
			AND PS.dataPartenza = _day INTO costo_stanze;
        
        /*calcola il costo dei servizi utilizzati*/
        SELECT SUM(SA.costo * (DATEDIFF(SPS.dataFineUtilizzo, SPS.dataInizioUtilizzo) + 1)) -- la data di fine utilizzo è da comprendere nei giorni di utilizzo
        FROM PrenotazioneStanza PS INNER JOIN ServizioPerStanza SPS
			ON PS.dataArrivo = SPS.dataArrivo
				AND PS.numStanza = SPS.numStanza
                AND PS.nomeAgriturismo = SPS.nomeAgriturismo
                AND PS.codCliente = SPS.codCliente INNER JOIN ServizioAggiuntivo SA
			ON SPS.codServizio = SA.tipoServizio
		WHERE PS.codCliente = cliente
			AND PS.dataPartenza = _day INTO costo_servizi;
          
		/*inserisci i valori come nuovo pagamento da effettuare*/
		INSERT INTO 
			Pagamenti(tipoPagamento, 
						totaleCosto,
						codCliente)
			VALUES ('stanza',
					costo_stanze + costo_servizi,
					cliente);
		-- CALL LOG(CONCAT("cstanze: ", costo_stanze, " cservizi: ", costo_servizi));
	END LOOP preleva;
	CLOSE cursore;
END $$
DELIMITER ;

DROP EVENT IF EXISTS controllo_pagamenti;
CREATE EVENT controllo_pagamenti
ON SCHEDULE EVERY 1 DAY 
STARTS '2021-01-01 00:00:01'
DO CALL OP3_incassa_prenotazioni_del_giorno(CURRENT_DATE());

/*-------------------------------------------------------------OK

Operazione 4: Stoccaggio del latte munto
Descrizione:Il latte munto viene conservato in appositi silos contenenti tutti latte
con composizione chimico-fisica simile
Input:data e ora della mungitura, oltre che il codice del latte munto
Output:Aggiornamento della quntità stoccata nel corretto silos
Frequenza giornaliera:15000
*/

DROP FUNCTION IF EXISTS first_available_silo;
DELIMITER $$
CREATE FUNCTION first_available_silo() 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
	SET return_value = 1;
	WHILE (SELECT S.codice
			FROM Silos S
            WHERE S.codice = return_value) IS NOT NULL DO
		SET return_value = return_value + 1;
	END WHILE;
    RETURN (return_value);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS OP4_stoccaggio_latte;
DELIMITER $$
CREATE PROCEDURE OP4_stoccaggio_latte
	(/*mungitura*/
    IN _data_ora TIMESTAMP,
    IN _animale SMALLINT UNSIGNED,
    IN _mungitrice SMALLINT UNSIGNED,
    /*latte*/
    IN _codLatte SMALLINT UNSIGNED)
BEGIN

/*cerca il silos che ha la minor differenza tra 
  la quantità di sostanze disciolte nel latte
  con la media delle sostanze dei latti già stoccati in quel silo*/
SELECT S.codice, ABS((
			SELECT L.quantitàSostanzeDisciolte
			FROM Latte L
			WHERE L.codiceLatte = _codLatte) - 
            (
            SELECT AVG(L1.quantitàSostanzeDisciolte)
			FROM Silos S1 INNER JOIN Latte L1 ON S1.codice = L1.codSilos
			WHERE S1.codice = S.codice
			) 
		)
FROM Silos S
WHERE ABS((
			SELECT L.quantitàSostanzeDisciolte
			FROM Latte L
			WHERE L.codiceLatte = _codLatte) - 
            (
            SELECT AVG(L1.quantitàSostanzeDisciolte)
			FROM Silos S1 INNER JOIN Latte L1 ON S1.codice = L1.codSilos
			WHERE S1.codice = S.codice
			) 
		) = 
		(
		SELECT MIN(ABS((
			SELECT L2.quantitàSostanzeDisciolte
			FROM Latte L2
			WHERE L2.codiceLatte = _codLatte
			) - 
			(
			SELECT AVG(L3.quantitàSostanzeDisciolte)
			FROM Silos S3 INNER JOIN Latte L3 ON S3.codice = L3.codSilos
			WHERE S3.codice = S4.codice
            )
		)
	)
	FROM Silos S4
)LIMIT 1 INTO @silo, @diff;

-- CALL LOG(CONCAT("silo è : ", @silo, "; diff è: ", @diff));

/*controlla se c'è spazio nel silos*/
IF (SELECT S.capacità - S.livello
	FROM Silos S
    WHERE S.codice = @silo) < 
    (SELECT M.quantità
    FROM Mungitura M
    WHERE M.codAnimale = _animale
		AND M.codMungitrice = _mungitrice
        AND M.data_orario = _data_ora) THEN
	/* se non c'è spazio, controlla se esiste già un silos vuoto*/
    SET @silo = (SELECT IFNULL ((SELECT S.codice FROM Silos S WHERE S.livello = 0), NULL));
    IF @silo IS NULL THEN
		-- CALL LOG(CONCAT("silo è diventato null!"));
		SET @silo = first_available_silo();
		/*se non c'è, creane uno nuovo (valore capacità di default da scegliere)*/
		INSERT INTO Silos (codice, capacità, livello)
			VALUES (@silo, 1000, (SELECT M.quantità
									FROM Mungitura M
									WHERE M.codAnimale = _animale
										AND M.codMungitrice = _mungitrice
										AND M.data_orario = _data_ora));
		/*usare il nuovo silo per aggiornare dove è stoccato il latte*/
		/*SET @silo = (SELECT MAX(S.codice)
					FROM Silos S);*/
	ELSE
        /*se c'è, aumentare il livello di quel silos
          (direttamente la quantità, in quanto il silo è vuoto)*/
			-- CALL LOG(CONCAT("allora c'è e vale: ", @silo, " infatti livello è: ", (select S.livello FROM Silos S WHERE S.codice = @silo)));
			UPDATE Silos
            SET livello = /*livello + */(SELECT M.quantità
									FROM Mungitura M
									WHERE M.codAnimale = _animale
										AND M.codMungitrice = _mungitrice
										AND M.data_orario = _data_ora)
			WHERE codice = @silo;
    END IF;
    
ELSE
    /*se c'è spazio nel silo, aggiungi la quantità munta al livello*/
		UPDATE Silos
		SET livello = livello + (SELECT M.quantità
								FROM Mungitura M
								WHERE M.codAnimale = _animale
									AND M.codMungitrice = _mungitrice
									AND M.data_orario = _data_ora)
		WHERE codice = @silo;
END IF;

-- CALL LOG(CONCAT("silo dopo il controllo: ", @silo));

/*aggiornare in quale silo è stato stoccato il latte*/
UPDATE Latte
SET codSilos = @silo
WHERE codiceLatte = _codLatte;

END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Operazione 5: Controllo igiene dei locali
Descrizione:Per garantire il rispetto delle condizioni di benessere degli animali
all’interno dei locali, viene frequentemente controllato che i parametri rilevati 
rientrino nelle soglie di tollerabilità, ed eventualmente viene inviata una richiesta
di intervento di pulizia, insieme all’aggiornamento dei parametri del locale con i
valori più recenti raccolti
Input:Il codice del locale da controllare
Output:Richiesta d’intervento di pulizia
Frequenza giornaliera:40
*/

DROP PROCEDURE IF EXISTS OP5_controllo_igiene_locali;
DELIMITER $$
CREATE PROCEDURE OP5_controllo_igiene_locali
	(/*IN _locale SMALLINT UNSIGNED*/)
BEGIN

DECLARE finito INTEGER DEFAULT 0;
DECLARE locale SMALLINT UNSIGNED DEFAULT NULL;
DECLARE cursore CURSOR FOR
	SELECT L.codiceLocale
    FROM Locale L;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

OPEN cursore;

/*per ogni locale*/
preleva: LOOP
	FETCH cursore INTO locale;
    IF finito = 1 THEN
		LEAVE preleva;
	END IF;
    /*considera le medie di tutti i sensori nel locale*/
    SELECT AVG(V.livelloSporcizia)
    FROM Visivi V
    WHERE V.codLocale = locale INTO @media_sporcizia;
    
    SELECT AVG(A.temperatura)
    FROM Ambientali A
    WHERE A.codLocale = locale INTO @media_temperatura;
    
    SELECT AVG(A.umidità)
    FROM Ambientali A
    WHERE A.codLocale = locale INTO @media_umidita;
    
    SELECT AVG(CV.concentrazioneMetano)
    FROM CompostiVolatili CV
    WHERE CV.codLocale = locale INTO @media_metano;
    
    SELECT AVG(CV.concentrazioneAzoto)
    FROM CompostiVolatili CV
    WHERE CV.codLocale = locale INTO @media_azoto;
    
    /*aggiorna temperatura e umidità medi*/
    UPDATE Locale
    SET temperatura = @media_temperatura
    , umidità = @media_umidita
    WHERE codiceLocale = locale;
    
    /*considera le soglie di tollerabilità*/
    SELECT L.tollerabilitaAzoto, L.tollerabilitaSporcizia, L.tollerabilitaMetano
    FROM Locale L
    WHERE L.codiceLocale = locale INTO @max_azoto, @max_sporcizia, @max_metano;
    
    /*se anche solo uno di questi valori supera la soglia consentita*/
    IF @media_azoto > @max_azoto OR @media_sporcizia > @max_sporcizia OR @media_metano > @max_metano THEN
		/*effettua una nuova richiesta d'intervento di pulizia per il locale*/
		INSERT INTO PuliziaLocale (codLocale, data_orarioRilevazione, stato, personale, concentrazioneMetano, concentrazioneAzoto, livelloSporcizia)
        VALUES (locale, CURRENT_TIMESTAMP(), 'pendente', 'personale per la pulizia del locale', @media_metano, @media_azoto, @media_sporcizia);
    END IF;
    
END LOOP preleva;
CLOSE cursore;

END $$
DELIMITER ;

DROP EVENT IF EXISTS controllo_igiene_locali;
CREATE EVENT controllo_igiene_locali
ON SCHEDULE EVERY 12 HOUR 
STARTS '2021-01-01 00:08:00'
DO CALL OP5_controllo_igiene_locali();

/*-------------------------------------------------------------OK

Operazione 6: Processamento degli ordini
Descrizione:Gli utenti che si sono registrati nello store online possono acquistare i
prodotti caseari e ricevere il proprio ordine tramite le spedizioni gestite dal database
Input:Il codice del nuovo ordine effettuato dal cliente sullo store online
Output:Processamento ed invio dell’ordine
Frequenza giornaliera:400
*/

/*vincolo X controlla già la disponibilità dell'ordine!!*/

DROP PROCEDURE IF EXISTS OP6_processamento_ordini;
DELIMITER $$
CREATE PROCEDURE OP6_processamento_ordini
	(IN _codiceOrdine	SMALLINT UNSIGNED)
BEGIN
	DECLARE totale INTEGER UNSIGNED DEFAULT 0;
    DECLARE cliente CHAR(16);

  SELECT SUM(CO.quantità * FP.prezzo) INTO totale
  FROM ContenutoOrdine CO INNER JOIN FormaggioProdotto FP ON CO.codFormaggioprodotto = FP.codiceProdotto
  WHERE CO.codOrdine = _codiceOrdine;
    
  SELECT A.codiceCarta INTO cliente
  FROM OrdineProdotti OP INNER JOIN Account A ON OP.utente = A.utente AND OP.password = A.password
  WHERE OP.codiceOrdine = _codiceOrdine;
  
  INSERT INTO Pagamenti (codPagamento, tipoPagamento, totaleCosto, dataPagamento, codCliente)
	VALUES (default, 'online', totale, NULL, cliente);

END $$
DELIMITER ;

/*
DROP TRIGGER IF EXISTS check_nuovo_ordine;
DELIMITER $$
CREATE TRIGGER check_nuovo_ordine
BEFORE INSERT ON Tabella
FOR EACH ROW 
BEGIN 
IF  THEN
	signal sqlstate '70006' SET MESSAGE_TEXT = 'ERRORE: ';
END IF;
SET NEW.attributo = ();
END $$
DELIMITER */



/*-------------------------------------------------------------OK

Operazione 7: Prescrizione delle terapie
Descrizione:Alla registrazione di una nuova terapia da parte di un veterinario,
viene controllato se questa è la terza consecutiva sullo stesso animale, nel qual
caso viene effettuato un ricollocamento in una zona di quarantena
Input:la nuova terapia e l’animale a cui è assegnata
Output:Trasferimanto dell’animale in un nuovo locale di quarantena
Frequenza giornaliera:110
*/

/*Ogni Agriturismo ha un locale di quarantena, identificato da un codice superiore a 10000*/
DROP FUNCTION IF EXISTS localeQuarantena;
DELIMITER $$
CREATE FUNCTION localeQuarantena(
    _locale SMALLINT UNSIGNED
) 
RETURNS SMALLINT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE return_value SMALLINT UNSIGNED;
 
    SELECT L.codiceLocale
    FROM Locale L
    WHERE L.codiceLocale > 10000 -- soglia oltre la quale il locale è di quarantena
		AND 40 > (SELECT COUNT(A.codice)
					FROM Animale A
                    WHERE A.codLocale = L.codiceLocale)
		AND L.nomeAgriturismo = (SELECT L1.nomeAgriturismo
								FROM Locale L1
                                WHERE L1.codiceLocale = _locale) 
	LIMIT 1 INTO return_value;
    RETURN (return_value);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS OP7_check_nuova_terapia;
DELIMITER $$
CREATE TRIGGER OP7_check_nuova_terapia
BEFORE INSERT ON Terapia
FOR EACH ROW 
BEGIN 

SET @terapia = (SELECT IFNULL((SELECT T.codiceTerapia
	FROM Terapia T
    WHERE T.codAnimale = NEW.codAnimale
        AND T.dataInizio + INTERVAL T.durata DAY  >= NEW.dataInizio
        AND T.secondaTerapiaConsecutiva
        AND T.codiceTerapia <> NEW.codiceTerapia), NULL));
	
SET @terapia2 = (SELECT IFNULL((SELECT T.codiceTerapia
		FROM Terapia T
		WHERE T.codAnimale = NEW.codAnimale
			AND T.dataInizio + INTERVAL T.durata DAY  >= NEW.DataInizio
			AND NOT T.secondaTerapiaConsecutiva
            AND T.codiceTerapia <> NEW.codiceTerapia ), NULL));


IF @terapia IS NOT NULL THEN
	-- CALL LOG(CONCAT("if1->terapia: ", @terapia, " ", NEW.codiceTerapia));

	UPDATE Animale
    SET codLocale = localeQuarantena(codLocale)
    WHERE codice = NEW.codAnimale;
ELSEIF @terapia2 IS NOT NULL THEN
	-- CALL LOG(CONCAT("if2->terapia2: ", @terapia2, " ", NEW.codiceTerapia));

	SET NEW.secondaTerapiaConsecutiva = 1;
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Operazione 8: Controllo degli animali dispersi
Descrizione:Durante le attività di pascolo viene monitorato ad intervalli regolari
il segnale GPS di ogni singolo animale affinchè ci si assicuri che rientri negli spazi
delimitati dalle recinzioni per le zone dedicate al pascolo
Input:codice dell’attività di pascolo
Output:segnalazione se l’animale è disperso
Frequenza giornaliera:3968
*/

DROP TABLE IF EXISTS animali_dispersi;
CREATE TABLE animali_dispersi(
	date TIMESTAMP PRIMARY KEY,
    dispersi VARCHAR(1024)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP EVENT IF EXISTS controllo_attivita_pascolo;
DELIMITER $$
CREATE EVENT controllo_attivita_pascolo
ON SCHEDULE EVERY 15 MINUTE 
STARTS '2021-01-01 00:00:01'
DO 
BEGIN
	CALL attivita_in_data(CURRENT_DATE(), @void);
    -- CALL LOG(CONCAT("void: ", IFNULL(@void, 'null')));
    INSERT INTO animali_dispersi VALUES(CURRENT_TIMESTAMP(), @void);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS attivita_in_data;
DELIMITER $$
CREATE PROCEDURE attivita_in_data
	(IN _data DATE,
    OUT dispersi_ VARCHAR(1024))
BEGIN
	DECLARE finito INTEGER DEFAULT 0;
	DECLARE attivita SMALLINT UNSIGNED DEFAULT NULL;
	DECLARE cursore CURSOR FOR
		SELECT AP.codiceAttivita
        FROM AttivitaPascolo AP
        WHERE DATE_FORMAT(AP.giorno_orario, '%Y-%m-%d') = _data;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;
	SET dispersi_ = "";
	OPEN cursore;

	preleva: LOOP
		FETCH cursore INTO attivita;
		IF finito = 1 THEN
			LEAVE preleva;
		END IF;
        CALL OP8_check_animali_dispersi(attivita, @disp);
        SET dispersi_ = CONCAT(dispersi_, "-Attivita: ", attivita, " dispersi: ", IFNULL(@disp, 'nessuno'));
        -- CALL LOG(CONCAT("dispersi_: ", IFNULL(dispersi_, 'null')));
	END LOOP preleva;
	CLOSE cursore;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS OP8_check_animali_dispersi;
DELIMITER $$
CREATE PROCEDURE OP8_check_animali_dispersi
	(IN _attivita SMALLINT UNSIGNED,
    OUT animali_dispersi VARCHAR(255))
BEGIN

    
    SELECT GROUP_CONCAT(A.codice SEPARATOR ';')
    FROM Animale A
    WHERE A.codLocale = (SELECT AP.codLocale
							FROM AttivitaPascolo AP
                            WHERE AP.codiceAttivita = _attivita)
		AND 50 < -- distanza oltre la quale un animale è definito disperso
			(SELECT MIN(SQRT(POW(A.longitudine - RD.longitudine, 2)+POW(A.latitudine - RD.latitudine, 2)))
			FROM RecinzioneDivisoriaeZoneDiPascolo RD
			WHERE RD.codArea = (SELECT AP1.codArea
								FROM AttivitaPascolo AP1
								WHERE AP1.codiceAttivita = _attivita) ) INTO animali_dispersi;
	-- CALL LOG(CONCAT("animali_dispersi: ", IFNULL(animali_dispersi, 'null')));


END $$
DELIMITER ;


/*-------------------------------------------------------------OK

perazione 9: Registrazione nuovo account
Descrizione:All’ inserimento di un nuovo account nello store online, viene 
controllato se i dati inseriti corrispondono a quelli di un cliente già registrato ma senza
un account. Nel caso viene aggiunto un record in Account con i dati forniti 
durante la registrazione, altrimenti viene prima registrato il nuovo cliente a partire
dal codice della sua carta
Input:anagrafica del cliente, dati dei documenti e informazioni sull’account daregistrare
Output:aggiunta di un account e del cliente che lo possiede
Frequenza giornaliera:19
*/

DROP TRIGGER IF EXISTS OP9_check_nuovo_account;
DELIMITER $$
CREATE TRIGGER OP9_check_nuovo_account
BEFORE INSERT ON Account
FOR EACH ROW 
BEGIN 
IF NEW.codiceCarta NOT IN (SELECT C.codCarta
							FROM Cliente C) THEN
	INSERT INTO Cliente (codCarta) VALUES (NEW.codiceCarta);
END IF;
END $$
DELIMITER ;

/*-------------------------------------------------------------OK

Operazione 10: Ridistribuzione degli animali all’aggiunta di unnuovo locale
Descrizione:All’aggiunta di un nuovo locale, vengono smistati gli animali già
presenti nella stalla affinchè sia mantenuto costante il numero di animali per locale
Input:dati del nuovo locale e codice della stalla a cui appartiene
Output:ridistribuzione degli animali nel nuovo locale aggiunto e registrazione deinuovi sensori
Frequenza giornaliera:0.27
*/

DROP PROCEDURE IF EXISTS ridistrubuzione_in_stalla;
DELIMITER $$
CREATE PROCEDURE ridistrubuzione_in_stalla
	(IN _stalla TINYINT UNSIGNED,
    IN _locale SMALLINT UNSIGNED)
BEGIN
	DECLARE num_animali INTEGER DEFAULT 0;
	DECLARE num_locali INTEGER DEFAULT 0;
    DECLARE da_togliere INTEGER DEFAULT 0;
    
	DECLARE finito INTEGER DEFAULT 0;
	DECLARE locali SMALLINT UNSIGNED DEFAULT NULL;
	DECLARE cursore CURSOR FOR
		SELECT L.codiceLocale
        FROM Locale L
        WHERE L.codiceStalla = _stalla;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finito = 1;

	SELECT COUNT(A.codice)
	FROM Animale A INNER JOIN Locale L ON A.codLocale = L.codiceLocale
	WHERE L.codiceStalla = _stalla INTO num_animali; -- in una stalla

	SELECT COUNT(L.codiceLocale) -- + 1 considerare il locale che deve essere aggiunto
	FROM Locale L
	WHERE L.codiceStalla = _stalla INTO num_locali; -- in una stalla
    
	CALL LOG(CONCAT("num_animali: ", num_animali, " num_locali: ", num_locali));

    IF num_locali > 1 THEN
  
		SET da_togliere = (FLOOR(num_animali / (num_locali - 1)) - FLOOR(num_animali / (num_locali)));
		CALL LOG(CONCAT("da togliere: ", da_togliere));


		OPEN cursore;

		preleva: LOOP
			FETCH cursore INTO locali;
			IF finito = 1 THEN
				LEAVE preleva;
			END IF;
				UPDATE Animale AS A INNER JOIN (SELECT A2.codice
												FROM Animale A2
												WHERE A2.codLocale = locali
												LIMIT da_togliere) AS A2 ON A.codice = A2.codice
				SET A.codLocale = _locale;
				-- WHERE codice IN (SELECT A.codice
				-- 				FROM Animale A );
		END LOOP preleva;
		CLOSE cursore;
	END IF;
  	
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS OP10_ridistribuzione_animali;
DELIMITER $$
CREATE TRIGGER OP10_ridistribuzione_animali
AFTER INSERT ON Locale
FOR EACH ROW 
BEGIN 
	CALL ridistrubuzione_in_stalla(NEW.codiceStalla, NEW.codiceLocale);
END $$
DELIMITER ;

/*----Popolamento tabelle-----*/


INSERT INTO Agriturismo (Nome)
	VALUES ('Borgo Tramonte');
INSERT INTO Agriturismo (Nome)
	VALUES ('Le Valli di Castelfiorentino');
INSERT INTO Agriturismo (Nome)
	VALUES ('Campetroso');
INSERT INTO Agriturismo (Nome)
	VALUES ('Fattoria I Ricci - Agriresort & SPA');
INSERT INTO Agriturismo (Nome)
	VALUES ('Selvoli');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Palazzino');
INSERT INTO Agriturismo (Nome)
	VALUES ('Le Murelle');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Castelluccio Country Resort');
INSERT INTO Agriturismo (Nome)
	VALUES ('Renello');
INSERT INTO Agriturismo (Nome)
	VALUES ('Eco Organic Resort and Luxury Glamping Sant Egle');
INSERT INTO Agriturismo (Nome)
	VALUES ('Podere la Piana');
INSERT INTO Agriturismo (Nome)
	VALUES ('Renai e Monte');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Greppo');
INSERT INTO Agriturismo (Nome)
	VALUES ('I Pianelli');
INSERT INTO Agriturismo (Nome)
	VALUES ('Pieve Sprenna');
INSERT INTO Agriturismo (Nome)
	VALUES ('Settesoldi');
INSERT INTO Agriturismo (Nome)
	VALUES ('Il Piaggione');
INSERT INTO Agriturismo (Nome)
	VALUES ('La Landuccia');
INSERT INTO Agriturismo (Nome)
	VALUES ('La Palazzina');
INSERT INTO Agriturismo (Nome)
	VALUES ('Poggiacolle');

INSERT INTO Stalla (numProgressivo, nomeAgriturismo)
	VALUES (default, 'Settesoldi');
INSERT INTO CaratteristichePerTipoLocale (specieOspitata, altezza, lunghezza, larghezza, capienzaMax, pavimentazione)
	VALUES ('bos lobe', 486, 2299, 1096, 45, 'trattamento antiscivolo con resine epissidiche');
INSERT INTO Locale (codiceLocale, temperatura, umidità, orientazioneFinestre, tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano, codiceStalla, nomeAgriturismo, specieOspitata, altezza, lunghezza, larghezza)
	VALUES (default, 20, 39, 'S', 18, 5, 5, 1, 'Settesoldi', 'bos lobe', 486, 2299, 1096);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (default, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (default, 'F', 'bos lobe', 'tetracerus', NULL, NULL, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2013-04-12 19:43:25', 2, 1);
INSERT INTO Fornitore (ragioneSociale, indirizzo, partitaIva)
	VALUES ('Bellini S.p.a. ', 'viale Fiore n.20', 96179312746);
INSERT INTO acquistoanimale (codiceAnimale, ragioneSocialeFornitore, dataAcquisto, dataArrivo)
	VALUES (1, 'Bellini S.p.a. ', '1941-06-14', '1959-03-04');
INSERT INTO Veterinario (codiceFiscale, nome, cognome, contatto)
	VALUES ('BLLDNC38A18E290R', 'Domenico', 'Bellini', 6773261698);
INSERT INTO Riproduzione (codiceRiproduzione, complicanza, data_orario, stato, codVeterinario, codiceMadre, codicePadre)
	VALUES (default, 'Sed ut ligula sit amet dolor ultrices efficitu. Cras varius nisl mollis mollis tempo. Nullam velit m  fermentum vitae lacinia u  consectetur vitae null. Suspendisse sed arcu vel eros convallis sagittis non ut torto. Sed sed tortor in erat facilisis pretium commodo in nis. ', '1977-05-19 18:13:15', 'successo', 'BLLDNC38A18E290R', 2, 1);
INSERT INTO Animale (codice, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita, altezza, peso, razza, latitudine, longitudine, orario, codiceGps, codLocale)
	VALUES (default, 'F', 'bos lobe', 'tetracerus', 2, 1, '1977-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2019-03-20 18:13:15', 3, 1);
INSERT INTO SchedaGestazione (codiceGestazione, codRiproduzione, codVeterinario)
	VALUES (default, 1, 'BLLDNC38A18E290R');
INSERT INTO Visivi (codiceVisivo, livelloSporcizia, orarioRilevazione, codLocale)
	VALUES (default, 1, '2019-09-16 23:39:20', 1);
INSERT INTO Ambientali (codiceAmbientale, temperatura, umidità, orarioRilevazione, codLocale)
	VALUES (default, 1, 48, '2019-09-27 21:35:52', 1);
INSERT INTO CompostiVolatili (codiceVolatili, concentrazioneMetano, concentrazioneAzoto, orarioRilevazione, codLocale)
	VALUES (default, 1, 18, '2019-05-23 22:55:56', 1);
INSERT INTO Illuminazione (codice, consumoEnergetico,codLocale)
	VALUES (default, 43, 1);
INSERT INTO CondizionatoreAria (codice, consumoEnergetico,codLocale)
	VALUES (default, 43, 1);
INSERT INTO PuliziaLocale (codLocale, data_orarioRilevazione, stato, personale, concentrazioneMetano, concentrazioneAzoto, livelloSporcizia)
	VALUES (1, '2019-10-22 20:42:53', 'effettuato', 'Donec vulputate risus du  in faucibus libero tempor i. Proin quis erat condimentu  aliquet dolor eleifen  interdum dolo. Vivamus condimentum lorem nec libero convalli  sed auctor quam malesuad. Maecenas eget nibh sit amet ante efficitur aliqua. Mauris eu cursus sapie. Nulla sit ', 78, 81, 90);
INSERT INTO Foraggio (fibre, proteine, glucidi, cereali, frutta, piante, forma, kcalkg)
	VALUES (103, 967, 878, 39, 3, 10, 'insilato', 5500);
INSERT INTO Acqua (concentrazioneSali, concentrazioneVitamine)
	VALUES (10, 5);
INSERT INTO Pasto (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (103, 967, 878, 10, 5);
INSERT INTO PastoPerLocale (giorno_orario, codLocale, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES ('2019-01-04 01:39:20', 1, 103, 967, 878, 10, 5);
INSERT INTO Mangiatoia (codice, quantitàRestante, codLocale)
	VALUES (default, 5, 1);
INSERT INTO Abbeveratoio (codice, quantitàRestante, codLocale)
	VALUES (default, 49, 1);
INSERT INTO AreaPascolo (codiceArea)
	VALUES (default);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo (codiceZona, codArea, longitudine, latitudine)
	VALUES (default, 1, 62.948, 116.393);
INSERT INTO AttivitaPascolo (codiceAttivita, giorno_orario, codLocale, codArea)
	VALUES (default, '2019-06-12 07:50:44', 1, 1);
INSERT INTO Mungitrice (codice, longitudine, latitudine, marca, modello)
	VALUES (default, 121.995, 20.170, 'laoreet i. Sed id consectetur ipsu. Vivamus mollis magna in lectus finibu  quis vulputate turpis facilisi.Proin vitae imperdiet nequ. Pellentesque nisl veli  congue a consequat i  sollicitudin efficitur ero. Nulla facilis. Sed viverra velit eget velit vehicula loborti. Pellentesque semper ', 'ut ullamcorpe. Quisque sit amet augue eget purus tincidunt port. Vestibulum vel tortor molesti  ullamcorper felis i  aliquet ero. Morbi magna sapie  pharetra nec pretium i  sollicitudin quis metu. Sed porttitor condimentum nisl quis suscipi. Etiam et orci risu. Integer sed ');
INSERT INTO Mungitura (codAnimale, codMungitrice, data_orario, quantità)
	VALUES (2, 1, '2019-12-18 06:25:53', 94);
INSERT INTO Silos (codice, capacità, livello)
	VALUES (default, 488, 661);
INSERT INTO Latte (codiceLatte, quantitàSostanzeDisciolte, codAnimale, codSilos)
	VALUES (default, 62, 1, 0);
INSERT INTO chemunge (codLatte, codMungitrice)
	VALUES (1, 1);
INSERT INTO Lotto (codiceLotto, codDipendenti, dataProd, codLab, durata)
	VALUES (default, 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-04-07', 10, '10:57:01');
INSERT INTO prodottocon (codLatte, codLotto)
	VALUES (1, 1);
INSERT INTO Cantine (codice)
	VALUES (default);
INSERT INTO stoccaggiocantine (codLotto, codCantina)
	VALUES (1, 1);
INSERT INTO Magazzini (codice)
	VALUES (default);
INSERT INTO stoccaggiomagazzini (codLotto, codMagazzino)
	VALUES (1, 1);
INSERT INTO Scaffalature (codCantina, codice)
	VALUES (1, 4);
INSERT INTO Parametri (dataParametri, idSensore, temperatura, umidità, codCantina)
	VALUES ('2019-01-04', 67, 26, 17, 1);
INSERT INTO Scaffali (codice, codMagazzino)
	VALUES (0, 1);
INSERT INTO Fasi (codiceFase, nome, durata_fase_ideale, temperatura_latte_ideale, tempo_riposo_ideale, durata)
	VALUES (default, 'Maecenas mattis ex id elementum molesti. Donec in facilisis just. Nam vel leo a sem sodales vestibulu. Nulla pharetra erat a justo dignissi  quis volutpat nulla rutru. Proin convallis urna laoreet mollis matti. Vivamus id placerat ligul. Aliquam nunc nis  vestibulum et lorem ', 35, 22, 96, '23:22:48');
INSERT INTO ControlloParametriFase (durata_fase_effettiva, temperatura_latte_effettiva, tempo_riposo_effettiva, codLotto, codFase)
	VALUES (36, 29, 49, 1, 1);
INSERT INTO Ricetta (codiceRicetta, collocazioneGeografica, ricetta, durataStagionatura)
	VALUES (default, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');
INSERT INTO divisain (codRicetta, codFase)
	VALUES (1, 1);
INSERT INTO Formaggio (nome, nomeAgriturismo, deperibilita, codRicetta)
	VALUES ('Bitto', 'Settesoldi', 30, 1);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (1, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (2, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Indicisalute (codAnimale, dataRilevazione, tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione, deambulazione, fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
	VALUES (3, '2019-02-07', 12, 34, 95, 48, 82, 103, 967, 878, 10, 5);
INSERT INTO Visita (codiceVisita, esito, descrizione, dataEffettiva, dataProgrammata, codAnimale, codVeterinario)
	VALUES (default, 'positiva', 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-05-20', '2019-03-06', 3, 'BLLDNC38A18E290R');
INSERT INTO Esame (codiceEsame, descrizione, dataEsame, macchinario, nome, codAnimale, codVeterinario)
	VALUES (default, 'Vivamus urna feli  scelerisque quis neque e  ornare dapibus nun. Morbi in nulla vel risus iaculis lacini. Proin eget mauris vel urna dapibus gravid. In at pharetra lore. Quisque at facilisis ipsu. Cras vehicula ut velit in aucto. Ut risus arc  maximus ', '2019-09-12', 'amet varius risu  nec accumsan ligul. Cras feugiat urna non rhoncus posuer.Mauris sagittis risus in metus feugia  et tempus mi aliqua. Donec quis eros veli. Cras sollicitudin felis eget orci consequa  at sodales magna tincidun. Mauris quis mauris qua. Lorem ipsum ', 'est sed pulvina. Vestibulum vitae velit vehicul  finibus dui i  convallis turpi.Vivamus et enim torto. Ut facilisis finibus sempe. Curabitur blandit rutrum metu. Nulla rutrum nibh sed ante euismod cursu. Donec vitae ligula molli  pretium nisl ege  hendrerit mass. ', 3, 'BLLDNC38A18E290R');
INSERT INTO Terapia (codiceTerapia, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)
	VALUES (default, '2019-04-12', 14, 0, 2);
INSERT INTO Farmaco (nome, principioAttivo, dosaggio)
	VALUES ('VITAMINA E 30 MG FIALA 1 ML >10<','TOCOFEROLO ACETATO ALFA','30MG');
INSERT INTO compostada (codTerapia, nomeFarmaco, posologia)
	VALUES (1, 'VITAMINA E 30 MG FIALA 1 ML >10<', 'Nunc pretium arcu cursu  fringilla ex sagitti  volutpat just. Nullam magna puru  feugiat in dui ne  gravida scelerisque nis. Aliquam in risus consequa  ullamcorper est sit ame  rhoncus se. Duis id maximus le.Nullam sed ex aliquet risus imperdiet porttito. ');
INSERT INTO SchedaMedica (codiceScheda, massaMagra, carenze, patologie, dataScheda, rispostaOculare, emocromo, spessoreZoccolo, fegato, cuore, pancreas, codAnimale, codVeterinario)
	VALUES (default, 'Nam placerat ligula ant  in ', 'commod  feugiat ex a  dignissim ', 'du. Morbi faucibus molestie ', '2019-08-25', 'pharetra eget dia. Aliquam ', '.Proin suscipit dolor le  ', 'Donec eu semper arc.', 'sollicitudin neque nec elit scelerisque ', 'tristiqu  nisi nisi suscipit torto  ', 'ornare fermentu.Cras a ', 2, 'BLLDNC38A18E290R');
INSERT INTO DisturbiComportamentali (entità, nome, codScheda)
	VALUES ('Aenean cursus magna mauri  vel euismod ex sagittis a. Nulla rutrum dui nec semper lacini. Etiam porta sit amet lectus ac condimentu. Morbi nibh le  semper nec enim qui  tincidunt tempor ligul. Curabitur sed imperdiet es.Proin aliquam leo vel rutrum loborti. ', 'est sed pulvina. Vestibulum vitae velit vehicul  finibus dui i  convallis turpi.Vivamus et enim torto. Ut facilisis finibus sempe. Curabitur blandit rutrum metu. Nulla rutrum nibh sed ante euismod cursu. Donec vitae ligula molli  pretium nisl ege  hendrerit mass. ', 1);
INSERT INTO Lesioni (tipologia, parteDelCorpo, entità, codScheda)
	VALUES ('Aenean cursus magna mauri  vel euismod ex sagittis a. Nulla rutrum dui nec semper lacini. Etiam porta sit amet lectus ac condimentu. Morbi nibh le  semper nec enim qui  tincidunt tempor ligul. Curabitur sed imperdiet es.Proin aliquam leo vel rutrum loborti. ', 'Fusce et faucibus feli. Phasellus sempe  orci sed mattis consequa  massa libero ultricies tellu  at ultrices nisi mi eu dolo.Pellentesque vitae congue lectu. In id nunc bibendu  feugiat arcu a  lobortis tellu. Nunc eget sapien ac arcu facilisis mattis quis at ', 'at est ut magna vestibulum varius eu a ligul. Maecenas laoreet orci id est aliquam tincidun. Nullam aliquet nec orci eget porttito. Quisque iaculis id neque a commod. Phasellus aliquet enim sed sapien feugia  ut iaculis urna vehicul. Sed ex urn  pretium vitae ligula ', 1);
INSERT INTO Cliente (codCarta, anticipo)
	VALUES ('a30si59rr95jh99l', 41);
INSERT INTO Pagamenti (codPagamento, tipoPagamento, totaleCosto, dataPagamento, codCliente)
	VALUES (default, 'Donec vulputate risus du  in faucibus libero tempor i. Proin quis erat condimentu  aliquet dolor eleifen  interdum dolo. Vivamus condimentum lorem nec libero convalli  sed auctor quam malesuad. Maecenas eget nibh sit amet ante efficitur aliqua. Mauris eu cursus sapie. Nulla sit ', 689, '2019-08-26', 'a30si59rr95jh99l');
INSERT INTO Stanza (numStanza, codAgriturismo, costoGiornaliero, suite, numLetti, tipoLetti)
	VALUES (0, 'Settesoldi', 109, 'singola', 8, 'velit in hendreri. Aenean eu hendrerit just. Nulla pellentesque quis odio sed hendreri. Morbi non erat eu nulla semper tincidun. Vestibulum vel mi a nibh mollis eleifen.Aenean malesuada sollicitudin dapibu. Pellentesque posuere maximus sapie  vitae rhoncus nibh tempus no. Donec lobortis luctus ');
INSERT INTO PrenotazioneStanza (dataArrivo, numStanza, nomeAgriturismo, codCliente, dataPartenza)
	VALUES ('2019-01-05', 0, 'Settesoldi', 'a30si59rr95jh99l', '2019-07-07');
INSERT INTO ServizioAggiuntivo (tipoServizio, costo)
	VALUES ('catering', 78);
INSERT INTO ServizioperStanza (dataInizioUtilizzo, dataArrivo, numStanza, nomeAgriturismo, codCliente, codServizio, dataFineUtilizzo)
	VALUES ('2019-01-03', '2019-01-05', 0, 'Settesoldi', 'a30si59rr95jh99l', 'catering', '2019-03-02');
INSERT INTO Guida (codFisc, nome, cognome, contatto)
	VALUES ('GRSMGH82H54E897X', 'Margherita', 'Grassi', 4306886115);
INSERT INTO Escursione (codice, giorno_orario, codGuida)
	VALUES (default, '2019-12-14 20:59:04', 'GRSMGH82H54E897X');
INSERT INTO PrenotazioneEscursione (dataPrenotazione, codEscursione, codCliente)
	VALUES ('2019-01-03', 1, 'a30si59rr95jh99l');
INSERT INTO Itinerario (codice, numSentieri, codAgriturismo)
	VALUES (default, 'voglia famoso', 'Settesoldi');
INSERT INTO legataa (codEscursione, codItinerario)
	VALUES (1, 1);
INSERT INTO Tappe (nome, tempoPermanenza)
	VALUES ('braccio secondo', '06:52:43');
INSERT INTO compostoda (codItinerario, nomeTAppa)
	VALUES (1, 'braccio secondo');
INSERT INTO Account (utente, password, domandaRec, rispostaRec, numTelefono, codFiscale, nome, cognome, scadenzaDoc, numDoc, dataIscrizione, codDoc, enteRilascio, tipoDoc, indirizzo, codiceCarta)
	VALUES ('Domenica307', 'xforge', 'id tincidun.Donec fermentum porttitor urna nec ullamcorpe. Nunc blandit libero vitae sem cursus molesti. Quisque commodo non lacus at eleifen. Nunc iaculis lorem ligul  at fringilla nulla laoreet . In porta mi eu aliquet congu. Morbi volutpat quam lacu  quis luctus orci ', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 1146215520, 'RSSCRL94C07G224Y', 'Carlo', 'Rossetti', '2025-03-26', 'v07tr75yu82gj80d', '2018-09-16', 'i95se15mt65hi67p', 'Proin accumsan vitae arcu eu convalli. Quisque suscipit eros a augue rhoncus vestibulu. Mauris posuere risus a consequat gravid. Aenean ultricies metus quis lorem bibendu  sit amet ornare ante hendreri. In hac habitasse platea dictums. Suspendisse efficitur sollicitudin magn  at dictum velit efficitur eget.', 'Pellentesque nec lacinia orc. Donec consectetur nunc in odio laoreet fermentu. Morbi elementum in est sed luctu.Pellentesque ut justo non magna volutpat pulvina. Cras accumsan auctor ex id vehicul. Pellentesque vel aliquet magn. Sed non nunc odi. Mauris condimentu  nulla ac tincidunt ', 'via Moretti n.23', 'a30si59rr95jh99l');
INSERT INTO FormaggioProdotto (codiceProdotto, prezzo, peso, rimastiInStock, scadenza, lottoAppartenenza, nome, nomeAgriturismo)
	VALUES (default, 2, 641, 62, '2022-07-22', 1, 'Bitto', 'Settesoldi');
INSERT INTO Recensione (codiceRecensione, gradimentoGenerale, qualitaPercepita, conservazione, campoTestuale, gusto, utente, password, codProdotto)
	VALUES (default, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Domenica307', 'xforge', 1);
INSERT INTO Spedizione (codice, dataConsegnaEffettiva, dataConsegnaPrevista, percorso, stato)
	VALUES (default, '2019-10-06', '2019-09-03', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'spedita');
INSERT INTO OrdineProdotti (codiceOrdine, stato, data_ordine, tipoConsegnaReso, utente, password, codSpedizione)
	VALUES (default, 'in processazione', '2019-09-16', 0, 'Domenica307', 'xforge', 1);
INSERT INTO contenutoordine (codOrdine, codFormaggioprodotto, quantità, reso)
	VALUES (1, 1, 10, 0);
INSERT INTO CentridiSmistamento (codice, nome, indirizzo, contatto)
	VALUES (default, 'sagittis ipsum ultricies u. Integer ultricies magna eget justo volutpat consequa.Phasellus vulputate ultricies matti. Nunc laoreet odio urn  ut posuere sem porttitor e. Integer et leo augu. Phasellus ut porta era. Etiam vel sem molesti  mollis felis a  molestie ero. ', 'strada Russo n.83', 9184236689);
INSERT INTO processatada (codSpedizione, codcentro) 
	VALUES (1, 1);