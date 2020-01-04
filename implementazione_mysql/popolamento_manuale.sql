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
	sesso	ENUM('Maschio', 'Femmina') NOT NULL,
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
	codiceMadre	SMALLINT UNSIGNED,
	codicePadre	SMALLINT UNSIGNED,
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
	durata	time,
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
	deperibilita	TIME,
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
	tipologiaRespirazione	VARCHAR(20),
	lucentezzaPelo	VARCHAR(20),
	vigilanza	VARCHAR(20),
	idratazione	VARCHAR(20),
	deambulazione	VARCHAR(20),
	primary key (codAnimale, dataRilevazione),
	foreign key (codAnimale) references Animale(codice)
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
	data_ora_Pagamento	TIMESTAMP,
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
	stockAppartenenza	INT UNSIGNED NOT NULL,
	rimastiInStock	SMALLINT,
	scadenza	DATE NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	primary key (codiceProdotto),
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




INSERT INTO Agriturismo VALUES ('Settesoldi');
INSERT INTO Stalla VALUES (default, 'Settesoldi');
INSERT INTO CaratteristichePerTipoLocale VALUES ('arnee bianca', 486, 2299, 1096, 45, 'trattamento antiscivolo con resine epissidiche');
INSERT INTO Locale VALUES (default, 28, 39, 'S', 8, 5, 5, 1, 'Settesoldi', 'arnee bianca', 486, 2299, 1096);
INSERT INTO Animale VALUES (default, 'M', 'bos lobe', 'tetracerus', NULL, NULL, '1967-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2012-03-11 18:33:37', 1, 1);
INSERT INTO Animale VALUES (default, 'F', 'bos lobe', 'tetracerus', NULL, NULL, '1967-05-19', 92, 191, 'tedesca', 117.249, -178.780, '2013-04-12 19:43:25', 2, 1);
INSERT INTO Animale VALUES (default, 'F', 'bos lobe', 'tetracerus', 1, 2, '1967-05-19', 92, 191, 'tedesca', 117.249, -178.780, '019-03-20 18:13:15', 3, 1);
INSERT INTO Fornitore VALUES ('Bellini S.p.a. ', 'viale Fiore n.20', 96179312746);
INSERT INTO acquistoanimale VALUES (1, 'Bellini S.p.a. ', '1941-06-14', '1959-03-04');
INSERT INTO Veterinario VALUES ('BLLDNC38A18E290R', 'Domenico', 'Bellini', 6773261698);
INSERT INTO Riproduzione VALUES (default, 'Sed ut ligula sit amet dolor ultrices efficitu. Cras varius nisl mollis mollis tempo. Nullam velit m  fermentum vitae lacinia u  consectetur vitae null. Suspendisse sed arcu vel eros convallis sagittis non ut torto. Sed sed tortor in erat facilisis pretium commodo in nis. ', '2019-03-20 18:13:15', 'successo', 'BLLDNC38A18E290R', 1, 2);
INSERT INTO SchedaGestazione VALUES (default, 1, 'BLLDNC38A18E290R');
INSERT INTO Visivi VALUES (default, 1, '2019-09-16 23:39:20', 1);
INSERT INTO Ambientali VALUES (default, 1, 48, '2019-09-27 21:35:52', 1);
INSERT INTO CompostiVolatili VALUES (default, 1, 18, '2019-05-23 22:55:56', 1);
INSERT INTO PuliziaLocale VALUES (1, '2019-10-22 20:42:53', 'effettuato', 'Donec vulputate risus du  in faucibus libero tempor i. Proin quis erat condimentu  aliquet dolor eleifen  interdum dolo. Vivamus condimentum lorem nec libero convalli  sed auctor quam malesuad. Maecenas eget nibh sit amet ante efficitur aliqua. Mauris eu cursus sapie. Nulla sit ');
INSERT INTO Foraggio VALUES (103, 967, 878, 39, 3, 10, 'insilato', 5500);
INSERT INTO Acqua VALUES (10, 5);
INSERT INTO Pasto VALUES (103, 967, 878, 10, 5);
INSERT INTO PastoPerLocale VALUES ('2019-01-04 01:39:20', 1, 103, 967, 878, 10, 5);
INSERT INTO Mangiatoia VALUES (default, 5, 1);
INSERT INTO Abbeveratoio VALUES (default, 49, 1);
INSERT INTO AreaPascolo VALUES (default);
INSERT INTO RecinzioneDivisoriaeZoneDiPascolo VALUES (default, 1, 62.948, 116.393);
INSERT INTO AttivitaPascolo VALUES (default, '2019-05-12 07:50:44', 1, 1);
INSERT INTO Mungitrice VALUES (default, 121.995, 20.170, 'laoreet i. Sed id consectetur ipsu. Vivamus mollis magna in lectus finibu  quis vulputate turpis facilisi.Proin vitae imperdiet nequ. Pellentesque nisl veli  congue a consequat i  sollicitudin efficitur ero. Nulla facilis. Sed viverra velit eget velit vehicula loborti. Pellentesque semper ', 'ut ullamcorpe. Quisque sit amet augue eget purus tincidunt port. Vestibulum vel tortor molesti  ullamcorper felis i  aliquet ero. Morbi magna sapie  pharetra nec pretium i  sollicitudin quis metu. Sed porttitor condimentum nisl quis suscipi. Etiam et orci risu. Integer sed ');
INSERT INTO Mungitura VALUES (1, 1, '2019-12-18 06:25:53', 94);
INSERT INTO Silos VALUES (default, 488, 661);
INSERT INTO Latte VALUES (default, 62, 1, 0);
INSERT INTO chemunge VALUES (1, 1);
INSERT INTO Lotto VALUES (default, 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-04-07', 10, '10:57:01');
INSERT INTO prodottocon VALUES (1, 1);
INSERT INTO Cantine VALUES (default);
INSERT INTO stoccaggiocantine VALUES (1, 1);
INSERT INTO Magazzini VALUES (default);
INSERT INTO stoccaggiomagazzini VALUES (1, 1);
INSERT INTO Scaffalature VALUES (1, 4);
INSERT INTO Parametri VALUES ('2019-01-04', 67, 26, 17, 1);
INSERT INTO Scaffali VALUES (0, 1);
INSERT INTO Fasi VALUES (default, 'Maecenas mattis ex id elementum molesti. Donec in facilisis just. Nam vel leo a sem sodales vestibulu. Nulla pharetra erat a justo dignissi  quis volutpat nulla rutru. Proin convallis urna laoreet mollis matti. Vivamus id placerat ligul. Aliquam nunc nis  vestibulum et lorem ', 'Duis consequat aliquet augu  non pulvinar eni. Suspendisse sagittis tellus vitae nibh sodales volutpa. Duis lobortis arcu dolo  in rhoncus magna dapibus maximu. Aliquam quis nisi eu ligula suscipit ultricies sit amet quis eni. Morbi nec lorem magn.Aliquam vestibulum risus metu  et ', '23:22:48');
INSERT INTO ControlloParametriFase VALUES ('Class aptent taciti sociosqu ad litora torquent per conubia nostr  per inceptos himenaeo. Aliquam sit amet est mass. Proin eget accumsan dolo. Aliquam erat volutpa. Pellentesque lobortis lorem vel nisi iaculis euismod id quis mauri.Nullam tincidunt lorem eu dolor dapibus pretiu. In vehicula ', 1, 1);
INSERT INTO Ricetta VALUES (default, 'Veneto', 'tempo  ligula nec ultricies finibu  ipsum risus eleifend arc  ac iaculis orci arcu vitae era. Nam tristique sem se  eu cursus eros iaculis faucibu. Cras nulla ant  rhoncus a nisl qui  placerat ullamcorper lectu. In aliquet est eli  gravida sollicitudin velit ', '20:33:55');
INSERT INTO divisain VALUES (1, 1);
INSERT INTO Formaggio VALUES ('Bitto', 'Settesoldi', '03:38:18', 1, 1);
INSERT INTO Indicisalute VALUES (2, '2019-02-07', 'in turpis molli  ullamcorper ligula ege  aliquam nun.Nullam eget vehicula nis  quis elementum metu. Ut mollis eros vitae ante ultrice  sit amet egestas nulla sagitti. Proin ultrices eu orci vel posuer. Aenean luctus rutrum placera. Sed aliquam mollis vulputat. Morbi ', 'Etiam eget dictum magn. Praesent sollicitudin id est ut tristiqu. Nam ex liber  egestas id mi   interdum semper era. Fusce leo lacu  rutrum ut elit ne  cursus tincidunt metu. In hac habitasse platea dictums. Phasellus suscipit dui eu neque scelerisque faucibus. ', 'Curabitur congue in lacus in lacini. Integer nulla odi  blandit sit amet ipsum faucibu  ullamcorper condimentum le.Fusce a euismod eni. Aliquam consectetur egestas augu. Ut hendrerit fringilla tempo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Cur Nunc ', 'Ut imperdiet tincidunt se  sit amet congue justo suscipit ve. Fusce eu mattis se. Praesent eu pulvinar just  ac gravida mauri. Proin elit turpi  elementum ac aliquet ege  fringilla non tellu.Morbi id sodales urn. Vestibulum tincidunt tempor risus porttitor laoree. ', 'a purus eli. Quisque neque turpi  cursus vitae feugiat   tincidunt id urn. Pellentesque ultricies neque a purus consequat laoree. Sed purus lore  consequat id dictum a  lacinia ut eli. Nulla sodale  lorem vel ullamcorper congu  lorem urna finibus era  ');
INSERT INTO Visita VALUES (default, 'positiva', 'Sed auctor aliquam lacus sed elementu. Cras sed dictum tellu. Cras sed condimentum magn  eget molestie null. Sed a leo nun. In sollicitudin gravida vulputat. Fusce dapibus mollis tellu  quis consectetur urna auctor a. Pellentesque nec convallis ant  a pharetra ligul. ', '2019-05-20', '2019-03-06', 3, 'BLLDNC38A18E290R');
INSERT INTO Esame VALUES (default, 'Vivamus urna feli  scelerisque quis neque e  ornare dapibus nun. Morbi in nulla vel risus iaculis lacini. Proin eget mauris vel urna dapibus gravid. In at pharetra lore. Quisque at facilisis ipsu. Cras vehicula ut velit in aucto. Ut risus arc  maximus ', '2019-09-12', 'amet varius risu  nec accumsan ligul. Cras feugiat urna non rhoncus posuer.Mauris sagittis risus in metus feugia  et tempus mi aliqua. Donec quis eros veli. Cras sollicitudin felis eget orci consequa  at sodales magna tincidun. Mauris quis mauris qua. Lorem ipsum ', 'est sed pulvina. Vestibulum vitae velit vehicul  finibus dui i  convallis turpi.Vivamus et enim torto. Ut facilisis finibus sempe. Curabitur blandit rutrum metu. Nulla rutrum nibh sed ante euismod cursu. Donec vitae ligula molli  pretium nisl ege  hendrerit mass. ', 3, 'BLLDNC38A18E290R');
INSERT INTO Terapia VALUES (default, '2019-04-12', '00:12:09', 0, 2);
INSERT INTO Farmaco(nome,principioAttivo,dosaggio) VALUES ('VITAMINA E 30 MG FIALA 1 ML >10<','TOCOFEROLO ACETATO ALFA','30MG');
INSERT INTO compostada VALUES (1, 'VITAMINA E 30 MG FIALA 1 ML >10<', 'Nunc pretium arcu cursu  fringilla ex sagitti  volutpat just. Nullam magna puru  feugiat in dui ne  gravida scelerisque nis. Aliquam in risus consequa  ullamcorper est sit ame  rhoncus se. Duis id maximus le.Nullam sed ex aliquet risus imperdiet porttito. ');
INSERT INTO SchedaMedica VALUES (default, 'Nam placerat ligula ant  in ', 'commod  feugiat ex a  dignissim ', 'du. Morbi faucibus molestie ', '2019-08-25', 'pharetra eget dia. Aliquam ', '.Proin suscipit dolor le  ', 'Donec eu semper arc.', 'sollicitudin neque nec elit scelerisque ', 'tristiqu  nisi nisi suscipit torto  ', 'ornare fermentu.Cras a ', 2, 'BLLDNC38A18E290R');
INSERT INTO DisturbiComportamentali VALUES ('Aenean cursus magna mauri  vel euismod ex sagittis a. Nulla rutrum dui nec semper lacini. Etiam porta sit amet lectus ac condimentu. Morbi nibh le  semper nec enim qui  tincidunt tempor ligul. Curabitur sed imperdiet es.Proin aliquam leo vel rutrum loborti. ', 'est sed pulvina. Vestibulum vitae velit vehicul  finibus dui i  convallis turpi.Vivamus et enim torto. Ut facilisis finibus sempe. Curabitur blandit rutrum metu. Nulla rutrum nibh sed ante euismod cursu. Donec vitae ligula molli  pretium nisl ege  hendrerit mass. ', 1);
INSERT INTO Lesioni VALUES ('Aenean cursus magna mauri  vel euismod ex sagittis a. Nulla rutrum dui nec semper lacini. Etiam porta sit amet lectus ac condimentu. Morbi nibh le  semper nec enim qui  tincidunt tempor ligul. Curabitur sed imperdiet es.Proin aliquam leo vel rutrum loborti. ', 'Fusce et faucibus feli. Phasellus sempe  orci sed mattis consequa  massa libero ultricies tellu  at ultrices nisi mi eu dolo.Pellentesque vitae congue lectu. In id nunc bibendu  feugiat arcu a  lobortis tellu. Nunc eget sapien ac arcu facilisis mattis quis at ', 'at est ut magna vestibulum varius eu a ligul. Maecenas laoreet orci id est aliquam tincidun. Nullam aliquet nec orci eget porttito. Quisque iaculis id neque a commod. Phasellus aliquet enim sed sapien feugia  ut iaculis urna vehicul. Sed ex urn  pretium vitae ligula ', 1);
INSERT INTO Cliente VALUES ('a30si59rr95jh99l', 41);
INSERT INTO Pagamenti VALUES (default, 'Donec vulputate risus du  in faucibus libero tempor i. Proin quis erat condimentu  aliquet dolor eleifen  interdum dolo. Vivamus condimentum lorem nec libero convalli  sed auctor quam malesuad. Maecenas eget nibh sit amet ante efficitur aliqua. Mauris eu cursus sapie. Nulla sit ', 689, '2019-08-26 20:13:25', 'a30si59rr95jh99l');
INSERT INTO Stanza VALUES (0, 'Settesoldi', 109, 'singola', 8, 'velit in hendreri. Aenean eu hendrerit just. Nulla pellentesque quis odio sed hendreri. Morbi non erat eu nulla semper tincidun. Vestibulum vel mi a nibh mollis eleifen.Aenean malesuada sollicitudin dapibu. Pellentesque posuere maximus sapie  vitae rhoncus nibh tempus no. Donec lobortis luctus ');
INSERT INTO PrenotazioneStanza VALUES ('2019-01-05', 0, 'Settesoldi', 'a30si59rr95jh99l', '2019-07-07 06:01:55');
INSERT INTO ServizioAggiuntivo VALUES ('catering', 78);
INSERT INTO ServizioperStanza VALUES ('2019-01-03', '2019-01-05', 0, 'Settesoldi', 'a30si59rr95jh99l', 'catering', '2019-03-02');
INSERT INTO Guida VALUES ('GRSMGH82H54E897X', 'Margherita', 'Grassi', 4306886115);
INSERT INTO Escursione VALUES (default, '2019-12-14 20:59:04', 'GRSMGH82H54E897X');
INSERT INTO PrenotazioneEscursione VALUES ('2019-01-03', 1, 'a30si59rr95jh99l');
INSERT INTO Itinerario VALUES (default, 'voglia famoso', 'Settesoldi');
INSERT INTO legataa VALUES (1, 1);
INSERT INTO Tappe VALUES ('braccio secondo', '06:52:43');
INSERT INTO compostoda VALUES (1, 'braccio secondo');
INSERT INTO Account VALUES ('Domenica307', 'xforge', 'id tincidun.Donec fermentum porttitor urna nec ullamcorpe. Nunc blandit libero vitae sem cursus molesti. Quisque commodo non lacus at eleifen. Nunc iaculis lorem ligul  at fringilla nulla laoreet . In porta mi eu aliquet congu. Morbi volutpat quam lacu  quis luctus orci ', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 1146215520, 'RSSCRL94C07G224Y', 'Carlo', 'Rossetti', '2025-03-26', 'v07tr75yu82gj80d', '2018-09-16', 'i95se15mt65hi67p', 'Proin accumsan vitae arcu eu convalli. Quisque suscipit eros a augue rhoncus vestibulu. Mauris posuere risus a consequat gravid. Aenean ultricies metus quis lorem bibendu  sit amet ornare ante hendreri. In hac habitasse platea dictums. Suspendisse efficitur sollicitudin magn  at dictum velit efficitur eget.', 'Pellentesque nec lacinia orc. Donec consectetur nunc in odio laoreet fermentu. Morbi elementum in est sed luctu.Pellentesque ut justo non magna volutpat pulvina. Cras accumsan auctor ex id vehicul. Pellentesque vel aliquet magn. Sed non nunc odi. Mauris condimentu  nulla ac tincidunt ', 'via Moretti n.23', 'a30si59rr95jh99l');
INSERT INTO FormaggioProdotto VALUES (default, 2, 641, 62, 41, '2022-07-22', 'Bitto', 'Settesoldi');
INSERT INTO Recensione VALUES (default, 3, 5, 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'pulvinar eros et luctus sempe. Fusce vitae molestie nequ. Integer maximus purus quis venenatis tristiqu. Donec pulvinar augue vel lobortis tempo. Donec id erat at purus pharetra tristiqu. Proin lorem eni  venenatis sed est vita  finibus placerat mass. Morbi nulla urn  interdum ', 2, 'Domenica307', 'xforge', 1);
INSERT INTO Spedizione VALUES (default, '2019-10-06', '2019-09-03', 'eli. Mauris blandit orci at tincidunt vulputat. Integer felis urn  dignissim in augue ne  tempor vestibulum metu. Vivamus in consequat arc. Donec ac ligula ut erat tempus pellentesqu.Pellentesque volutpat leo sollicitudi  elementum sem a  dapibus eni. Integer varius molestie ultrices. ', 'spedita');
INSERT INTO OrdineProdotti VALUES (default, 'in processazione', '2019-09-16', 0, 'Domenica307', 'xforge', 1);
INSERT INTO contenutoordine VALUES (1, 1, 10, 0);
INSERT INTO CentridiSmistamento VALUES (default, 'sagittis ipsum ultricies u. Integer ultricies magna eget justo volutpat consequa.Phasellus vulputate ultricies matti. Nunc laoreet odio urn  ut posuere sem porttitor e. Integer et leo augu. Phasellus ut porta era. Etiam vel sem molesti  mollis felis a  molestie ero. ', 'strada Russo n.83', 9184236689);
INSERT INTO processatada VALUES (1, 1);
