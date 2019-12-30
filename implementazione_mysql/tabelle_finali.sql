/* Di ciascun attributo è necessario specificarne il tipo [varchar(n) | [tiny]int(m)..], il valore di default [default 0 | user | null...], e i vincoli [not null | unique]*/

DROP TABLE IF EXISTS Animale;
CREATE TABLE Animale
(
	codice	smallint unsigned not null unique auto_increment,
	sesso	enum('Maschio', 'Femmina') not null,
	specie	varchar(30),
	famiglia	varchar(30),
	idMadre	smallint unsigned,
	idPadre	smallint unsigned,
	dataDiNascita	date,
	altezza	tinyint unsigned, /*Si suppone che nessun animale superi i 255 cm in altezza*/
	peso	smallint unsigned, /*Si suppone che nessun animale superi le 65 tonnelate*/
	razza	varchar(30),
	latitudine	float,
	longitudine	float,
	orario	timestamp, 
	codiceGps	smallint unsigned not null unique,
	codLocale	smallint unsigned not null,
	primary key (codice),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS acquistoanimale;
CREATE TABLE acquistoanimale
(
	codiceAnimale	smallint unsigned not null unique,
	ragioneSocialeFornitore	varchar(40),
	dataAcquisto	date not null,
	dataArrivo	date,
	primary key (codiceAnimale),
	foreign key (codiceAnimale) references Animale(codice)
	/*TODO: ragioneSocialeFornitore non è foreign key?*/.
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Fornitore;
CREATE TABLE Fornitore
(
	ragioneSociale	varchar(40) not null unique,
	indirizzo	varchar(60),
	partitaIva	dec(11),
	primary key(ragioneSociale)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Riproduzione;
CREATE TABLE Riproduzione
(
	codiceRiproduzione	int unsigned not null unique auto_increment,
	complicanza	varchar(100),
	data_orario:	timestamp,
	stato	enum('successo', 'insuccesso'),
	codVeterinario	char(16),
	codiceMadre	int unsigned,
	codicePadre	int unsigned,
	primary key (codiceRiproduzione),
	foreign key (codVeterinario) references Veterinario(codiceFiscale), 
	foreign key (codiceMadre) references Animale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS SchedaGestazione;
CREATE TABLE SchedaGestazione
(
	codiceGestazione	int unsigned not null unique auto_increment,
	codRiproduzione	int unsigned not null unique,
	codVeterinario	int unsigned not null ,
	primary key (codiceGestazione),
	foreign key (codRiproduzione) references Riproduzione(codiceRiproduzione), 
	foreign key (codVeterinario) references Veterinario(codiceFiscale)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Agriturismo;
CREATE TABLE Agriturismo
(
	Nome	varchar(30) not null unique,
	primary key(Nome)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Stalla;
CREATE TABLE Stalla
(
	numProgressivo	tinyint unsigned not null,
	nomeAgriturismo	varchar(30) not null,
	primary key (numProgressivo, nomeAgriturismo),
	foreign key (nomeAgriturismo) references Agriturismo(nome)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Locale;
CREATE TABLE Locale
(
	codiceLocale	int unsigned not null unique auto_increment,
	temperatura	float,
	umidità	float,
	orientazioneFinestre	enum('N','NE', 'E', 'SE', 'S', 'SO', 'O', 'NO'),
	tollerabilitaAzoto	tinyint unsigned,
	tollerabilitaSporcizia	tinyint unsigned,
	tollerabilitaMetano	tinyint unsigned,
	nomeAgriturismo	varchar(30) not null,
	specieOspitata	varchar(30) check(specieOspitata in (select distinct(specie) from Animale)),
	altezza	smallint unsigned not null,
	lunghezza	smallint unsigned not null,
	larghezza	smallint unsigned not null,
	primary key (codiceLocale),
	foreign key (nomeAgriturismo) references Agriturismo(nome), 
	foreign key (specieOspitata, altezza, lunghezza, larghezza) references CaratteristichePerTipoLocale(specieOspitata, altezza, lunghezza, larghezza)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS CaratteristichePerTipoLocale;
CREATE TABLE CaratteristichePerTipoLocale
(
	specieOspitata	varchar(30) check(specieOspitata in (select distinct(specie) from Animale)),
	altezza	smallint unsigned not null,
	lunghezza	smallint unsigned not null,
	larghezza	smallint unsigned not null,
	capienzaMax	tinyint unsigned not null,
	pavimentazione	varchar(30),
	primary key (specieOspitata, altezza, lunghezza, larghezza)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Visivi;
CREATE TABLE Visivi
(
	codiceVisivo	int unsigned not null unique auto_increment,
	livelloSporcizia	float,
	orarioRilevazione	timestamp not null,
	codLocale	int unsigned not null,
	primary key (codiceVisivo),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Ambientali;
CREATE TABLE Ambientali
(
	codiceAmbientale	int unsigned not null unique auto_increment,
	temperatura	float,
	umidità	float,
	orarioRilevazione	timestamp not null,
	codLocale	int unsigned not null,
	primary key (codiceAmbientale),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS CompostiVolatili;
CREATE TABLE CompostiVolatili
(
	codiceVolatili	int unsigned not null unique auto_increment,
	concentrazioneMetano	float,
	concentrazioneAzoto	float,
	codLocale	int unsigned not null,
	primary key (codiceVolatili),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS PuliziaLocale;
CREATE TABLE PuliziaLocale
(
	codLocale	int unsigned not null,
	data_orarioRilevazione	timestamp,
	stato	enum('pendente', 'effettuato'),
	personale	int unsigned not null,
	primary key (codLocale, orarioRilevazione, dataRilevazione),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS PastoPerLocale;
CREATE TABLE PastoPerLocale
(
	giorno_orario	timestamp,
	codLocale	int unsigned not null,
	fibre	tintyint unsigned,
	proteine	tinyint unsigned,
	glucidi	tinyint,
	concentrazioneSali	tinyint unsigned,
	concentrazioneVitamine	tinyint unsigned,
	primary key (giorno, orario,  codLocale),
	foreign key (codLocale) references Locale(codice), 
	foreign key (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine) references Pasto(fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Pasto;
CREATE TABLE Pasto
(
	fibre	tinyint unsigned,
	proteine	tinyint unsigned,
	glucidi	tinyint unsigned,
	concentrazioneSali	tinyint unsigned,
	concentrazioneVitamine	tinyint unsigned,
	primary key (fibre, proteine, glucidi, concentrazioneSali, concentrazioneVitamine),
	foreign key (fibre, proteine, glucidi) references Foraggio(fibre, proteine, glucidi), 
	foreign key (concentrazioneSali, concentrazioneVitamine) references Acqua(concentrazioneSali, concentrazioneVitamine)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Foraggio;
CREATE TABLE Foraggio
(
	fibre	tinyint unsigned,
	proteine	tinyint unsigned,
	glucidi	tinyint insigned,
	cereali	tinyint unsigned,
	frutta	tinyint unsigned,
	piante	tinyint unsigned,
	forma	enum('insilato', 'fieno'),
	kcalkg	tinyint unsigned,
	primary key (fibre, proteine, glucidi)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Acqua;
CREATE TABLE Acqua
(
	concentrazioneSali	tinyint unsigned,
	concentrazioneVitamine	tinyint unsigned,
	primary key (concentrazioneSali, concentrazioneVitamine)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Mangiatoia;
CREATE TABLE Mangiatoia
(
	codice	int unsigned not null unique auto_increment,
	quantitàRestante	tinyint unsigned,
	codLocale	int unsigned,
	primary key (codice),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Abberveratoio;
CREATE TABLE Abberveratoio
(
	codice	int unsigned not null unique auto_increment,
	quantitàRestante tinyint unsigned,
	codLocale	int unsigned,
	primary key (codice),
	foreign key (codLocale) references Locale(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS AttivitàPascolo;
CREATE TABLE AttivitàPascolo
(
	codiceAttivita	int unsigned not null unique auto_increment,
	fasciaOraria	time,
	codLocale	int unsigned not null,
	codArea	tinyint unsigned,
	primary key (codiceAttivita),
	foreign key (codLocale) references Locale(codice), 
	foreign key (codArea) references Area(codiceArea)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS AreaPascolo;
CREATE TABLE AreaPascolo
(
	codiceArea	tinyint unsigned not null unique auto_increment,
	primary key(codiceArea)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS RecinzioneDivisoriaeZoneDiPascolo;
CREATE TABLE RecinzioneDivisoriaeZoneDiPascolo
(
	codiceZona	tinyint unsigned not null unique auto_increment,
	codArea	tinyint unsigned,
	longitudine	float,
	latitudine	float,
	primary key (codiceZona, codArea),
	foreign key (codArea) references Area(codiceArea)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Mungitura;
CREATE TABLE Mungitura
(
	codAnimale	int unsigned not null,
	codMungitrice	int unsigned not null,
	data_orario	timestamp not null,
	quantità	int unsigned,
	primary key (codAnimale, codMungitrice, data, ora),
	foreign key (codAnimale) references Animale(codice), 
	foreign key (codMungitrice) references Mungitrice(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Mungitrice;
CREATE TABLE Mungitrice
(
	codice	int unsigned not null unique auto_increment,
	longitudine	float,
	latitudine	float,
	marca	varchar(20),
	modello	varchar(50),
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS chemunge;
CREATE TABLE chemunge
(
	codLatte	int unsigned not null,
	codMungitrice	int unsigned not null,
	primary key (codLatte, codMungitrice),
	foreign key (codLatte) references Latte(codiceLatte), 
	foreign key (codMungitrice) references Mungitrice(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Latte;
CREATE TABLE Latte
(
	codiceLatte	int unsigned not null unique auto_increment,
	quantitàSostanzeDisciolte	tinyint unsigned not null,
	codAnimale	int unsigned not null,
	codSilos	int unsigned,
	primary key (codiceLatte),
	foreign key (codAnimale) references Animale(codice), 
	foreign key (codSilos) references Silos(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Silos;
CREATE TABLE Silos
(
	codice	tinyint unsigned not null unique ,
	capacità	smallint not null,
	livello	smallint not null,
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS prodottocon;
CREATE TABLE prodottocon
(
	codLatte	smallint unsigned not null,
	codLotto	smallint unsigned not null,
	primary key (codLatte, codLotto),
	foreign key (codLatte) references Latte(codiceLatte), 
	foreign key (codLotto) references Lotto(codiceLotto)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Lotto;
CREATE TABLE Lotto
(
	codiceLotto	smallint unsigned not null unique auto_increment,
	codDipendenti	 varchar(255),
	dataProd	date not null,
	codLab	tinyint unsigned not null,
	durata	time,
	primary key(codiceLotto)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS stoccaggiocantine;
CREATE TABLE stoccaggiocantine
(
	codLotto	smallint unsigned not null,
	codCantina	tinyint unsigned not null,
	primary key (codLotto, codCantina),
	foreign key (codLotto) references Lotto(codiceLotto), 
	foreign key (codCantina) references Cantina(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS stoccaggiomagazzini;
CREATE TABLE stoccaggiomagazzini
(
	codLotto	smallint unsigned not null,
	codMagazzino	tinyint unsigned not null,
	primary key (codLotto, codMagazzino),
	foreign key (codLotto) references Lotto(codiceLotto), 
	foreign key (codMagazzino) references Magazzino(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Cantine;
CREATE TABLE Cantine
(
	codice	tinyint unsigned not null unique auto_increment,
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Magazzini;
CREATE TABLE Magazzini
(
	codice	tinyint unsigned not null unique auto_increment,
	primary key(codice)	 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Scaffalature;
CREATE TABLE Scaffalature
(
	codCantina	tinyint unsigned not null unique,
	codice	smallint unsigned not null unique,
	primary key (codCantina, codice),
	foreign key (codCantina) references Cantine(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS Parametri;
CREATE TABLE Parametri
(
	data	date not null,
	idSensore	int unsigned not null,
	temperatura	float,
	umidità	float,
	codCantina	tinyint unsigned not null,
	primary key (data, idSensore),
	foreign key (codCantina) references Cantine(codice)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS  Scaffali ;
CREATE TABLE  Scaffali 
(
	codice	TINYINT(2) NOT NULL,
	codMagazzino TINYINT (3) NOT NULL,
	primary key (codice, codMagazzino),
	foreign key (codMagazzino) references Magazzini(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ControlloParametriFase ;
CREATE TABLE  ControlloParametriFase 
(
	parametriEffettivi	VARCHAR(200) UNIQUE,
	codLotto	INTEGER NOT NULL,
	codFase		INTEGER NOT NULL,
	primary key (parametriEffettivi, codLotto, codFase),
	foreign key (codFase) references Fasi(codiceFase),
	foreign key (codLotto) references Lotto(codiceLotto)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Fasi ;
CREATE TABLE  Fasi 
(
	codiceFase	INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
	nome	VARCHAR(30),
	parametriProcesso 	VARCHAR(200),
	durata	TIME NOT NULL,
	primary key(codiceFase)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  divisain ;
CREATE TABLE  divisain 
(
	codRicetta	INTEGER NOT NULL UNIQUE,
	codFase	INTEGER NOT NULL UNIQUE,
	primary key (codRicetta, codFase),
	foreign key (codRicetta) references Ricetta(codiceRicetta),
	foreign key (codFase) references Fasi(codiceFase)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Ricetta ;
CREATE TABLE  Ricetta 
(
	codiceRicetta	INTEGER NOT NULL UNIQUE AUTO_INCREMENT,
	collocazioneGeografica	VARCHAR(30),
	ricetta	VARCHAR(4096) NOT NULL,
	durataStagionatura	TIME,
	primary key(codiceRicetta)	 
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
	codAnimale	INT UNSIGNED NOT NULL,
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
	codAnimale	INT UNSIGNED NOT NULL,
	codVeterinario	CHAR(16) NOT NULL,
	primary key (codiceVisita),
	foreign key (codAnimale) references Animale(codice)
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
	codAnimale INT UNSIGNED NOT NULL	,
	codVeterinario	CHAR(16) NOT NULL,
	primary key (codiceEsame),
	foreign key (codAnimale) references Animale(codice)
	foreign key (codVeterinario) references Veterinario(codiceFiscale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Veterinario ;
CREATE TABLE  Veterinario 
(
	codiceFiscale	CHAR(16) NOT NULL UNIQUE,
	nome	VARCHAR(20),
	cognome	VARCHAR(20),
	contatto	VARCHAR(40),
	primary key(codiceFiscale)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Terapia ;
CREATE TABLE  Terapia 
(
	codiceTerapia	INTEGER UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT ,
	dataInizio	DATE,
	durata	TIME,
	secondaTerapiaConsecutiva	BOOLEAN,
	codAnimale	INT UNSIGNED NOT NULL,
	primary key (codiceTerapia),
	foreign key (codAnimale) references Animale(codice)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  compostada ;
CREATE TABLE  compostada 
(
	codTerapia	INTEGER UNSIGNED NOT NULL,
	nomeFarmaco	VARCHAR(30) NOT NULL,
	posologia	VARCHAR(500),
	primary key (codTerapia, nomeFarmaco),
	foreign key (codTerapia) references Terapia(codiceTerapia)
	foreign key (nomeFarmaco) references Farmaco(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Farmaco ;
CREATE TABLE  Farmaco 
(
	nome	VARCHAR(30) NOT NULL UNIQUE,
	principioAttivo	VARCHAR(50),
	dosaggio	SMALLINT UNSIGNED NOT NULL,
	primary key(nome)	 
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
	codAnimale	codAnimale	INT UNSIGNED NOT NULL,
	codVeterinario	CHAR(16) NOT NULL,
	primary key (codiceScheda),
	foreign key (codAnimale) references Animale(codice)
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

DROP TABLE IF EXISTS  PrenotazioneStanza ;
CREATE TABLE  PrenotazioneStanza 
(
	dataArrivo	DATE NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	codCliente	CHAR(16) NOT NULL,
	numStanza	TINYINT(5) NOT NULL,
	dataPartenza	DATE NOT NULL,
	/*CHECK(numStanza,nomeAgriturismo IN (SELECT numStanza,codAgriturismo FROM Stanza))*/
	primary key (dataArrivo, nomeAgriturismo, codCliente, numStanza),
	foreign key (nomeAgriturismo) references Agriturismo(Nome)
	foreign key (numStanza) references Stanza(numStanza)
	foreign key (codCliente) references Cliente(codCarta)
	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Stanza ;
CREATE TABLE  Stanza 
(
	numStanza	TINYINT(5) NOT NULL,
	codAgriturismo	VARCHAR(30) NOT NULL,
	costoGiornaliero	TINYINT UNSIGNED NOT NULL,
	suite	ENUM('singola','doppia','suite') NOT NULL,
	numLetti	TINYINT(2) UNSIGNED NOT NULL,
	tipoLetti	VARCHAR(100),
	primary key (numStanza, codAgriturismo),
	foreign key (codAgriturismo) references Agriturismo(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ServizioperStanza ;
CREATE TABLE  ServizioperStanza 
(
	dataInizioUtilizzo DATE NOT NULL,
	dataArrivo	DATE NOT NULL,
	codCliente	CHAR(16) NOT NULL,
	numStanza	TINYINT(5) UNSIGNED NOT NULL,
	nomeAgriturismo	VARCHAR(30) NOT NULL,
	codServizio	VARCHAR(20) NOT NULL,
	dataFineUtilizzo	DATE NOT NULL,
	primary key (dataInizioUtilizzo, dataArrivo, codCliente, numStanza, nomeAgriturismo, codServizio),
	foreign key (dataArrivo) references PrenotazioneStanza(dataArrivo),
	foreign key (codCliente) references PrenotazioneStanza(codCliente),
	foreign key (numStanza) references Stanza(numStanza),
	foreign key (nomeAgriturismo) references Agriturismo(nome),
    foreign key (codServizio) references ServizioAggiuntivo(tipoServizio)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  ServizioAggiuntivo ;
CREATE TABLE  ServizioAggiuntivo 
(
	tipoServizio	VARCHAR(20) NOT NULL UNIQUE,
	costo	TINYINT UNSIGNED NOT NULL,
	primary key(tipoServizio)	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  PrenotazioneEscursione ;
CREATE TABLE  PrenotazioneEscursione 
(
	dataPrenotazione	DATE NOT NULL ,
	codEscursione	,
	codCliente	CHAR(16) NOT NULL,
	primary key (dataPrenotazione, codEscursione, codCliente),
	foreign key (codEscursione) references Escursione(codice)
	foreign key (codCliente) references Cliente(codCarta)
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

DROP TABLE IF EXISTS  Guida ;
CREATE TABLE  Guida 
(
	codfisc	CHAR(16) NOT NULL UNIQUE,
	nome	VARCHAR(20) NOT NULL,
	cognome	VARCHAR(20) NOT NULL,
	contatto 	CHAR(11) NOT NULL UNIQUE,
	primary key(codfisc)	 
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

DROP TABLE IF EXISTS  Itinerario ;
CREATE TABLE  Itinerario 
(
	codice	SMALLINT NOT NULL UNIQUE AUTO_INCREMENT,
	numSentieri	VARCHAR(255),
	codAgriturismo VARCHAR(30) NOT NULL,
	primary key (codice),
	foreign key (codAgriturismo) references Agriturismo(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  compostoda ;
CREATE TABLE  compostoda 
( 
	codItinerario SMALLINT NOT NULL,
	nomeTappa VARCHAR(30) NOT NULL,
	primary key (codItinerario, nomeTappa),
	foreign key (codItinerario) references Itinerario(codice);
	foreign key (nomeTappa) references Tappe(nome)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Tappe ;
CREATE TABLE  Tappe 
(
	nome		VARCHAR(30) NOT NULL UNIQUE,
	tempoPermanenza	TIME,
	primary key(nome) 	 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS  Account ;
CREATE TABLE  Account 
(
	utente	VARCHAR(20) NOT NULL UNIQUE,
	password	VARCHAR(16)NOT NULL UNIQUE,
	domandaRec	VARCHAR(100),
	rispostaRec	VARCHAR(255),
	numTelefono	VARCHAR(10),
	codFiscale	CHAR(16),
	scadenzaDoc	DATE,
	numDoc	VARCHAR(15),
	dataIscrizione	DATE,
	codDoc	VARCHAR(15),
	cognome	VARCHAR(30),
	nome	VARCHAR(30),
	enteRilascio	VARCHAR(30),
	tipoDoc	VARCHAR(30),
	indirizzo	VARCHAR(50),
	codiceCarta	CHAR(16) NOT NULL,
	primary key (utente, password),
	foreign key (codiceCarta) references Cliente(codiceCarta)
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
	utente	NOT NULL,
	password	NOT NULL,
	codProdotto INT UNSIGNED NOT NULL,
	primary key (codiceRecensione),
	foreign key (utente) references Account(utente),
	foreign key (password) references Account(password),
	foreign key (codProdotto) references FormaggioProdotto(codiceProdotto)
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
	foreign key (nome) references Formaggio(nome)
	foreign key (nomeAgriturismo) references Formaggio(nomeAgriturismo)
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

DROP TABLE IF EXISTS  OrdineProdotti ;
CREATE TABLE  OrdineProdotti 
(
	codiceOrdine	SMALLINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	stato	ENUM('in processazione','in preparazione','spedito','evaso')
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

DROP TABLE IF EXISTS  processatada ;
CREATE TABLE  processatada 
(
	codSpedizione	SMALLINT UNSIGNED NOT NULL,
	codcentro	TINYINT UNSIGNED NOT NULL,
	primary key (codSpedizione, codcentro),
	foreign key (codSpedizione) references Spedizione(codice),
	foreign key (codcentro) references CentridiSmistamento(codice)
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
