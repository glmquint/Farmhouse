------------------------------------------------------------------------

![image](logo_titolo_unipi){height="35mm"}\
**Relazione per il Progetto di Base Dati 2019**\
*FarmHouse 4.0*\
[Guillaume Quint,\
Francesco Bonciani]{.smallcaps}

Università di Pisa, Ingegneria Informatica\
\

Glossario
=========

Sono qui descritte le varie entità e relazioni di ogni area, assieme ai
relativi attributi e collegamenti con le altre parti del database.

Questo glossario è stato realizzato prima della progettazione del
diagramma Entità-Relazioni: ogni modifica dovuta al processo di
ristrutturazione verrà indicata nella relativa sezione
[2](#sec:ristrutturazione){reference-type="ref"
reference="sec:ristrutturazione"} a pag. , oppure, nel caso di
ridondanze tra entità e relazioni, anche nel paragrafo
[3.2](#subsec:ridondanze-ent-rel){reference-type="ref"
reference="subsec:ridondanze-ent-rel"} a pag.

Area Allevamento
----------------

### Entità {#Allevamento Entita}

+---------+-------------+------------------------+-------------+
| **Nome  | **Descrizio | **Attributi**          | **Collegame |
| entità* | ne**        |                        | nti**       |
| *       |             |                        |             |
+:========+:============+:=======================+:============+
| Abbever | Dispositivo | -   acquaRestante      | Locale,     |
| atoio   | per la      |                        | Pasto per   |
|         | distribuzio |                        | Locale      |
|         | ne          |                        |             |
|         | dell'acqua  |                        |             |
|         | agli        |                        |             |
|         | animali nei |                        |             |
|         | locali      |                        |             |
+---------+-------------+------------------------+-------------+
| Acqua   | Acqua       | -   codiceAcqua        | Pasto       |
|         | eventualmen |                        |             |
|         | te          |                        |             |
|         | arricchita  |                        |             |
|         | per         |                        |             |
|         | l'idratazio |                        |             |
|         | ne          |                        |             |
|         | degli       |                        |             |
|         | animali     |                        |             |
+---------+-------------+------------------------+-------------+
| Agritur | Struttura   | -   nome               | Cliente,    |
| ismo    | attrezzata  |                        | Stanza,     |
|         | per         | -   indirizzo          | Stalla,     |
|         | l'allevamen |                        | Formaggio   |
|         | to          | -   indirizzo web      |             |
|         | degli       |                        |             |
|         | animali e   | -   contatto           |             |
|         | l'accoglien |                        |             |
|         | za          |                        |             |
|         | dei clienti |                        |             |
|         | conforme    |                        |             |
|         | agli        |                        |             |
|         | standard di |                        |             |
|         | *Industry   |                        |             |
|         | 4.0*        |                        |             |
+---------+-------------+------------------------+-------------+
| Allesti | Mangiatoie, | -   codice             | Locale      |
| mento   | Abbeveratoi |                        |             |
|         | ,           |                        |             |
|         | e           |                        |             |
|         | dispositivi |                        |             |
|         | di          |                        |             |
|         | illuminazio |                        |             |
|         | ne          |                        |             |
|         | e           |                        |             |
|         | condizionam |                        |             |
|         | ento        |                        |             |
|         | aria di     |                        |             |
|         | ogni locale |                        |             |
+---------+-------------+------------------------+-------------+
| Ambient | Sensore di  | -   temperatura        | Locale      |
| ali     | temperatura |                        |             |
|         | ed umidità  | -   umidità            |             |
|         | del locale  |                        |             |
+---------+-------------+------------------------+-------------+
| Animale | Anagrafica  | -   codice             | Mungitura,  |
|         | degli       |                        | Latte,      |
|         | animali di  | -   dataNascita        | Scheda      |
|         | *FarmHouse  |                        | Medica,     |
|         | 4.0*        | -   peso               | Animale     |
|         |             |                        | Acquisito,  |
|         |             | -   altezza            | Terapia,    |
|         |             |                        | GPS, Indici |
|         |             | -   razza              | Salute,     |
|         |             |                        | Riproduzion |
|         |             | -   sesso              | e,          |
|         |             |                        | Visita      |
|         |             | -   specie             |             |
|         |             |                        |             |
|         |             | -   famiglia           |             |
+---------+-------------+------------------------+-------------+
| Animale | Generalizza | -   codAcquisizione    | Animale,    |
| Acquisi | zione       |                        | Fornitore   |
| to      | di un       | -   dataAcquisto       |             |
|         | Animale non |                        |             |
|         | nato        | -   dataArrivo         |             |
|         | all'interno |                        |             |
|         | di un       |                        |             |
|         | agriturismo |                        |             |
|         | ,           |                        |             |
|         | bensì       |                        |             |
|         | acquisito   |                        |             |
|         | da un       |                        |             |
|         | fornitore   |                        |             |
|         | esterno     |                        |             |
+---------+-------------+------------------------+-------------+
| Area    | Spazio      | -   codiceArea         | Attività    |
| Pascolo | dell'agritu |                        | Pascolo,    |
|         | rismo       | -   estensione         | Recinzione  |
|         | destinato   |                        | Divisoria e |
|         | al pascolo  |                        | Zona        |
|         | degli       |                        | Pascolo     |
|         | animali     |                        |             |
+---------+-------------+------------------------+-------------+
| Arricch | Variante di | -   concentrazioneSali | Pasto       |
| ita     | Acqua       |                        |             |
|         | arricchita  | -   concentrazioneVita |             |
|         | di sali     | mine                   |             |
|         | minerali    |                        |             |
|         | e/o         |                        |             |
|         | vitamine    |                        |             |
+---------+-------------+------------------------+-------------+
| Attivit | Esercizio   | -   codAttività        | Locale,     |
| à       | di pascolo  |                        | Area        |
| Pascolo | che         | -   giorno             | Pascolo     |
|         | coinvolge   |                        |             |
|         | tutti gli   | -   orario             |             |
|         | animali di  |                        |             |
|         | un locale   |                        |             |
+---------+-------------+------------------------+-------------+
| Compost | Sensore     | -   concentrazioneMeta | Locale      |
| i       | della       | no                     |             |
| Volatil | concentrazi |                        |             |
| i       | one         | -   concentrazioneAzot |             |
|         | di azoto e  | o                      |             |
|         | metano nel  |                        |             |
|         | locale      |                        |             |
+---------+-------------+------------------------+-------------+
| Condizi | Dispositivo | -   codice             | Locale      |
| onatore | di          |                        |             |
| aria    | condizionam | -   consumo energetico |             |
|         | ento        |                        |             |
|         | dell'aria   |                        |             |
|         | all'interno |                        |             |
|         | dei locali  |                        |             |
+---------+-------------+------------------------+-------------+
| Foraggi | Alimentazio | -   fibre              | Pasto       |
| o       | ne          |                        |             |
|         | degli       | -   proteine           |             |
|         | animali     |                        |             |
|         | identificat | -   glucidi            |             |
|         | o           |                        |             |
|         | dai suoi    | -   cereali            |             |
|         | ingredienti |                        |             |
|         | vegetali    | -   frutta             |             |
|         |             |                        |             |
|         |             | -   piante             |             |
|         |             |                        |             |
|         |             | -   kcal/kg            |             |
|         |             |                        |             |
|         |             | -   forma              |             |
|         |             |     (fieno/insilato)   |             |
+---------+-------------+------------------------+-------------+
| Fornito | Fornitore   | -   ragioneSociale     | Animale     |
| re      | di capi di  |                        | Acquisito   |
|         | bestiame    | -   nome               |             |
|         | per la rete |                        |             |
|         | di          | -   indirizzo          |             |
|         | agriturismi |                        |             |
|         |             | -   partitaIVA         |             |
+---------+-------------+------------------------+-------------+
| GPS     | Dispositivo | -   codiceGPS          | Animale     |
|         | di          |                        |             |
|         | localizzazi | -   posizione          |             |
|         | one         |                        |             |
|         | per ogni    | -   orario             |             |
|         | animale     |                        |             |
+---------+-------------+------------------------+-------------+
| Illumin | Dispositivo | -   codice             | Locale      |
| azione  | di          |                        |             |
|         | illuminazio | -   consumo energetico |             |
|         | ne          |                        |             |
|         | artificiale |                        |             |
|         | dei locali  |                        |             |
+---------+-------------+------------------------+-------------+
| Insucce | Riproduzion | -   complicanza        | Animale,    |
| sso     | i           |                        | Veterinario |
|         | non andate  |                        |             |
|         | a buon fine |                        |             |
+---------+-------------+------------------------+-------------+
| Locale  | Divisione   | -   codice             | Stalla,     |
|         | della       |                        | Sensori,    |
|         | stalla per  | -   pavimentazione     | Pulizia     |
|         | specie      |                        | Locale,     |
|         | ospitata e  | -   capienzaMax        | Allestiment |
|         | tipo di     |                        | o,          |
|         | allestiment | -   specieOspitata     | Attività    |
|         | o           |                        | Pascolo,    |
|         |             | -   orientazioneFinest | Animale,    |
|         |             | re                     | Pasto per   |
|         |             |                        | Locale      |
|         |             | -   altezza            |             |
|         |             |                        |             |
|         |             | -   lunghezza          |             |
|         |             |                        |             |
|         |             | -   larghezza          |             |
|         |             |                        |             |
|         |             | -   temperatura        |             |
|         |             |                        |             |
|         |             | -   umidità            |             |
|         |             |                        |             |
|         |             | -   tollerabilitàSporc |             |
|         |             | izia                   |             |
|         |             |                        |             |
|         |             | -   tollerabilitàAzoto |             |
|         |             |                        |             |
|         |             | -   tollerabilitàMetan |             |
|         |             | o                      |             |
+---------+-------------+------------------------+-------------+
| Mangiat | Dispositivo | -   foraggioRestante   | Locale,     |
| oia     | per la      |                        | Pasto per   |
|         | distribuzio |                        | Locale      |
|         | ne          |                        |             |
|         | del         |                        |             |
|         | foraggio    |                        |             |
|         | agli        |                        |             |
|         | animali nei |                        |             |
|         | locali      |                        |             |
+---------+-------------+------------------------+-------------+
| Pasto   | Alimentazio | -   fibre              | Pasto per   |
|         | ne          |                        | Locale,     |
|         | somministra | -   proteine           | Acqua,      |
|         | ta          |                        | Foraggio    |
|         | automaticam | -   glucidi            |             |
|         | ente        |                        |             |
|         | nelle       | -   codAcqua           |             |
|         | mangiatoie  |                        |             |
|         | e negli     |                        |             |
|         | abbeveratoi |                        |             |
|         | di ogni     |                        |             |
|         | locale      |                        |             |
+---------+-------------+------------------------+-------------+
| Pasto   | Pasto       | -   giorno             | Locale,     |
| per     | specifico   |                        | Pasto       |
| Locale  | che viene   | -   orario             |             |
|         | somministra |                        |             |
|         | to          |                        |             |
|         | in un       |                        |             |
|         | locale in   |                        |             |
|         | una certa   |                        |             |
|         | data con un |                        |             |
|         | certo       |                        |             |
|         | orario      |                        |             |
+---------+-------------+------------------------+-------------+
| Pulizia | Richieste   | -   orarioRilevazione  | Locale      |
| Locale  | d'intervent |                        |             |
|         | o           | -   dataRilevazione    |             |
|         | di pulizia  |                        |             |
|         | di un       | -   stato              |             |
|         | locale      |                        |             |
|         |             | -   personale          |             |
|         |             |                        |             |
|         |             | -   concentrazioneMeta |             |
|         |             | no                     |             |
|         |             |                        |             |
|         |             | -   concentrazioneAzot |             |
|         |             | o                      |             |
|         |             |                        |             |
|         |             | -   livelloSporcizia   |             |
|         |             |                        |             |
|         |             | -   codLocale          |             |
+---------+-------------+------------------------+-------------+
| Recinzi | Ogni Area   | -   codiceZona         | Area        |
| one     | di pascolo  |                        | Pascolo     |
| Divisor | è divisa in | -   posizione          |             |
| ia      | zone        |                        |             |
| e Zona  | recintate   |                        |             |
| Pascolo | dinamicamen |                        |             |
|         | te          |                        |             |
+---------+-------------+------------------------+-------------+
| Riprodu | Storico dei | -   codiceRiproduzione | Animale,    |
| zione   | tentativi   |                        | Veterinario |
|         | di          | -   stato              |             |
|         | riproduzion |                        |             |
|         | e           | -   orario             |             |
|         | effettuati, |                        |             |
|         | sia         | -   data               |             |
|         | riusciti    |                        |             |
|         | che non     |                        |             |
+---------+-------------+------------------------+-------------+
| Scheda  | Descrive i  | -   codiceGestazione   | Riproduzion |
| Gestazi | diversi     |                        | e,          |
| one     | interventi  | -   interventiControll | Visita,     |
|         | di          | oProgrammati           | Veterinario |
|         | controllo   |                        |             |
|         | decisi dal  |                        |             |
|         | veterinario |                        |             |
|         | in fase di  |                        |             |
|         | gestazione  |                        |             |
+---------+-------------+------------------------+-------------+
| Sensori | Generalizza | -   codice             | Locale      |
|         | zione       |                        |             |
|         | dei sensori | -   orario             |             |
|         | visivi,     |                        |             |
|         | ambientali  | -   tipoSensore        |             |
|         | e dei       |                        |             |
|         | composti    |                        |             |
|         | volatili    |                        |             |
|         | del locale  |                        |             |
+---------+-------------+------------------------+-------------+
| Stalla  | Insieme di  | -   numProgressivo     | Agriturismo |
|         | locali      |                        | ,           |
|         | adibiti     | -   nomeAgriturismo    | Locale      |
|         | all'alloggi |                        |             |
|         | o           |                        |             |
|         | e alla      |                        |             |
|         | nutrizione  |                        |             |
|         | degli       |                        |             |
|         | animali     |                        |             |
+---------+-------------+------------------------+-------------+
| Success | Riproduzion | -   codiceNeonato      | Animale,    |
| o       | i           |                        | Veterinario |
|         | andate a    | -   esitoVisitaControl | ,           |
|         | buon fine   | lo                     | Scheda      |
|         |             |                        | Gestazione  |
+---------+-------------+------------------------+-------------+
| Visivi  | Sensore     | -   livelloSporcizia   | Locale      |
|         | visivo del  |                        |             |
|         | livello di  |                        |             |
|         | sporcizia   |                        |             |
|         | del locale  |                        |             |
+---------+-------------+------------------------+-------------+

### Relazioni {#Allevamento Relazioni}

+----------+----------------+-----------------------------------+
| **Nome   | **Attributi**  | **Cardinalità**                   |
|     rela |                |                                   |
| zione**  |                |                                   |
+:=========+:===============+:==================================+
| abita    |                | -   (1,1) con Animale: ogni       |
|          |                |     animale abita un solo locale  |
|          |                |     dell'agriturismo              |
|          |                |                                   |
|          |                | -   (1,N) con Locale: ogni locale |
|          |                |     può ospitare diversi animali  |
+----------+----------------+-----------------------------------+
| acqua    |                | -   (1,N) con Abbeveratoio: un    |
| contenut |                |     abbeveratoio può essere       |
| a        |                |     impiegato per più pasti       |
|          |                |                                   |
|          |                | -   (1,N) con Pasto per Locale:   |
|          |                |     uno specifico pasto può       |
|          |                |     essere distribuito su più     |
|          |                |     abbeveratoi dello stesso      |
|          |                |     locale                        |
+----------+----------------+-----------------------------------+
| acquisto |                | -   (1,1) con Animale Acquisito:  |
| animale  |                |     un animale, se acquistato,    |
|          |                |     può provenire da un solo      |
|          |                |     fornitore                     |
|          |                |                                   |
|          |                | -   (1,N) con Fornitore: un       |
|          |                |     fornitore può vendere più di  |
|          |                |     un animale                    |
+----------+----------------+-----------------------------------+
| attività |                | -   (1,N) con Locale: gli animali |
| locale   |                |     di un locale possono          |
|          |                |     effettuare più attività di    |
|          |                |     pascolo                       |
|          |                |                                   |
|          |                | -   (1,1) con Attività pascolo:   |
|          |                |     ogni attività di pascolo      |
|          |                |     coinvolge tutti gli animali   |
|          |                |     di un solo locale             |
+----------+----------------+-----------------------------------+
| coinvolg | codicePadre    | -   (0,N) con Animale: ogni       |
| e        |                |     coppia di animale può         |
|          |                |     intraprendere o no più di una |
|          |                |     riproduzione                  |
|          |                |                                   |
|          |                | -   (1,1) con Riproduzione: ogni  |
|          |                |     riproduzione richiede un      |
|          |                |     animale madre e un animale    |
|          |                |     padre                         |
+----------+----------------+-----------------------------------+
| collocaz |                | -   (1,1) con Attività pascolo:   |
| ione     |                |     ogni attività di pascolo      |
| attività |                |     viene svolta in una sola area |
|          |                |     dedicata                      |
|          |                |                                   |
|          |                | -   (1,N) con Area pascolo: ogni  |
|          |                |     area di pascolo di un         |
|          |                |     agriturismo può essere        |
|          |                |     impiegata per più attività di |
|          |                |     pascolo                       |
+----------+----------------+-----------------------------------+
| composiz |                | -   (1,1) con Pasto: ad un pasto  |
| ione     |                |     è associato un solo tipo di   |
| acqua    |                |     acqua                         |
|          |                |                                   |
|          |                | -   (1,N) con Acqua: un tipo di   |
|          |                |     acqua può andare a comporre   |
|          |                |     più pasti                     |
+----------+----------------+-----------------------------------+
| composiz |                | -   (1,1) con Pasto: ad un pasto  |
| ione     |                |     è associato un solo tipo di   |
| foraggio |                |     foraggio                      |
|          |                |                                   |
|          |                | -   (1,N) con Foraggio: un tipo   |
|          |                |     di foraggio può andare a      |
|          |                |     comporre più pasti            |
+----------+----------------+-----------------------------------+
| determin |                | -   (1,1) con Scheda gestazione:  |
| a        |                |     ogni scheda di gestazione è   |
|          |                |     associata ad una sola         |
|          |                |     gravidanza che ha successo    |
|          |                |                                   |
|          |                | -   (1,1) con Successo: per ogni  |
|          |                |     gravidanza che ha successo si |
|          |                |     compila una sola scheda di    |
|          |                |     gestazione                    |
+----------+----------------+-----------------------------------+
| division |                | -   (1,N) con Locale: Ogni locale |
| e        |                |     è dotato di uno o più         |
| allestim |                |     allestimenti                  |
| anti     |                |                                   |
|          |                | -   (1,1) con Allestimento: un    |
|          |                |     allestimento è associato ad   |
|          |                |     un solo locale                |
+----------+----------------+-----------------------------------+
| division |                | -   (1,N) con Locale: Ogni locale |
| e  condi |                |     è dotato di uno o più         |
| zionator |                |     condizionatori                |
| i        |                |                                   |
|          |                | -   (1,1) con Condizionatore      |
|          |                |     aria: un condizionatore è     |
|          |                |     associato ad un solo locale   |
+----------+----------------+-----------------------------------+
| division |                | -   (1,N) con Locale: Ogni locale |
| e    ill |                |     è dotato di uno o più         |
| uminazio |                |     dispositivi di illuminazione  |
| ne       |                |                                   |
|          |                | -   (1,1) con Illuminazione: un   |
|          |                |     dispositivo di illuminazione  |
|          |                |     è associato ad un solo locale |
+----------+----------------+-----------------------------------+
| division |                | -   (1,N) con Stalla: ogni stalla |
| e        |                |     è divisa in più locali        |
| locali   |                |                                   |
|          |                | -   (1,1) con Locale: un Locale   |
|          |                |     appartiene ad una sola stalla |
+----------+----------------+-----------------------------------+
| division |                | -   (1,N) con Area pascolo: ogni  |
| e        |                |     area di pascolo è divisa in   |
| pascolo  |                |     più zone recintate            |
|          |                |                                   |
|          |                | -   (1,1) con Recinzione          |
|          |                |     divisoria e zona di pascolo:  |
|          |                |     ogni zona recintata           |
|          |                |     appartiene ad una sola area   |
|          |                |     di pascolo                    |
+----------+----------------+-----------------------------------+
| division |                | -   (1,N) con Agriturismo: un     |
| e        |                |     agriturismo è diviso in più   |
| stalle   |                |     stalle                        |
|          |                |                                   |
|          |                | -   (1,1) con Stalle: ogni stalla |
|          |                |     appartiene ad un solo         |
|          |                |     Agriturismo                   |
+----------+----------------+-----------------------------------+
| foraggio |                | -   (1,N) con Mangiatoia: una     |
| contenut |                |     mangiatoia può essere         |
| o        |                |     impiegata per più pasti       |
|          |                |                                   |
|          |                | -   (1,N) con Pasto per Locale:   |
|          |                |     uno specifico pasto può       |
|          |                |     essere distribuito su più     |
|          |                |     mangiatoie dello stesso       |
|          |                |     locale                        |
+----------+----------------+-----------------------------------+
| locale   |                | -   (1,N) con Locale: un locale   |
| assegnat |                |     può contenere più pasti       |
| o        |                |                                   |
|          |                | -   (1,1) con Pasto per Locale:   |
|          |                |     uno specifico pasto deve      |
|          |                |     essere distribuito su un solo |
|          |                |     locale                        |
+----------+----------------+-----------------------------------+
| localizz |                | -   (1,1) con Animale: ogni GPS   |
| ato      |                |     localizza un solo animale     |
|          |                |                                   |
|          |                | -   (1,1) con GPS: ogni animale   |
|          |                |     viene localizzato da un solo  |
|          |                |     GPS                           |
+----------+----------------+-----------------------------------+
| madre    |                | -   (0,N) con Animale: ogni       |
|          |                |     animale può o no essere madre |
|          |                |     di più figli                  |
|          |                |                                   |
|          |                | -   (0,1) con Animale: ogni       |
|          |                |     animale è figlio di al        |
|          |                |     massimo una madre: se è stato |
|          |                |     acquisito, la madre può non   |
|          |                |     essere registrata             |
+----------+----------------+-----------------------------------+
| padre    |                | -   (0,N) con Animale: ogni       |
|          |                |     animale può o no essere padre |
|          |                |     di più figli                  |
|          |                |                                   |
|          |                | -   (0,1) con Animale: ogni       |
|          |                |     animale è figlio di al        |
|          |                |     massimo un padre: se è stato  |
|          |                |     acquisito, il padre può non   |
|          |                |     essere registrato             |
+----------+----------------+-----------------------------------+
| pasto    |                | -   (1,N) con Pasto: un Pasto può |
| assegnat |                |     essere somministrato allo     |
| o        |                |     stesso locale in giorni       |
|          |                |     differenti                    |
|          |                |                                   |
|          |                | -   (1,1) con Pasto per Locale:   |
|          |                |     per ogni locale, ogni giorno  |
|          |                |     viene assegnato uno specifico |
|          |                |     pasto                         |
+----------+----------------+-----------------------------------+
| richiest |                | -   (0,N) con Locale: alcuni      |
| a        |                |     locali possono richiedere più |
| interven |                |     interventi di pulizia         |
| to       |                |                                   |
|          |                | -   (1,1) con Pulizia locale:     |
|          |                |     ogni intervento di pulizia si |
|          |                |     riferisce ad un solo locale   |
|          |                |     dell'agriturismo              |
+----------+----------------+-----------------------------------+
| rilievo  |                | -   (1,N) con Locale: ogni locale |
| parametr |                |     è dotato di uno o più sensori |
| i        |                |                                   |
| locale   |                | -   (1,1) con Sensori: ogni       |
|          |                |     sensore monitora un solo      |
|          |                |     locale                        |
+----------+----------------+-----------------------------------+
| scrive   |                | -   (0,N) con Veterinario: alcuni |
|          |                |     veterinari possono compilare  |
|          |                |     più schede di gestazione      |
|          |                |                                   |
|          |                | -   (1,1) con Scheda gestazione:  |
|          |                |     ogni scheda viene compilata   |
|          |                |     da un solo veterinario        |
+----------+----------------+-----------------------------------+
| supervis |                | -   (0,N) con Veterinario: alcuni |
| iona     |                |     veterinari possono            |
|          |                |     supervisionare più gestazioni |
|          |                |                                   |
|          |                | -   (1,1) con Riproduzione: ogni  |
|          |                |     riproduzione ha un solo       |
|          |                |     veterinario supervisore       |
+----------+----------------+-----------------------------------+

Area Healthcare
---------------

### Entità {#Healthcare Entita}

+---------+-------------+------------------------+-------------+
| **Nome  | **Descrizio | **Attributi**          | **Collegame |
| entità* | ne**        |                        | nti**       |
| *       |             |                        |             |
+:========+:============+:=======================+:============+
| Disturb | Informazion | -   nome               | Animale,    |
| i       | i           |                        | Veterinario |
| Comport | su          | -   entità             |             |
| amental | abitudini   |                        |             |
| i       | fuori dal   |                        |             |
|         | comune di   |                        |             |
|         | un animale  |                        |             |
+---------+-------------+------------------------+-------------+
| Esame   | Esame       | -   codiceEsame        | Veterinario |
|         | medico      |                        | ,           |
|         | prescritto  | -   nome               | Animale     |
|         | da un       |                        |             |
|         | veterinario | -   descrizione        |             |
|         | effettuato  |                        |             |
|         | con un      | -   macchinario        |             |
|         | determinato |                        |             |
|         | macchinario | -   data               |             |
+---------+-------------+------------------------+-------------+
| Farmaco | Medicinale  | -   nome               | Terapia     |
|         | prescritto  |                        |             |
|         | da un       | -   dosaggio           |             |
|         | veterinario |                        |             |
|         | da assumere | -   principioAttivo    |             |
|         | durante una |                        |             |
|         | terapia     |                        |             |
+---------+-------------+------------------------+-------------+
| Indici  | Informazion | -   dataRilevazione    | Animale     |
| Salute  | i           |                        |             |
|         | relative    | -   lucentezzaPelo     |             |
|         | alle        |                        |             |
|         | condizioni  | -   vigilanza          |             |
|         | di salute   |                        |             |
|         | di un       | -   idratazione        |             |
|         | animale     |                        |             |
|         |             | -   deambulazione      |             |
|         |             |                        |             |
|         |             | -   tipologiaRespirazi |             |
|         |             | one                    |             |
+---------+-------------+------------------------+-------------+
| Lesioni | Ferite      | -   tipologia          | Animale,    |
|         | riportate   |                        | Veterinario |
|         | da un       | -   parteDelCorpo      |             |
|         | animale     |                        |             |
|         |             | -   entità             |             |
+---------+-------------+------------------------+-------------+
| Scheda  | Documento   | -   codiceScheda       | Animale,    |
| Medica  | contenente  |                        | Veterinario |
|         | tutte le    | -   massaMagra         |             |
|         | informazion |                        |             |
|         | i           | -   massaGrassa        |             |
|         | relative ad |                        |             |
|         | una visita  | -   rispostaOculare    |             |
|         | effettuata  |                        |             |
|         | da un       | -   emocromo           |             |
|         | veterinario |                        |             |
|         | su un       | -   spessoreZoccolo    |             |
|         | animale     |                        |             |
|         |             | -   fegato             |             |
|         |             |                        |             |
|         |             | -   cuore              |             |
|         |             |                        |             |
|         |             | -   pancreas           |             |
|         |             |                        |             |
|         |             | -   data               |             |
|         |             |                        |             |
|         |             | -   patologie          |             |
|         |             |                        |             |
|         |             | -   carenze            |             |
+---------+-------------+------------------------+-------------+
| Terapia | Trattamento | -   codiceTerapia      | Veterinario |
|         | prescritto  |                        | ,           |
|         | da un       | -   dataInizio         | Farmaco     |
|         | veterinario |                        |             |
|         | conseguente | -   durata             |             |
|         | mente       |                        |             |
|         | alla        | -   secondaTerapiaCons |             |
|         | rilevazione | ecutiva                |             |
|         | di malattie |                        |             |
|         | in un       | -   codAnimale         |             |
|         | animale     |                        |             |
+---------+-------------+------------------------+-------------+
| Veterin | Medico      | -   codiceFiscale      | Scheda      |
| ario    | specializza |                        | Medica,     |
|         | to          | -   nome               | Terapia,    |
|         | per la      |                        | Esame,      |
|         | visita      | -   cognome            | Riproduzion |
|         | degli       |                        | e,          |
|         | animali     | -   contatto           | Visita      |
+---------+-------------+------------------------+-------------+
| Visita  | Visita di   | -   codiceVisita       | Veterinario |
|         | controllo   |                        | ,           |
|         | effettuata  | -   esito              | Scheda      |
|         | per         |                        | gestazione  |
|         | rilevare    | -   dataProgrammata    |             |
|         | valori      |                        |             |
|         | anomali     | -   dataEffettiva      |             |
|         | negli       |                        |             |
|         | indici di   | -   stato              |             |
|         | salute di   |                        |             |
|         | un animale  |                        |             |
+---------+-------------+------------------------+-------------+

### Relazioni {#Healthcare Relazioni}

+----------+----------------+-----------------------------------+
| **Nome   | **Attributi**  | **Cardinalità**                   |
|     rela |                |                                   |
| zione**  |                |                                   |
+:=========+:===============+:==================================+
| compila  |                | -   (1,1) con Scheda medica: ogni |
|          |                |     scheda è compilata da un solo |
|          |                |     veterinario                   |
|          |                |                                   |
|          |                | -   (0,N) con Veterinario: alcuni |
|          |                |     veterinari possono compilare  |
|          |                |     più di una scheda medica      |
+----------+----------------+-----------------------------------+
| composta | posologia      | -   (1,N) con Terapia: ogni       |
| da       |                |     terapia è composta da almeno  |
|          |                |     un farmaco                    |
|          |                |                                   |
|          |                | -   (1,N) con Farmaco: ogni       |
|          |                |     farmaco è impiegato in almeno |
|          |                |     una terapia, altrimenti non è |
|          |                |     memorizzato nel database      |
+----------+----------------+-----------------------------------+
| esegue   |                | -   (0,N) con Veterinario: alcuni |
|          |                |     veterinari possono eseguire   |
|          |                |     più visite di controllo       |
|          |                |                                   |
|          |                | -   (1,1) con Visita: ogni visita |
|          |                |     è effettuata da un solo       |
|          |                |     veterinario                   |
+----------+----------------+-----------------------------------+
| possiede |                | -   (0,N) con Animale: alcuni     |
|          |                |     animali possono avere più di  |
|          |                |     una scheda                    |
|          |                |                                   |
|          |                | -   (1,1) con Scheda medica: ogni |
|          |                |     scheda è assocata ad un solo  |
|          |                |     animale                       |
+----------+----------------+-----------------------------------+
| possiede |                | -   (1,N) con Animale: ogni       |
| esame    |                |     animale possiede almeno un    |
|          |                |     esame diagnostico, sia che    |
|          |                |     sia nato nell'agriturismo,    |
|          |                |     sia che sia stato acquisito   |
|          |                |                                   |
|          |                | -   (1,1) con Esame: ogni esame   |
|          |                |     veterinario si riferisce ad   |
|          |                |     un solo animale               |
+----------+----------------+-----------------------------------+
| possiede |                | -   (0,N) con Animale: alcuni     |
| terapia  |                |     animali possono possedere più |
|          |                |     terapie                       |
|          |                |                                   |
|          |                | -   (1,1) con Terapia: ogni       |
|          |                |     terapia è associata ad un     |
|          |                |     solo animale                  |
+----------+----------------+-----------------------------------+
| possiede |                | -   (1,N) con Animale: ogni       |
| visita   |                |     animale può possedere più     |
|          |                |     visite                        |
|          |                |                                   |
|          |                | -   (1,1) con Visita: ogni visita |
|          |                |     è associata ad un solo        |
|          |                |     animale                       |
+----------+----------------+-----------------------------------+
| prescriv |                | -   (0,N) con Veterinario: alcuni |
| e        |                |     veterinari possono            |
| esame    |                |     prescrivere più di un esame   |
|          |                |                                   |
|          |                | -   (1,1) con Esame: ogni esame è |
|          |                |     prescritto da un solo         |
|          |                |     veterinario                   |
+----------+----------------+-----------------------------------+
| prescriv |                | -   (0,N) con Veterinario: alcuni |
| e        |                |     veterinari possono            |
| terapia  |                |     prescrivere più di un terapia |
|          |                |                                   |
|          |                | -   (1,1) con Terapia: ogni       |
|          |                |     terapia è prescritta da un    |
|          |                |     solo veterinario              |
+----------+----------------+-----------------------------------+
| stato    |                | -   (1,N) con Animale: ogni       |
| salute   |                |     animale può avere più indici  |
|          |                |     di salute in diverse date     |
|          |                |                                   |
|          |                | -   (1,1) con Indici salute: ogni |
|          |                |     set di indici di salute si    |
|          |                |     riferisce ad un solo animale  |
+----------+----------------+-----------------------------------+

Area Produzione
---------------

### Entità {#Produzione Entita}

+---------+-------------+------------------------+-------------+
| **Nome  | **Descrizio | **Attributi**          | **Collegame |
| entità* | ne**        |                        | nti**       |
| *       |             |                        |             |
+:========+:============+:=======================+:============+
| Cantine | Spazio      | -   codice             | Lotto,      |
|         | dell'agritu |                        | Scaffalatur |
|         | rismo       |                        | e,          |
|         | dedicato    |                        | Parametri   |
|         | alla        |                        |             |
|         | stagionatur |                        |             |
|         | a           |                        |             |
|         | dei         |                        |             |
|         | formaggi    |                        |             |
|         | prodotti da |                        |             |
|         | un lotto    |                        |             |
+---------+-------------+------------------------+-------------+
| Control | Controlla,  | -   durataFaseEffettiv | Ricetta,    |
| lo      | per ogni    | a                      | Lotto       |
| Paramet | lotto, i    |                        |             |
| ri      | parametri   | -   temperaturaLatteEf |             |
| Fase    | effettivi   | fettiva                |             |
|         | relativi ad |                        |             |
|         | ogni        | -   tempoRiposoEffetti |             |
|         | singola     | vo                     |             |
|         | fase di     |                        |             |
|         | produzione  | -   codiceLotto        |             |
|         | del         |                        |             |
|         | formaggio   | -   codiceFase         |             |
+---------+-------------+------------------------+-------------+
| Fasi    | Singola     | -   codiceFase         | Ricetta,    |
|         | istruzione  |                        | Lotto       |
|         | con         | -   nome               |             |
|         | informazion |                        |             |
|         | i           | -   durata             |             |
|         | da seguire  |                        |             |
|         | per la      | -   durataFaseIdeale   |             |
|         | produzione  |                        |             |
|         | ottimale    | -   temperaturaLatteId |             |
|         | del         | eale                   |             |
|         | formaggio   |                        |             |
|         | da produrre | -   tempoRiposoIdeale  |             |
+---------+-------------+------------------------+-------------+
| Formagg | Nutrimento  | -   nome               | Formaggio   |
| io      | somministra |                        | Prodotto,   |
|         | to          | -   deperibilità       | Agriturismo |
|         | agli        |                        | ,           |
|         | animali     | -   nomeAgriturismo    | Latte,      |
|         | sotto forma |                        | Ricetta     |
|         | di fieno o  | -   codLatte           |             |
|         | insilato    |                        |             |
|         |             | -   codRicetta         |             |
+---------+-------------+------------------------+-------------+
| Latte   | Composto    | -   codLatte           | Mungitrice, |
|         | fondamental |                        | Lotto,      |
|         | e           | -   quantitàSostanzeDi | Silos,      |
|         | per i       | sciolte                | Formaggio   |
|         | prodotti    |                        |             |
|         | lattiero    |                        |             |
|         | caseari di  |                        |             |
|         | ogni        |                        |             |
|         | agriturismo |                        |             |
|         | ,           |                        |             |
|         | ottenuto    |                        |             |
|         | durante le  |                        |             |
|         | varie       |                        |             |
|         | mungiture   |                        |             |
|         | in vari     |                        |             |
|         | momenti     |                        |             |
|         | della       |                        |             |
|         | giornata    |                        |             |
+---------+-------------+------------------------+-------------+
| Lotto   | Laboratorio | -   codLotto           | Formaggio   |
|         | di un       |                        | Prodotto,   |
|         | agriturismo | -   codDipendenti      | Fasi,       |
|         | che produce |                        | Magazzini,  |
|         | formaggi    | -   dataProd           | Cantine,    |
|         | con la      |                        | Latte       |
|         | stessa (o   | -   codLab             |             |
|         | simile)     |                        |             |
|         | composizion | -   durata             |             |
|         | e           |                        |             |
|         | chimico-fis |                        |             |
|         | ica         |                        |             |
+---------+-------------+------------------------+-------------+
| Magazzi | Spazio      | -   codice             | Lotto,      |
| ni      | dell'agritu |                        | Scaffali    |
|         | rismo       |                        |             |
|         | dedicato    |                        |             |
|         | allo        |                        |             |
|         | stoccaggio  |                        |             |
|         | dei         |                        |             |
|         | formaggi    |                        |             |
|         | che non     |                        |             |
|         | necessitano |                        |             |
|         | di          |                        |             |
|         | stagionatur |                        |             |
|         | a           |                        |             |
+---------+-------------+------------------------+-------------+
| Mungitr | Macchinario | -   codice             | Mungitura,  |
| ice     | *hi-tech*   |                        | Latte       |
|         | impiegato   | -   marca              |             |
|         | durante le  |                        |             |
|         | mungiture,  | -   modello            |             |
|         | capace di   |                        |             |
|         | rilevare    | -   posizione          |             |
|         | l'animale a |                        |             |
|         | cui è       |                        |             |
|         | associato   |                        |             |
|         | oltre che   |                        |             |
|         | la quantità |                        |             |
|         | e la        |                        |             |
|         | composizion |                        |             |
|         | e           |                        |             |
|         | del latte   |                        |             |
|         | munto       |                        |             |
+---------+-------------+------------------------+-------------+
| Mungitu | Attività di | -   data               | Animale,    |
| ra      | mungitura   |                        | Mungitrice  |
|         | quotidiana  | -   ora                |             |
|         | degli       |                        |             |
|         | animali     | -   quantità           |             |
|         | dopo il     |                        |             |
|         | pascolo     | -   codAnimale         |             |
|         |             |                        |             |
|         |             | -   codMungitrice      |             |
+---------+-------------+------------------------+-------------+
| Paramet | Parametri   | -   idSensore          | Cantine     |
| ri      | ambientali  |                        |             |
|         | rilevati    | -   data               |             |
|         | nelle       |                        |             |
|         | cantine per | -   temperatura        |             |
|         | garantire   |                        |             |
|         | una         | -   umidità            |             |
|         | stagionatur |                        |             |
|         | a           |                        |             |
|         | ottimale    |                        |             |
|         | del         |                        |             |
|         | prodotto    |                        |             |
+---------+-------------+------------------------+-------------+
| Ricetta | Insieme di  | -   codiceRicetta      | Formaggio,  |
|         | fasi da     |                        | Fasi        |
|         | seguire per | -   collocazioneGeogra |             |
|         | la          | fica                   |             |
|         | produzione  |                        |             |
|         | di uno      | -   durataStagionatura |             |
|         | specifico   |                        |             |
|         | tipo di     | -   ricetta            |             |
|         | formaggio   |                        |             |
+---------+-------------+------------------------+-------------+
| Scaffal | Ripiani di  | -   codice             | Cantine     |
| ature   | un          |                        |             |
|         | magazzino   | -   codCantina         |             |
|         | su cui sono |                        |             |
|         | fisicamente |                        |             |
|         | tenuti i    |                        |             |
|         | prodotti    |                        |             |
+---------+-------------+------------------------+-------------+
| Scaffal | Ripiani di  | -   codice             | Magazzini   |
| i       | una cantina |                        |             |
|         | su cui sono | -   codMagazzino       |             |
|         | fisicamente |                        |             |
|         | tenuti i    |                        |             |
|         | formaggi    |                        |             |
|         | durante la  |                        |             |
|         | stagionatur |                        |             |
|         | a           |                        |             |
+---------+-------------+------------------------+-------------+
| Silos   | Profondi    | -   codice             | Latte       |
|         | recipienti  |                        |             |
|         | destinati   | -   capacità           |             |
|         | alla        |                        |             |
|         | raccolta di | -   livello            |             |
|         | latte con   |                        |             |
|         | composizion |                        |             |
|         | e           |                        |             |
|         | chimico-fis |                        |             |
|         | ica         |                        |             |
|         | simile      |                        |             |
+---------+-------------+------------------------+-------------+

### Relazioni {#Produzione Relazioni}

+----------+----------------+-----------------------------------+
| **Nome   | **Attributi**  | **Cardinalità**                   |
|     rela |                |                                   |
| zione**  |                |                                   |
+:=========+:===============+:==================================+
| apparten |                | -   (1,1) con Formaggio prodotto: |
| ente     |                |     ogni formaggio viene prodotto |
| a        |                |     da uno specifico lotto        |
|          |                |     dell'agriturismo              |
|          |                |                                   |
|          |                | -   (1,N) con Lotto: uno stesso   |
|          |                |     lotto è adibito alla          |
|          |                |     produzione di diversi         |
|          |                |     formaggi                      |
+----------+----------------+-----------------------------------+
| che      |                | -   (1,N) con Mungitrice: ogni    |
| munge    |                |     mungitrice può mungere        |
|          |                |     diverse quantità di latte     |
|          |                |                                   |
|          |                | -   (1,N) con Latte: ogni         |
|          |                |     quantità di latte può         |
|          |                |     provenire da diverse          |
|          |                |     mungitrici                    |
+----------+----------------+-----------------------------------+
| con      |                | -   (1,1) con Mungitura: ogni     |
|          |                |     mungitura viene effettuata    |
|          |                |     con una sola mungitrice       |
|          |                |                                   |
|          |                | -   (1,N) con Mungitrice: ogni    |
|          |                |     mungitrice può essere         |
|          |                |     impiegata per diverse         |
|          |                |     mungiture                     |
+----------+----------------+-----------------------------------+
| contengo |                | -   (1,N) con Cantine: ogni       |
| no       |                |     cantina è suddivisa in più    |
| scaffala |                |     scaffalature                  |
| ture     |                |                                   |
|          |                | -   (1,1) con Scaffalature: ogni  |
|          |                |     scaffalatura può appartenere  |
|          |                |     ad una sola cantina           |
+----------+----------------+-----------------------------------+
| contengo |                | -   (1,N) con Magazzini: ogni     |
| no       |                |     magazzino è suddiviso in più  |
| scaffali |                |     scaffali                      |
|          |                |                                   |
|          |                | -   (1,1) con Scaffali: ogni      |
|          |                |     scaffale può appartenere ad   |
|          |                |     un solo magazzino             |
+----------+----------------+-----------------------------------+
| controll |                | -   (1,1) con Controllo Parametri |
| o        |                |     Fase: i parametri rilevati si |
| fasi     |                |     riferiscono ad una fase       |
|          |                |     specifica                     |
|          |                |                                   |
|          |                | -   (1,N) con Fasi: la stessa     |
|          |                |     fase può essere controllata   |
|          |                |     più volte                     |
+----------+----------------+-----------------------------------+
| controll |                | -   (1,1) con Controllo Parametri |
| o        |                |     Fase: ogni controllo possiede |
| lotti    |                |     un set di parametri effettivi |
|          |                |     rilevati                      |
|          |                |                                   |
|          |                | -   (1,N) con Lotto: il controllo |
|          |                |     sulla stessa fase può essere  |
|          |                |     effettuato più volte dallo    |
|          |                |     stesso lotto                  |
+----------+----------------+-----------------------------------+
| divisa   |                | -   (1,N) con Ricetta: ogni       |
| in       |                |     ricetta è suddivisa in più    |
|          |                |     fasi                          |
|          |                |                                   |
|          |                | -   (1,N) con Fasi: la stessa     |
|          |                |     fase può essere impiegata in  |
|          |                |     più ricette                   |
+----------+----------------+-----------------------------------+
| prodotto |                | -   (1,N) con Lotto: uno stesso   |
| con      |                |     lotto può impiegare più tipi  |
|          |                |     di latte                      |
|          |                |                                   |
|          |                | -   (1,N) con Latte: lo stesso    |
|          |                |     tipo di latte può essere      |
|          |                |     utilizzato da più lotti       |
+----------+----------------+-----------------------------------+
| produce  |                | -   (1,1) con Latte: una quantità |
|          |                |     di latte viene munta da un    |
|          |                |     solo animale                  |
|          |                |                                   |
|          |                | -   (0,N) con Animale: ogni       |
|          |                |     animale che può essere munto  |
|          |                |     può produrre diverse quantità |
|          |                |     di latte                      |
+----------+----------------+-----------------------------------+
| produce  |                | -   (1,N) con Agriturismo: ogni   |
|          |                |     agriturismo produce i propri  |
|          |                |     formaggi                      |
|          |                |                                   |
|          |                | -   (1,1) con Formaggio: ogni     |
|          |                |     tipo di formaggio è           |
|          |                |     univocamente legato           |
|          |                |     all'agriturismo che lo        |
|          |                |     produce                       |
+----------+----------------+-----------------------------------+
| rilievo  |                | -   (1,N) con Cantine: ad ogni    |
| parametr |                |     cantina possono corrispondere |
| i        |                |     diverse rilevazioni di        |
|          |                |     parametri                     |
|          |                |                                   |
|          |                | -   (1,1) con Parametri: ogni     |
|          |                |     rilevazione è relativa ad una |
|          |                |     sola cantina                  |
+----------+----------------+-----------------------------------+
| stoccagg |                | -   (0,N) con Lotto: i lotti che  |
| io       |                |     richiedono stagionatura       |
| cantine  |                |     possono stoccare o propri     |
|          |                |     formaggi in più cantine       |
|          |                |                                   |
|          |                | -   (1,N) con Cantine: in ogni    |
|          |                |     cantina possono essere        |
|          |                |     stoccati più lotti            |
+----------+----------------+-----------------------------------+
| stoccagg |                | -   (1,N) con Lotto: ogni lotto è |
| io       |                |     stoccato in più magazzini     |
| magazzin |                |                                   |
| i        |                | -   (1,N) con Magazzini: in ogni  |
|          |                |     magazzino possono essere      |
|          |                |     stoccati più lotti            |
+----------+----------------+-----------------------------------+
| stoccato |                | -   (1,1) con Latte: una quantità |
| in       |                |     di latte munto deve essere    |
|          |                |     stoccata in un solo silos     |
|          |                |                                   |
|          |                | -   (1,N) con Silos: ogni silos   |
|          |                |     accoglie diverse quantità di  |
|          |                |     latte, purchè abbiano         |
|          |                |     quantità di sostanze          |
|          |                |     disciolte simili              |
+----------+----------------+-----------------------------------+
| utilizza |                | -   (1,1) con Formaggio: ogni     |
| ndo      |                |     formaggio ha una sola ricetta |
|          |                |     di produzione                 |
|          |                |                                   |
|          |                | -   (1,N) con Ricetta: la stessa  |
|          |                |     ricetta può essere utilizzata |
|          |                |     per più formaggi di diversi   |
|          |                |     agriturismi                   |
+----------+----------------+-----------------------------------+
| è munto  |                | -   (0,N) con Animale: solo gli   |
| durante  |                |     animali femmina e adulti      |
|          |                |     possono essere munti          |
|          |                |                                   |
|          |                | -   (1,1) con Mungitura: ogni     |
|          |                |     mungitura è riferita ad un    |
|          |                |     solo animale                  |
+----------+----------------+-----------------------------------+

Area Soggiorno
--------------

### Entità {#Soggiorno Entita}

+---------+-------------+------------------------+-------------+
| **Nome  | **Descrizio | **Attributi**          | **Collegame |
| entità* | ne**        |                        | nti**       |
| *       |             |                        |             |
+:========+:============+:=======================+:============+
| Cliente | Acquirente  | -   codCarta           | Account,    |
|         | di prodotti |                        | Agriturismo |
|         | o servizi   |                        | ,           |
|         | proposti da |                        | Pagamenti,  |
|         | un          |                        | Stanza,     |
|         | agriturismo |                        | Escursione  |
|         | :           |                        |             |
|         | può essere  |                        |             |
|         | registrato  |                        |             |
|         | o meno      |                        |             |
+---------+-------------+------------------------+-------------+
| Escursi | Ulteriore   | -   codice             | Cliente,    |
| one     | servizio    |                        | Itinerario, |
|         | offerto ai  | -   giorno             | Guida       |
|         | clienti,    |                        |             |
|         | prevede un  | -   orario             |             |
|         | itinerario  |                        |             |
|         | composto    |                        |             |
|         | dalla       |                        |             |
|         | visita di   |                        |             |
|         | una serie   |                        |             |
|         | di aree     |                        |             |
|         | della       |                        |             |
|         | tenuta      |                        |             |
|         | dell'agritu |                        |             |
|         | rismo       |                        |             |
+---------+-------------+------------------------+-------------+
| Guida   | Accompagnat | -   codFisc            | Escursione  |
|         | ore         |                        |             |
|         | degli       | -   nome               |             |
|         | escursionis |                        |             |
|         | ti          | -   cognome            |             |
|         | lungo       |                        |             |
|         | l'itinerari | -   contatto           |             |
|         | o           |                        |             |
|         | previsto    |                        |             |
+---------+-------------+------------------------+-------------+
| Itinera | Percorso di | -   codice             | Escursione, |
| rio     | un'escursio |                        | Tappe       |
|         | ne,         | -   numSentieri        |             |
|         | prevede la  |                        |             |
|         | sosta lungo |                        |             |
|         | più tappe   |                        |             |
+---------+-------------+------------------------+-------------+
| Non     | Insieme dei | -   anticipo           | Account,    |
| registr | clienti che |                        | Agriturismo |
| ato     | non hanno   |                        | ,           |
|         | un account  |                        | Pagamenti,  |
|         | registrato  |                        | Stanza,     |
|         | nel sito    |                        | Escursione  |
+---------+-------------+------------------------+-------------+
| Pagamen | Storico dei | -   codPagamento       | Cliente     |
| ti      | pagamenti   |                        |             |
|         | effettuati  | -   tipoPagamento      |             |
|         | dai clienti |                        |             |
|         | per         | -   totaleCosto        |             |
|         | l'acquisto  |                        |             |
|         | di prodotti | -   data               |             |
|         | o servizi   |                        |             |
|         |             | -   ora                |             |
|         |             |                        |             |
|         |             | -   codCarta           |             |
+---------+-------------+------------------------+-------------+
| Prenota | Effettiva   | -   dataPrenotazione   | Account,    |
| zione   | prenotazion |                        | Agriturismo |
| Escursi | e           |                        | ,           |
| one     | di un       |                        | Pagamenti,  |
|         | escursione  |                        | Stanza,     |
|         | da parte di |                        | Escursione  |
|         | un cliente  |                        |             |
+---------+-------------+------------------------+-------------+
| Prenota | Effettiva   | -   dataPartenza       | Account,    |
| zione   | prenotazion |                        | Agriturismo |
| Stanza  | e           | -   dataArivo          | ,           |
|         | di una      |                        | Pagamenti,  |
|         | stanza da   |                        | Stanza,     |
|         | parte di un |                        | Escursione, |
|         | cliente     |                        | Servizio    |
|         |             |                        | per Stanza  |
+---------+-------------+------------------------+-------------+
| Servizi | Ogni        | -   tipoServizio       | Stanza      |
| o       | cliente che |                        |             |
| Aggiunt | soggiorna   | -   costo              |             |
| ivo     | in una      |                        |             |
|         | stanza può  |                        |             |
|         | usufruire   |                        |             |
|         | di servizi  |                        |             |
|         | aggiuntivi  |                        |             |
|         | quali       |                        |             |
|         | idromassagg |                        |             |
|         | io,         |                        |             |
|         | accesso al  |                        |             |
|         | centro      |                        |             |
|         | benessere,  |                        |             |
|         | accesso     |                        |             |
|         | piscina     |                        |             |
|         | etc.        |                        |             |
+---------+-------------+------------------------+-------------+
| Servizi | Servizio    | -   dataInizioUtilizzo | Account,    |
| o       | effettivame |                        | Agriturismo |
| per     | nte         | -   dataFineUtilizzo   | ,           |
| Stanza  | aggiunto    |                        | Pagamenti,  |
|         | alla        |                        | Prenotazion |
|         | prenotazion |                        | e           |
|         | e           |                        | Stanza,     |
|         | della       |                        | Escursione  |
|         | stanza di   |                        |             |
|         | un cliente  |                        |             |
+---------+-------------+------------------------+-------------+
| Stanza  | Una camera  | -   numStanza          | Cliente,    |
|         | singola o   |                        | Agriturismo |
|         | suite che   | -   costoGiornaliero   | ,           |
|         | può essere  |                        | Servizio    |
|         | prenotata   | -   numLetti           | Aggiuntivo  |
|         | per il      |                        |             |
|         | soggiorno   | -   tipoLetti          |             |
|         | dei clienti |                        |             |
|         |             | -   suite              |             |
+---------+-------------+------------------------+-------------+
| Tappe   | Area        | -   nome               | Itinerario  |
|         | dell'agritu |                        |             |
|         | rismo       | -   tempoPermanenza    |             |
|         | dedicata    |                        |             |
|         | alla visita |                        |             |
|         | e al riposo |                        |             |
|         | durante le  |                        |             |
|         | escursioni  |                        |             |
+---------+-------------+------------------------+-------------+

### Relazioni {#Soggiono Relazioni}

+----------+----------------+-----------------------------------+
| **Nome   | **Attributi**  | **Cardinalità**                   |
|     rela |                |                                   |
| zione**  |                |                                   |
+:=========+:===============+:==================================+
| assegnaz |                | -   (0,N) con Cliente: un cliente |
| ione     |                |     può prenotare o no più stanze |
| cliente  |                |                                   |
|          |                | -   (1,1) con Prenotazione        |
|          |                |     Stanza: ogni prenotazione è   |
|          |                |     effettuata da un solo cliente |
+----------+----------------+-----------------------------------+
| assegnaz |                | -   (1,1) con Prenotazione        |
| ione     |                |     Stanza: ogni prenotazione si  |
| stanza   |                |     riferisce ad una sola stanza  |
|          |                |                                   |
|          |                | -   (0,N) con Stanza: ogni stanza |
|          |                |     può essere prenotata o no più |
|          |                |     volte                         |
+----------+----------------+-----------------------------------+
| composto |                | -   (1,N) con Itinerario: ogni    |
| da       |                |     itinerario è composto da più  |
|          |                |     tappe                         |
|          |                |                                   |
|          |                | -   (1,N) con Tappe: ogni tappa   |
|          |                |     può appartenere a più         |
|          |                |     itinerari                     |
+----------+----------------+-----------------------------------+
| division |                | -   (1,1) con Stanza: ogni stanza |
| e        |                |     appartiene ad un solo         |
| stanza   |                |     agriturismo                   |
|          |                |                                   |
|          |                | -   (1,N) con Agriturismo: ad     |
|          |                |     ogni agriturismo appartengono |
|          |                |     più stanze                    |
+----------+----------------+-----------------------------------+
| effettua |                | -   (0,N) con Cliente: alcuni     |
|          |                |     clienti possono effettuare    |
|          |                |     più pagamenti                 |
|          |                |                                   |
|          |                | -   (1,1) con Pagamenti: ogni     |
|          |                |     pagamento viene effettuato da |
|          |                |     un solo cliente               |
+----------+----------------+-----------------------------------+
| effettua |                | -   (1,1) con Escursione: ogni    |
| ta       |                |     escursione è effettuata da    |
| da       |                |     una sola guida                |
|          |                |                                   |
|          |                | -   (0,N) con Guida: ogni guida   |
|          |                |     può effettuare o no più       |
|          |                |     escursioni                    |
+----------+----------------+-----------------------------------+
| legata a |                | -   (1,N) con Escursione: ogni    |
|          |                |     escursione può essere legata  |
|          |                |     a più itinerari               |
|          |                |                                   |
|          |                | -   (1,N) con Itinerario: ogni    |
|          |                |     itinerario può comporre più   |
|          |                |     escursioni                    |
+----------+----------------+-----------------------------------+
| ospita   |                | -   (0,N) con Cliente: ogni       |
|          |                |     cliente può non essere        |
|          |                |     ospitato da nessun            |
|          |                |     agriturismo (effettua solo    |
|          |                |     acquisti), oppure risiedere   |
|          |                |     in più agriturismi            |
|          |                |                                   |
|          |                | -   (1,N) con Agriturismo: in     |
|          |                |     ogni agriturismo risiedono    |
|          |                |     più clienti                   |
+----------+----------------+-----------------------------------+
| possiede |                | -   (0,1) con Cliente: ogni       |
|          |                |     cliente può essere registrato |
|          |                |     o no, e quindi possedere al   |
|          |                |     massimo un account            |
|          |                |                                   |
|          |                | -   (1,1) con Account: ogni       |
|          |                |     account è associato ad un     |
|          |                |     solo cliente                  |
+----------+----------------+-----------------------------------+
| prenotaz |                | -   (0,N) con Cliente: un cliente |
| ione     |                |     può prenotare o no più        |
| cliente  |                |     escursioni                    |
|          |                |                                   |
|          |                | -   (1,1) con Prenotazione        |
|          |                |     Escursione: ogni prenotazione |
|          |                |     si riferisce ad una sola      |
|          |                |     escursione                    |
+----------+----------------+-----------------------------------+
| prenotaz |                | -   (1,1) con Prenotazione        |
| ione     |                |     Escursione: ogni prenotazione |
| escursio |                |     si riferisce ad una sola      |
| ne       |                |     escursione                    |
|          |                |                                   |
|          |                | -   (0,N) con Escursione: ogni    |
|          |                |     escursione può o no essere    |
|          |                |     prenotata più volte           |
+----------+----------------+-----------------------------------+
| servizio |                | -   (1,1) con Servizio per        |
| associat |                |     Stanza: ogni servizio         |
| o        |                |     aggiunto ad una stanza        |
|          |                |     comprende un solo set di      |
|          |                |     servizi                       |
|          |                |                                   |
|          |                | -   (1,N) con Servizio            |
|          |                |     Aggiuntivo: ogni servizio     |
|          |                |     aggiuntivo può essere         |
|          |                |     associato a più stanze        |
|          |                |     prenotate                     |
+----------+----------------+-----------------------------------+
| stanza   |                | -   (1,1) con Servizio per        |
| associat |                |     Stanza: ad ogni stanza        |
| a        |                |     prenotta con servizio         |
|          |                |     corrisponde un solo set di    |
|          |                |     servizi                       |
|          |                |                                   |
|          |                | -   (0,N) con Prenotazione        |
|          |                |     Stanza: ogni servizio offerto |
|          |                |     può essere associato a più    |
|          |                |     stanze prenotate              |
+----------+----------------+-----------------------------------+

Area Store
----------

### Entità {#Store Entita}

+---------+-------------+------------------------+-------------+
| **Nome  | **Descrizio | **Attributi**          | **Collegame |
| entità* | ne**        |                        | nti**       |
| *       |             |                        |             |
+:========+:============+:=======================+:============+
| Account | Identità    | -   utente             | Cliente,    |
|         | digitale    |                        | Recensione, |
|         | legata ad   | -   password           | Ordine      |
|         | un cliente: |                        | Prodotti    |
|         | permette    | -   domandaRec         |             |
|         | l'acquisto  |                        |             |
|         | e la        | -   rispostaRec        |             |
|         | recensione  |                        |             |
|         | sullo store | -   numTelefono        |             |
|         | online dei  |                        |             |
|         | prodotti    | -   codFiscale         |             |
|         | caseari     |                        |             |
|         |             | -   dataIscrizione     |             |
|         |             |                        |             |
|         |             | -   tipoDoc            |             |
|         |             |                        |             |
|         |             | -   numDoc             |             |
|         |             |                        |             |
|         |             | -   codDoc             |             |
|         |             |                        |             |
|         |             | -   scadenzaDoc        |             |
|         |             |                        |             |
|         |             | -   enteRilascio       |             |
|         |             |                        |             |
|         |             | -   cognome            |             |
|         |             |                        |             |
|         |             | -   nome               |             |
|         |             |                        |             |
|         |             | -   indirizzo          |             |
+---------+-------------+------------------------+-------------+
| Centri  | La          | -   codice             | Spedizione  |
| Smistam | spedizione  |                        |             |
| ento    | di un       | -   contatto           |             |
|         | prodotto    |                        |             |
|         | attraversa  | -   indirizzo          |             |
|         | numerosi    |                        |             |
|         | centri di   | -   nome               |             |
|         | smistamento |                        |             |
|         | prima di    |                        |             |
|         | raggiungere |                        |             |
|         | la propria  |                        |             |
|         | destinazion |                        |             |
|         | e           |                        |             |
+---------+-------------+------------------------+-------------+
| Formagg | L'effettivo | -   codiceProdotto     | Recensione, |
| io      | formaggio   |                        | Formaggio,  |
| Prodott | prodotto in | -   peso               | Ordine      |
| o       | una certa   |                        | Prodotti,   |
|         | data e con  | -   scadenza           | Lotto       |
|         | una         |                        |             |
|         | determinata | -   prezzo             |             |
|         | data di     |                        |             |
|         | scadenza    | -   rimastiInStock     |             |
|         |             |                        |             |
|         |             | -   lottoAppartenenza  |             |
+---------+-------------+------------------------+-------------+
| Ordine  | Lista dei   | -   codiceOrdine       | Cliente,    |
| Prodott | prodotti    |                        | Formaggio   |
| i       | ordinati    | -   tipoConsegnaReso   | Prodotto,   |
|         | sullo store |                        | Spedizione  |
|         | online da   | -   stato              |             |
|         | un cliente  |                        |             |
|         |             | -   data               |             |
+---------+-------------+------------------------+-------------+
| Recensi | Opinione    | -   codiceRecensione   | Account,    |
| one     | dei clienti |                        | Formaggio   |
|         | sulla       | -   gradimentoGenerale | Prodotto    |
|         | qualità di  |                        |             |
|         | uno         | -   qualitàPercepita   |             |
|         | specifico   |                        |             |
|         | prodotto    | -   gusto              |             |
|         | acquistato  |                        |             |
|         |             | -   campoTestuale      |             |
|         |             |                        |             |
|         |             | -   conservazione      |             |
+---------+-------------+------------------------+-------------+
| Spedizi | Storico     | -   codice             | Ordine      |
| one     | delle       |                        | Prodotti,   |
|         | spedizioni  | -   dataConsegnaEffett | Centri      |
|         | effettuate  | iva                    | Smistamento |
|         | per l'invio |                        |             |
|         | dei         | -   dataConsegnaPrevis |             |
|         | prodotti    | ta                     |             |
|         | agli        |                        |             |
|         | acquirenti  | -   percorso           |             |
|         |             |                        |             |
|         |             | -   stato              |             |
+---------+-------------+------------------------+-------------+

### Relazioni {#Store Relazioni}

+----------+----------------+-----------------------------------+
| **Nome   | **Attributi**  | **Cardinalità**                   |
|     rela |                |                                   |
| zione**  |                |                                   |
+:=========+:===============+:==================================+
| consegna |                | -   (1,1) con Ordine Prodotti:    |
| to       |                |     ogni ordine è associato da    |
| da       |                |     una sola spedizione           |
|          |                |                                   |
|          |                | -   (1,N) con Spedizione: ogni    |
|          |                |     spedizione può consegnare più |
|          |                |     ordini                        |
+----------+----------------+-----------------------------------+
| contenut | quantità, reso | -   (0,N) con Formaggio Prodotto: |
| o        |                |     ogni formaggio può            |
| ordine   |                |     appartenere o no a più ordini |
|          |                |                                   |
|          |                | -   (1,N) con Ordine Prodotti:    |
|          |                |     ogni ordine è composto da uno |
|          |                |     o più formaggi                |
+----------+----------------+-----------------------------------+
| esegue   |                | -   (0,N) con Account: ogni       |
| ordine   |                |     account può può effettuare o  |
|          |                |     no più ordini                 |
|          |                |                                   |
|          |                | -   (1,1) con Ordine Prodotti:    |
|          |                |     ogni ordine è effettuato da   |
|          |                |     un solo account               |
+----------+----------------+-----------------------------------+
| processa |                | -   (1,N) con Spedizioni: ogni    |
| ta       |                |     spedizione può essere         |
| da       |                |     processata da più centri di   |
|          |                |     smistamento                   |
|          |                |                                   |
|          |                | -   (1,N) con Centri Smistamento: |
|          |                |     ogni hub può processare più   |
|          |                |     spedizioni                    |
+----------+----------------+-----------------------------------+
| scrive   |                | -   (0,N) con Account: ogni       |
|          |                |     account può scrivere o no una |
|          |                |     o più recensioni              |
|          |                |                                   |
|          |                | -   (1,1) con Recensione: ogni    |
|          |                |     recensione è stata scritta da |
|          |                |     un solo account               |
+----------+----------------+-----------------------------------+
| valuta   |                | -   (1,1) con Recensione: ogni    |
|          |                |     recensione valuta un solo     |
|          |                |     formaggio                     |
|          |                |                                   |
|          |                | -   (0,N) con Formaggio Prodotto: |
|          |                |     ogni formaggio può essere     |
|          |                |     valutato o no da più          |
|          |                |     recensioni                    |
+----------+----------------+-----------------------------------+

Ristrutturazione generalizzazioni {#sec:ristrutturazione}
=================================

animale
-------

![generalizzazione dell'entità Animale
Acquisito](ridondanze/animale.png){width="115%"}

La generalizzazione dell'entità Animale Acquisito viene risolta
sostituendo l'entità stessa con una relazione che mantiene gli stessi
attributi ad eccezione del codice di acquisizione; essendo questa un'
associazione con cardinalità (0,1)-(1,N), viene usata come chiave
l'identificatore di animale. Inoltre, vengono eliminate le relazioni
ricorsive padre e madre tramite l'inserimento degli attributi *idMadre*
e *idPadre* con vincoli di integrità generici.

sensori
-------

![generalizzazione dell'entità
Sensori](ridondanze/sensori.png){width="115%"}

Si è preferito eliminare la generalizzazione di Sensori dividendo
l'entità in tre nuove entità indipendenti, in quanto ogni sensore
raccoglie informazioni di tipo diverso, e ciò riempirebbe
alternativamente la tabella di valori NULL. Con questa soluzione, ogni
tipologia di sensore compila record completi e contenenti solamente i
dati raccolti.

acqua
-----

![generalizzazione dell'entità Acqua
Arricchita](ridondanze/acqua.png){width="115%"}

La generalizzazione parziale di Acqua Arricchita è stata eliminata
considerando il fatto che trasformandola in una relazione si ottiene una
tabella che contiene un solo attributo come chiave primaria. Questo non
consente di avere informazioni dettagliate sull'acqua da fornire agli
animali. Il problema si risolve utilizzando un'unica tabella che ha come
identificatore primario le concentrazioni di vitamine e sali,
considerando l'acqua non arricchita come avente concentrazioni pari a
zero su entrambi gli attributi. Ciò consente di evitare valori NULL
sulla chiave primaria.

riproduzione
------------

![generalizzazione dell'entità
Riproduzione](ridondanze/riproduzione.png){width="115%"}

La generalizzazione sulla tabella Riproduzione è stata ristrutturata
considerando che entrambi gli attributi *codiceNeonato* e
*esitoVisitaControllo* sono ridondanti e ricavabili tramite vincolo di
integrità. Inoltre si è scelto di accorpare il campo delle complicanze a
Riproduzione in quanto statisticamente i casi di insuccesso sono molto
minori di quelli con successo, questo giustifica la presenza di alcuni
valori NULL nella tabella Riproduzione, e consente di non creare due
ulteriori entità nel database.

allestimento
------------

![generalizzazione dell'entità
Allestimento](ridondanze/allestimento.png){width="115%"}

La generalizzazione dell'entità Allestimento è stata risolta separando
le varie entità figlie. Facendo ciò si eliminano i valori NULL
sull'attributo *quantitàRestante* per gli impianti di illuminazione e di
condizionamento, inoltre si evita di controllare che i pasti vengano
assegnati ad allestimenti non consoni (condizionamento e illuminazione).

cliente
-------

![generalizzazione dell'entità Cliente
Registrato](ridondanze/cliente.png){width="115%"}

La generalizzazione sulla registrazione dell'entità Cliente è stata
risolta considerando solo l'entità stessa a cui è stato aggiunto
l'attributo *anticipo* derivato dall'entità figlia Non Registrato.
Questo consente di ridurre il numero di tabelle nel database e di
mantenere l'informazione inerente la registrazione del cliente azzerando
il valore di *anticipo* per tutti i clienti registrati.

formaggio
---------

![generalizzazione dell'entità Formaggio
Prodotto](ridondanze/formaggio.png){width="115%"}

Si è scelto di mantenere distinte le tabelle nella generalizzazione di
Formaggio, in quanto risulta importante la distinzione tra l'ipotetico
prodotto di un singolo agriturismo e il formaggio effettivo (Formaggio
Prodotto), che gode così di uno specifico lotto di appartenenza e una
data di scadenza. Il prodotto potrà così essere fisicamente ordinato e
recensito dai clienti.

scheda medica
-------------

![generalizzazione dell'entità Scheda
Medica](ridondanze/scheda_medica.png){width="115%"}

Si è scelto di mantenere distinte le entità figlie di Scheda Medica per
mantenere le informazioni dei Disturbi Comportamentali e delle Lesioni
separate. Così facendo si è evitata l'introduzione di molteplici valori
NULL all'interno della tabella Scheda Medica.

Individuazione delle Ridondanze {#sec:ridondanze}
===============================

In questo capitolo vengono prese in esame tutte le informazioni
ridondanti interne al database. Viene mostrato, inoltre, come è
possibile eliminare le ridondanze superflue con la modifica o
l'inserimento di nuovi attributi, oppure mantenere quelle utili per
ricavare in modo semplice informazioni rilevanti e di frequente
utilizzo, altrimenti difficilmente ricavabili.

Ridondanze degli Attributi {#subsec:ridondanze-attr}
--------------------------

-   È stato tolto *nome* da Fornitore in quanto ricavabile da *ragione
    sociale*

-   È stato eliminato *codice neonato* da Riproduzione in quanto
    ricavabile dal confronto tra *id\_madre* e *id\_padre* con *codice
    madre* e *codice padre* su coinvolge, tenendo conto della *data*
    della specifica Riproduzione

-   È stato eliminato *stato* da Visita in quanto il valore di quest'
    attributo è ridondante rispetto alla presenza o no del valore NULL
    sull'attributo *data effettiva*

-   È stato eliminato *interventi di controllo programmati* da Scheda
    gestazione in quanto ricavabile verificando che la *data
    programmata* di Visita sia successiva alla *data* della
    Riproduzione, e che *data effettiva* sia NULL

-   Si mantiene la ridondanza di *capienza max* di Locale seppur possa
    essere ricavata dalla specie ospitata e dalle dimensioni dello
    stesso

-   Si mantiene le ridondanza delle *kcal/kg* del Foraggio seppur possa
    essere ricavata dalle quantità di fibre, proteine e glucidi
    contenute

-   Si mantiene il *nome* ed il *cognome* dei Veterinari seppur possano
    essere ricavati dal *codice fiscale*

-   Si mantiene il *nome* ed il *cognome* degli Account seppur possano
    essere ricavati dal *codice fiscale*

-   Si mantiene la *scadenza* del Formaggio Prodotto seppur possa essere
    ricavata dalla *deperibilità* del Formaggio insieme alla *data di
    produzione* del Lotto associato

-   Si mantiene il *totale da pagare* nei Pagamenti seppur ricavabile
    come somma di tutti i costi delle camere, delle escursioni e dei
    servizi aggiuntivi: ciò permette di centralizzare l'informazione del
    pagamento totale in un unica tabella

Ridondanze E-R {#subsec:ridondanze-ent-rel}
--------------

1.  È stata introdotta la ridondanza *qualità pasto* tra *Pasto* e
    *Indici salute*: questo permette di controllare se esiste una
    correlazione tra lo stato di salute di un animale e la sua
    nutrizione. Si sarebbe potuto ricavare la stessa informazione
    considerando i locali abitati dagli animali ed i pasti somministrati
    in ognuno di essi, precedentemente alla rilevazione dei nuovi indici
    di salute.

2.  È stata introdotta la ridondanza *partecipazione attività* tra
    *Animale* e *Attività pascolo*: questo permette di ricavare
    velocemente a quale attività di pascolo stia partecipando uno
    specifico animale e permette di rilevare immediatamente quando un
    animale non rientra nell'area destinata alla sua attività. La stessa
    informazione è ricavabile controllando il locale abitato
    dall'animale e l'attività ad esso assegnata.

Tavole dei Volumi {#sec:volumi}
=================

Area Allevamento
----------------

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  Abbeveratoio     E         1000        Un quarto degli allestimenti
                                         sono abbeveratoi

  Acqua            E         20          Si considerano circa 20
                                         tipologie uniche di acqua

  Agriturismo      E         20          Ipotesi iniziale

  Allestimento     E         4000        Ogni locale è provvisto
                                         mediamente di otto
                                         allestimenti: due mangiatoie,
                                         due abbeveratoi, due
                                         dispositivi per il
                                         condizionamento dell'aria e due
                                         sistemi di illuminazione
                                         $8\times 500 = 4000$

  Ambientali       E         500         Ogni locale è dotato di un
                                         sensore per i parametri
                                         ambientali

  Animale          E         20000       Ogni agriturismo ospita 1000
                                         animali $20\times 1000=20000$

  Area pascolo     E         60          Ogni agriturismo dispone di 3
                                         aree di pascolo
                                         $3\times 20= 60$

  Attività pascolo E         4500        Mediamente, ogni agriturismo
                                         dispone delle proprie 3 aree di
                                         pascolo e altre 6 degli
                                         agriturismi limitrofi
                                         $500\times 9 = 4500$

  Condizionatore   E         500         Ogni locale è dotato di un
  aria                                   condizionatore dell'aria

  Composti         E         500         Ogni locale è dotato di un
  volatili                               sensore per i composti volatili

  Foraggio         E         50          Si considerano circa 50
                                         tipologie uniche di foraggio

  Fornitore        E         20          Si assume una media di un
                                         fornitore per agriturismo

  GPS              E         20000       Ogni animale è dotato di un
                                         dispositivo GPS

  Illuminazione    E         500         Ogni locale è dotato di un
                                         dispositivo di illuminazione

  Locale           E         500         Ogni stalla ha in media 5
                                         locali

  Mangiatoia       E         1000        Un quarto degli allestimenti
                                         sono mangiatoie

  Pasto            E         1000        Combinazione tra tutti i tipi
                                         di acqua e di foraggio
                                         $20\times 50= 1000$

  Pasto per Locale R         547500      Tre pasti al giorno per un anno
                                         per ogni locale
                                         $3\times365\times500=547500$

  Pulizia locale   E         580         Ogni agriturismo effettua due
                                         richieste al giorno, per un
                                         totale di $2\times 365=730$
                                         richieste annue[^1]. Quindi i
                                         20 agriturismi compilano
                                         $730\times 20=14600$ record
                                         all'anno.

  Recinzione       E         180         Ogni area di pascolo è divisa
  divisoria e zona                       in 3 recinsioni
  di pascolo                             $60\times 3= 180$

  Riproduzione     E         12900       Secondo l'Istat circa il $75\%$
                                         degli animali è femmina, nel
                                         nostro caso
                                         $20000\times0.75=15000$. Di
                                         queste, il $14\%$ non è
                                         destinato all'allevamento,
                                         quindi in un anno il restante
                                         $86\%$ si riproduce
                                         $15000\times 0.86=12900$

  Scheda           E         11610       Viene generata una nuova scheda
  gestazione                             di gestazione per ogni
                                         riproduzione andata a buon
                                         fine, ossia il $90\%$ delle
                                         riproduzioni
                                         $12900\times 0.9= 11610$

  Stalla           E         100         Ogni agriturismo possiede in
                                         media 5 stalle

  Visivi           E         500         Ogni locale è dotato di un
                                         sensore per i parametri visivi

  abita            R         20000       Cardinalità (1,1) con Animale

  acquisto animale R         10000       Cardinalità (1,1) con ogni
                                         animale acquisito, ossia con il
                                         $50\%$ del voume di Animali

  attività locale  R         4500        Cardinalità (1,1) con Attività
                                         pascolo

  coinvolge        R         12900       Cardinalità (1,1) con
                                         Riproduzione

  collocazione     R         4500        Cardinalità (1,1) con Attività
  attività                               pascolo

  composizione     R         1000        Cardinalità (1,1) con Pasto
  acqua                                  

  composizione     R         1000        Cardinalità (1,1) con Pasto
  foraggio                               

  determina        R         11610       Cardinalità (1,1) con Scheda
                                         gestazione

  divisione        R         4000        Cardinalità (1,1) con
  allestimento                           Allestimento

  divisione locale R         500         Cardinalità (1,1) con Locale

  divisione        R         180         Cardinalità (1,1) con
  pascolo                                Recinzione divisoria e zona di
                                         pascolo

  divisione stalle R         100         Cardinalità (1,1) con Stalla

  locale assegnato R         547500      Cardinalità (1,1) con Pasto per
                                         Locale

  localizzato      R         20000       Cardinalità (1,1) con Animale e
                                         con GPS

  pasto assegnato  R         547500      Cardinalità (1,1) con Pasto per
                                         Locale

  richiesta        R         580         Cardinalità (1,1) con Pulizia
  intervento                             locale

  rilievo composti R         500         Cardinalità (1,1) con Composti
  volatili                               volatili

  rilievo          R         500         Cardinalità (1,1) con rilievo
  parametri                              parametri ambientali
  ambientali                             

  rilievo          R         500         Cardinalità (1,1) con Visivi
  parametri visivi                       

  scrive           R         11610       Cardinalità (1,1) con Scheda
                                         gestazione

  supervisiona     R         12900       Cardinalità (1,1) con
                                         Riproduzione
  ----------------------------------------------------------------------

Area Healthcare
---------------

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  Esame                                  Per ogni agriturismo vengono
                                         prescritti una media di 400
                                         esami l'anno per un totale di
                                         8000 esami

  Farmaco                                Si suppone che le malattie
                                         vengano curate con l'utilizzo
                                         di 100 farmaci diversi
                                         utilizzati in tutta la rete di
                                         *Farmhouse 4.0*

  Indici Salute                          Per ogni visita vengono
                                         rilevati nuovamente gli indici
                                         di salute

  Scheda Medica                          Si suppone che in un anno siano
                                         registrate 40000 schede

  Terapia                                Si suppone che ogni anno
                                         vengano prescritte 2 terapie
                                         per ogni animale
                                         $2\times 20000= 40000$

  Veterinario                            Si suppone che ogni agriturismo
                                         sia controllato da cinque
                                         veterinari $20\times 5= 100$

  Visita                                 Si suppone che per ogni
                                         agriturismo vengano eseguite
                                         1100 visite all'anno per poter
                                         controllare almeno una volta
                                         tutti gli animali
                                         $1100\times 20= 22000$

  compila                                Cardinalità (1,1) con Scheda
                                         Medica

  composta da                            Ogni terapia impiega circa 3
                                         farmaci diversi
                                         $2000\times 3 = 6000$

  controlli                              Viene effettuata una visita di
  effettuati                             controllo per ogni riproduzione
                                         con successo o insuccesso

  esegue                                 Cardinalità (1,1) con Visita

  possiede                               Cardinalità (1,1) con Scheda
                                         Medica

  possiede esame                         Cardinalità (1,1) con Esame

  possiede terapia                       Cardinalità (1,1) con Terapia

  possiede visita                        Cardinalità (1,1) con Visita

  prescrive                              Cardinalità (1,1) con Terapia

  prescrive esame                        Cardinalità (1,1) con Esame

  stato salute                           Cardinalità (1,1) con Indici
                                         Salute
  ----------------------------------------------------------------------

Area Produzione
---------------

  --------------------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -----------------------------------------
  Cantine          E         100         Mediamente sono disponibili 5 cantine per
                                         ogni agriturismo $20\times 5=100$

  Fasi             E         4000        Ogni ricetta è divisa mediamente in 10
                                         fasi $400\times 10 = 4000$

  Formaggio        E         400         Ogni agriturismo produce circa 20
                                         formaggi differenti

  Latte            E         400         Ogni agriturismo produce 20 tipologie di
                                         latte differente $20\times 20 = 400$

  Lotto            E         400         Ogni agriturismo produce 20 lotti di
                                         formaggio all'anno

  Magazzini        E         100         Mediamente sono disponibili 5 magazzini
                                         per ogni agriturismo $20\times 5 = 100$

  Mungitrice       E         2000        Ogni agriturismo dispone di circa 100
                                         mungitrici $20\times 100= 2000$

  Mungitura        E         5475000     Si suppone che ogni giorno dell'anno ogni
                                         animale femmina di un agriturismo venga
                                         munto una volta
                                         $20000\times 0.75 \times 365 = 5475000$

  Parametri        E         36500       Ogni giorno dell'anno vengono prelevati i
                                         parametri di tutte le cantine
                                         $365\times 100= 36500$

  Ricetta          E         400         Si considerano circa 400 ricette
                                         differenti

  Scaffalature     E         1000        Ogni cantina è suddivisa in 10
                                         scaffalature

  Scaffali         E         1000        Ogni magazzino è suddiviso in 10 scaffali
                                         $100\times 10=1000$

  Silos            E         200         Sono disponibili circa 10 silos per ogni
                                         agriturismo $10\times 20=200$

  appartenente a   R         3000000     Cardinalità (1,1) con Formaggio Prodotto

  che munge        R         800000      Combinazione tra tutte le mungitrici e
                                         tutti i tipi di latte
                                         $2000\times 400= 800000$

  con              R         5475000     Cardinalità (1,1) con Mungitura

  contengono       R         1000        Cardinalità (1,1) con Scaffalature
  scaffalature                           

  contengono       R         1000        Cardinalità (1,1) con Scaffali
  scaffali                               

  controllo fasi   R         4000        Combinazione tra tutti i lotti e le
                                         proprie 10 fasi di produzione
                                         $400\times 10=4000$

  divisa in        R         4000        Ogni ricetta è divisa in 10 fasi
                                         $400\times 10= 4000$

  prodotto con     R         160000      Combinazione tra tutti i tipi di latte e
                                         tutti i lotti $400\times 400 = 160000$

  produce          R         400         Cardinalità (1,1) con Formaggio

  produce          R         400         Cardinalità (1,1) con Latte

  rilievo          R         36500       Cardinalità (1,1) con Parametri
  parametri                              

  stoccaggio       R         2000        Ogni agriturismo stocca 20 lotti nelle
  cantine                                proprie 5 cantine
                                         $20\times 20 \times 5 = 2000$

  stoccaggio       R         2000        Ogni agriturismo stocca 20 lotti nei
  magazzini                              propri 5 magazzini
                                         $20\times 20 \times 5 = 2000$

  stoccato in      R         400         Cardinalità (1,1) con Latte

  utilizzando      R         400         Cardinalità (1,1) con Formaggio

  è munto durante  R         5475000     Cardinalità (1,1) con Mungitura
  --------------------------------------------------------------------------------

Area Soggiorno
--------------

  -------------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- ----------------------------------
  Cliente                                Ogni agriturismo ha in media 500
                                         clienti all'anno

  Escursione                             Ogni agriturismo dispone di cinque
                                         escursioni

  Guida                                  Si suppone che ogni agriturismo
                                         disponga di tre guide
                                         $20\times 3= 60$

  Itinerario                             Ogni escursione può comprendere al
                                         massimo 5 itinerari
                                         $100\times 5= 500$

  Pagamenti                              Si considera la somma dei
                                         pagamenti per gli ordini sullo
                                         store online, per la prenotazione
                                         delle stanze e delle escursioni
                                         $146000+2\times 10000= 166000$

  Prenotazione                           Si stima che in un anno ogni
  Escursione                             cliente prenoti un'escursione

  Prenotazione                           Si stima che mediamente in un anno
  Stanza                                 ogni cliente prenoti una stanza

  Servizio                               Ogni agriturismo dispone delle
  Aggiuntivo                             stesse 10 tipologie di servizi
                                         aggiuntivi

  Servizio per                           Si considera che la metà delle
  Stanza                                 stanze prenotate abbia usufruito
                                         di tre servizi aggiuntivi
                                         $1000\times 0.5 \times 3 = 1500$

  Stanza                                 Ogni agriturismo ha in media 10
                                         stanze

  Tappe                                  Ogni itinerario ha al massimo
                                         dieci tappe $500\times 10= 5000$

  assegnazione                           Cardinalità (1,1) con Prenotazione
  cliente                                Stanza

  assegnazione                           Cardinalità (1,1) con Prenotazione
  stanza                                 Stanza

  composto da                            Tutte le possibili combinazioni di
                                         itinerari e tappe disponibili per
                                         ogni agriturismo
                                         $10\times 5 \times 20 = 1000$

  divisione stanza                       Cardinalità (1,1) con Stanza

  effettua                               Cardinalità (1,1) con Pagamenti

  effettuata da                          Cardinalità (1,1) con escursione

  legata a                               Tutte le possibili combinazioni
                                         tra escursioni e itinerari
                                         disponibili per ogni agriturismo
                                         $5\times 5 \times 20= 500$

  possiede                               Cardinalità (1,1) con Account

  prenotazione                           Cardinalità (1,1) con Prenotazione
  cliente                                Escursione

  prenotazione                           Cardinalità (1,1) con Prenotazione
  escursione                             Escursione

  servizio                               Cardinalità (1,1) con Servizio per
  associato                              Stanza

  stanza associata                       Cardinalità (1,1) con Servizio per
                                         Stanza
  -------------------------------------------------------------------------

Area Store
----------

  -------------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- ----------------------------------
  Formaggio                              Per far fronte alle richieste
  Prodotto                               della clientela, si decide di
                                         mantenere una produzione
                                         lievemente superiore alle vendite
                                         stimate (circa 80000 prodotti in
                                         più rispetto al volume di
                                         contenuto ordine)

  Account                                Si suppone che il 70% degli utenti
                                         sia registrato, e possegga di
                                         conseguenza un account

  Centri                                 Si suppone che le spedizioni
  Smistamento                            vengano processate da un totale di
                                         100 centri di smistamento

  Ordine Prodotti                        Ogni agriturismo gestisce in media
                                         20 ordini al giorno
                                         $20\times 20\times 365 = 146000$

  Recensione                             Si suppone che il 50% dei clienti
                                         recensisca il proprio ordine,
                                         quindi, ogni anno, la metà dei
                                         formaggi venduti riceve una
                                         recensione
                                         $2920000\times0.5=1460000$

  Spedizione                             Ogni spedizione consegnerà circa
                                         50 ordini collocati per area
                                         geografica simile
                                         ${146000\over 50}=2920$

  consegnato da                          Cardinalità (1,1) con Ordine
                                         Prodotti

  contenuto ordine                       Se si suppone che ogni ordine
                                         contenga 20 prodotti al massimo,
                                         si ottiene un numero totale di
                                         record pari a
                                         $20\times146000=2920000$

  esegue ordine                          Cardinalità (1,1) con Ordine
                                         Prodotti

  istanza                                Cardinalità (1,1) con Formaggio
  formaggio                              Prodotto

  processata da                          Si suppone che ogni spedizione sia
                                         processata da circa 5 centri di
                                         smistamento $2920\times 5=14600$

  scrive                                 Cardinalità (1,1) con Recensione

  valuta                                 Cardinalità (1,1) con Recensione
  -------------------------------------------------------------------------

Analisi delle Operazioni {#sec:operazioni}
========================

Sono qui illustrate le principali operazioni significative capaci di
apportare un forte contributo al carico applicativo della base di dati.
Di ciascuna viene data una breve descrizione, assieme ad una stima della
frequenza giornaliera con cui verranno svolte. Questo permetterà,
assieme ai volumi stimati per ogni entità e relazione nel sistema
(riportati a partire da pag. ), di derivare il carico effettivo che il
database dovrà gestire in termini di operazioni elementari, quali
scritture e letture.\
Legenda per il calcolo delle operazioni elementari:\
frequenza giornaliera: $f^T$\
numero di operazioni elementari: $o^T$\
numero di operazioni giornaliere: $n^T = f^T\cdot o^T$\
numero di operazioni elementari con ridondanza: $o^T_{RID}$\
numero di operazioni giornaliere con ridondanza:
$n^T_{RID}=f^T\cdot o^T_{RID}$\
frequenza di aggiornamento della ridondanza: $f^A$\
numero di operazioni per l'aggiornamento della ridondanza: $o^A$\
numero di operazioni giornaliere per aggiornare la ridondanza:
$n^A = f^A\cdot o^A$

Operazione : Controllo qualità del pasto {#operazione-controllo-qualità-del-pasto .unnumbered}
----------------------------------------

*Descrizione:* Viene controllato che il pasto che viene somministrato
agli animali non abbia ripercussioni sul loro stato di salute: in
particolare vengono controllati gli indici di salute di tutti gli
animali appartenenti ai locali nei quali è stato somministrato il pasto
in esame

*Input:* composizione del pasto

*Output:* media degli indici di salute

*Frequenza giornaliera:* 33[^2]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="100%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  pasto assegnato  R         547500      Cardinalità (1,1) con Pasto per
                                         Locale

  Pasto per Locale R         547500      Tre pasti al giorno per un anno
                                         per ogni locale
                                         $3\times365\times500=547500$

  locale assegnato R         547500      Cardinalità (1,1) con Pasto per
                                         Locale

  abita            R         20000       Cardinalità (1,1) con Animale

  stato salute                           Cardinalità (1,1) con Indici
                                         Salute

  Indici Salute                          Per ogni visita vengono
                                         rilevati nuovamente gli indici
                                         di salute
  ----------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi .unnumbered}

E' presente la ridondanza *qualità pasto* tra Pasto e Indici Salute che
influenza la tavola degli accessi

  -------------- ------- -------------- ------- ----------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           

  pasto                                         Sui 3 pasti giornalieri nelle
  assegnato                                     ultime 2 settimane dei 500 locali
                                                ($3\times 14 \times 500= 21000$)
                                                si vogliono distribuire i 1000
                                                possibili pasti: quindi ogni pasto
                                                compare su $\frac{21000}{1000}=21$
                                                pasti per locale

  Pasto per                                     Si ricavano data e orario
  Locale                                        dell'ultima somministrazione del
                                                pasto

  locale                                        I 21 pasti per locale possono
  assegnato                                     appartenere a minimo 2, massimo 21
                                                locali: quindi mediamente si
                                                devono controllare 12 locali

  abita                                         Si leggono le chiavi di 40 animali
                                                per ognuno dei 12 locali

  stato salute                                  Sono registrati 11 indici di
                                                salute ogni 10 animali
                                                ($480\times 1.1 = 528$)

  Indici salute                                 Lettura dei dati relativi agli
                                                indici di salute degli animali

                                                
  -------------- ------- -------------- ------- ----------------------------------

  -------------- ------- -------------- ------- ---------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           

  qualità pasto                                 Si ricavano gli
                                                indici di salute
                                                associati al pasto
                                                somministrato

  Indici salute                                 Lettura dei dati
                                                relativi alla salute
                                                degli animali

                                                
  -------------- ------- -------------- ------- ---------------------

  -------------- ------- -------------- ------- ---------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           

  stato salute                                  Lettura del codice
                                                dell'animale
                                                associato alla visita

  abita                                         Lettura del locale
                                                abitato dall'animale

  locale                                        Si ricavano i pasti
  assegnato                                     assegnati al locale
                                                nelle ultime 2
                                                settimane

  pasto                                         Si ricavano i dati
  assegnato                                     del pasto
                                                somministrato in quel
                                                locale

  qualità pasto                                 Aggiornamento della
                                                ridondanza

                                                
  -------------- ------- -------------- ------- ---------------------

In sintesi: $$\begin{aligned}
\\ 
&f^T=33
\\ 
&o^T = 1590
\\ 
&n^T = 1590\times33= 52470
\\
&o^T_{RID}= 1056
\\
&n^T_{RID} = 1056\times 33 = 34848
\\
&f^A= 60
\\
&o^A= 26
\\
&n^A = 60\times 26 = 1560\end{aligned}$$

Quindi poichè $n^T - n^T_{RID} > n^A$, in quanto
$52470 - 34848 = 17622 > 1560$, conviene mantenere la ridondanza

Operazione : Registrazione di una ripoduzione con successo {#operazione-registrazione-di-una-ripoduzione-con-successo .unnumbered}
----------------------------------------------------------

*Descrizione:* Al completamento di una riproduzione terminata con
succeso, viene compilata l'anagrafica del neonato, viene aggiornato lo
stato della riproduzione e viene programmata una visita per il nuovo
nato

*Input:* codice della riproduzione avvenuta con successo e dati
appartenenti al neonato (sesso, specie, famiglia, razza, peso, altezza)

*Output:* registrazione del neonato con programmazione di una nuova
visita

*Frequenza giornaliera:* 32[^3]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-1 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="100%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-1 .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  Riproduzione     E         12900       Secondo l'Istat circa il $75\%$
                                         degli animali è femmina, nel
                                         nostro caso
                                         $20000\times0.75=15000$. Di
                                         queste, il $14\%$ non è
                                         destinato all'allevamento,
                                         quindi in un anno il restante
                                         $86\%$ si riproduce
                                         $15000\times 0.86=12900$

  coinvolge        R         12900       Cardinalità (1,1) con
                                         Riproduzione

  Riproduzione     E         12900       Secondo l'Istat circa il $75\%$
                                         degli animali è femmina, nel
                                         nostro caso
                                         $20000\times0.75=15000$. Di
                                         queste, il $14\%$ non è
                                         destinato all'allevamento,
                                         quindi in un anno il restante
                                         $86\%$ si riproduce
                                         $15000\times 0.86=12900$

  Animale          E         20000       Ogni agriturismo ospita 1000
                                         animali $20\times 1000=20000$

  Visita                                 Si suppone che per ogni
                                         agriturismo vengano eseguite
                                         1100 visite all'anno per poter
                                         controllare almeno una volta
                                         tutti gli animali
                                         $1100\times 20= 22000$

  possiede visita                        Cardinalità (1,1) con Visita
  ----------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-1 .unnumbered}

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  Riproduzione                                  Si ricavano i dati
                                                relativi alla
                                                riproduzione, in
                                                particolare viene
                                                letta la data di
                                                nascita

  coinvolge                                     Si ricavano il codice
                                                della madre e del
                                                padre del neonato

  Riproduzione                                  Aggiornamento dello
                                                stato della
                                                riproduzione a
                                                `sucesso` e della
                                                data di completamento

  Animale                                       Registrazione del
                                                nuovo nato con i dati
                                                a disposizione

  Visita                                        Programmazione di una
                                                nuova visita per il
                                                neonato

  possiede                                      Aggiornamento della
  visita                                        relazione tra
                                                l'animale neonato e
                                                la visita programmata

                                                
  -------------------------------------------------------------------

Operazione : Pagamento delle stanze {#operazione-pagamento-delle-stanze .unnumbered}
-----------------------------------

*Descrizione:* Ogni giorno viene registrato il pagamento cumulativo di
ogni cliente per ogni stanza prenotata e per ogni eventuale servizio
aggiuntivo utilizzato

*Input:* la data odierna

*Output:* i pagamenti da effettuare

*Frequenza giornaliera:* 1

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-2 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="110%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-2 .unnumbered}

  -------------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- ----------------------------------
  Prenotazione                           Si stima che mediamente in un anno
  Stanza                                 ogni cliente prenoti una stanza

  assegnazione                           Cardinalità (1,1) con Prenotazione
  stanza                                 Stanza

  stanza associata                       Cardinalità (1,1) con Servizio per
                                         Stanza

  stanza associata                       Cardinalità (1,1) con Servizio per
                                         Stanza

  Servizio per                           Si considera che la metà delle
  Stanza                                 stanze prenotate abbia usufruito
                                         di tre servizi aggiuntivi
                                         $1000\times 0.5 \times 3 = 1500$

  servizio                               Cardinalità (1,1) con Servizio per
  associato                              Stanza

  Servizio                               Ogni agriturismo dispone delle
  Aggiuntivo                             stesse 10 tipologie di servizi
                                         aggiuntivi

  assegnazione                           Cardinalità (1,1) con Prenotazione
  cliente                                Stanza

  Cliente                                Ogni agriturismo ha in media 500
                                         clienti all'anno

  Pagamenti                              Si considera la somma dei
                                         pagamenti per gli ordini sullo
                                         store online, per la prenotazione
                                         delle stanze e delle escursioni
                                         $146000+2\times 10000= 166000$

  effettua                               Cardinalità (1,1) con Pagamenti
  -------------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-2 .unnumbered}

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  Prenotazione                                  Vengono lette tutte
  Stanza                                        le prenotazioni che
                                                scandono in questo
                                                giorno

  assegnazione                                  Si passa dalla
  stanza                                        relazione per
                                                ottenere la stanza
                                                prenotata

  Stanza                                        Si leggono i dati
                                                relativi alla stanza

  stanza                                        Si passa dalla
  associata                                     relazione per
                                                ricavare i servizia
                                                aggiuntivi associati
                                                alla prenotazione

  Servizio per                                  Lettura dei servizi
  Stanza                                        utilizzati assieme
                                                alla prenotazione

  servizio                                      Si passa dalla
  associato                                     relazione per
                                                ricavare le
                                                informazioni sugli
                                                specifici servizi

  Servizio                                      Lettura dei dati
  Aggiuntivo                                    relativi al servizio
                                                utilizzato, ivi
                                                compreso il prezzo

  assegnazione                                  Si passa dalla
  cliente                                       relazione per
                                                ottenere i dati
                                                relativi al cliente

  Cliente                                       Lettura dei dati
                                                relativi al cliente,
                                                ivi compreso il
                                                codice della carta e
                                                se è già stato pagato
                                                un anticipo

  Pagamenti                                     Inserimento di un
                                                nuovo pagamento

  effettua                                      Aggiornamento della
                                                relazione tra il
                                                cliente ed il
                                                pagamento

                                                
  -------------------------------------------------------------------

Operazione : Stoccaggio del latte munto {#operazione-stoccaggio-del-latte-munto .unnumbered}
---------------------------------------

*Descrizione:* Il latte munto viene conservato in appositi silos
contenenti tutti latte con composizione chimico-fisica simile

*Input:* data e ora della mungitura, oltre che il codice del latte munto

*Output:* Aggiornamento della quntità stoccata nel corretto silos

*Frequenza giornaliera:* 15000 [^4]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-3 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="80%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-3 .unnumbered}

  --------------------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -----------------------------------------
  Mungitura        E         5475000     Si suppone che ogni giorno dell'anno ogni
                                         animale femmina di un agriturismo venga
                                         munto una volta
                                         $20000\times 0.75 \times 365 = 5475000$

  Latte            E         400         Ogni agriturismo produce 20 tipologie di
                                         latte differente $20\times 20 = 400$

  Silos            E         200         Sono disponibili circa 10 silos per ogni
                                         agriturismo $10\times 20=200$

  stoccato in      R         400         Cardinalità (1,1) con Latte
  --------------------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-3 .unnumbered}

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  Mungitura                                     Lettura della
                                                quantità di latte
                                                munto

  Latte                                         Lettura delle
                                                quantità di sostanze
                                                disciolte nel latte

  Silos                                         Aggiornamento del
                                                livello presente nel
                                                silos di destinazione

  stoccato in                                   Aggiornamento della
                                                relazione tra il
                                                latte ed il silos nel
                                                quale è stoccato

                                                
  -------------------------------------------------------------------

Operazione : Controllo igiene dei locali {#operazione-controllo-igiene-dei-locali .unnumbered}
----------------------------------------

*Descrizione:* Per garantire il rispetto delle condizioni di benessere
degli animali all'interno dei locali, viene frequentemente controllato
che i parametri rilevati rientrino nelle soglie di tollerabilità, ed
eventualmente viene inviata una richiesta di intervento di pulizia,
insieme all'aggiornamento dei parametri del locale con i valori più
recenti raccolti

*Input:* Il codice del locale da controllare

*Output:* Richiesta d'intervento di pulizia

*Frequenza giornaliera:* 40[^5]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-4 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="100%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-4 .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  rilievo          R         500         Cardinalità (1,1) con Visivi
  parametri visivi                       

  Visivi           E         500         Ogni locale è dotato di un
                                         sensore per i parametri visivi

  rilievo          R         500         Cardinalità (1,1) con rilievo
  parametri                              parametri ambientali
  ambientali                             

  Ambientali       E         500         Ogni locale è dotato di un
                                         sensore per i parametri
                                         ambientali

  rilievo composti R         500         Cardinalità (1,1) con Composti
  volatili                               volatili

  Composti         E         500         Ogni locale è dotato di un
  volatili                               sensore per i composti volatili

  Locale           E         500         Ogni stalla ha in media 5
                                         locali

  Pulizia locale   E         580         Ogni agriturismo effettua due
                                         richieste al giorno, per un
                                         totale di $2\times 365=730$
                                         richieste annue[^6]. Quindi i
                                         20 agriturismi compilano
                                         $730\times 20=14600$ record
                                         all'anno.

  richiesta        R         580         Cardinalità (1,1) con Pulizia
  intervento                             locale
  ----------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-4 .unnumbered}

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  rilievo                                       Si passa dalla
  parametri                                     relazione per
  visivi                                        ottenere i dati dei
                                                sensori visivi

  Visivi                                        Lettura dei dati
                                                rilevati dai sensori
                                                visivi

  rilievo                                       Si passa dalla
  parametri                                     relazione per
  ambientali                                    ottenere i dati dei
                                                sensori ambientali

  Ambientali                                    Lettura dei dati
                                                rilevati dai sensori
                                                ambientali

  rilievo                                       Si passa dalla
  composti                                      relazione per
  volatili                                      ottenere i dati dei
                                                sensori dei composti
                                                volatili

  Composti                                      Lettura dei dati
  volatili                                      rilevati dai sensori
                                                di composti volatili

  Locale                                        Aggiornamento dei
                                                parametri del locale

  Locale                                        Lettura delle soglie
                                                di tollerabilità per
                                                il locale

  Pulizia locale                                Scrittura di una
                                                nuova richiesta
                                                d'intervento di
                                                pulizia

  richiesta                                     Aggiornamento della
  intervento                                    relazione tra il
                                                locale e l'intervento
                                                di pulizia

                                                
  -------------------------------------------------------------------

Operazione : Processamento degli ordini {#operazione-processamento-degli-ordini .unnumbered}
---------------------------------------

*Descrizione:* Gli utenti che si sono registrati nello store online
possono acquistare i prodotti caseari e ricevere il proprio ordine
tramite le spedizioni gestite dal database

*Input:* Il codice del nuovo ordine effettuato dal cliente sullo store
online

*Output:* Processamento ed invio dell'ordine

*Frequenza giornaliera:* 400[^7]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-5 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="115%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-5 .unnumbered}

  -------------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- ----------------------------------
  Ordine Prodotti                        Ogni agriturismo gestisce in media
                                         20 ordini al giorno
                                         $20\times 20\times 365 = 146000$

  contenuto ordine                       Se si suppone che ogni ordine
                                         contenga 20 prodotti al massimo,
                                         si ottiene un numero totale di
                                         record pari a
                                         $20\times146000=2920000$

  Formaggio                              Per far fronte alle richieste
  Prodotto                               della clientela, si decide di
                                         mantenere una produzione
                                         lievemente superiore alle vendite
                                         stimate (circa 80000 prodotti in
                                         più rispetto al volume di
                                         contenuto ordine)

  Ordine Prodotti                        Ogni agriturismo gestisce in media
                                         20 ordini al giorno
                                         $20\times 20\times 365 = 146000$

  esegue ordine                          Cardinalità (1,1) con Ordine
                                         Prodotti

  Account                                Si suppone che il 70% degli utenti
                                         sia registrato, e possegga di
                                         conseguenza un account

  possiede visita                        Cardinalità (1,1) con Visita

  Cliente                                Ogni agriturismo ha in media 500
                                         clienti all'anno

  Pagamenti                              Si considera la somma dei
                                         pagamenti per gli ordini sullo
                                         store online, per la prenotazione
                                         delle stanze e delle escursioni
                                         $146000+2\times 10000= 166000$

  effettua                               Cardinalità (1,1) con Pagamenti

  Spedizione                             Ogni spedizione consegnerà circa
                                         50 ordini collocati per area
                                         geografica simile
                                         ${146000\over 50}=2920$

  consegnato da                          Cardinalità (1,1) con Ordine
                                         Prodotti

  processata da                          Si suppone che ogni spedizione sia
                                         processata da circa 5 centri di
                                         smistamento $2920\times 5=14600$
  -------------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-5 .unnumbered}

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  Ordine                                        Aggiornamento dello
  Prodotti                                      stato dell'odine che
                                                passa a
                                                `in processazione`

  contenuto                                     Si passa dalla
  ordine                                        relazione per
                                                conoscere il
                                                contenuto dell'ordine
                                                oltre che la quantità
                                                dei prodotti
                                                acquistati[^8]

  Formaggio                                     Lettura dei dati
  prodotto                                      relativi al formaggio
                                                acquistato, in
                                                particolare viene
                                                controllato che ve ne
                                                sia rimasto in stock

  Ordine                                        Aggiornamento dello
  Prodotti                                      stato dell'ordine che
                                                passa a
                                                `in preparazione`

  esegue ordine                                 Si passa dalla
                                                relazione per
                                                ottenere i dati
                                                dell'account che ha
                                                effettuato l'ordine

  Account                                       Lettura dei dati
                                                relativi all'account
                                                acquirente

  possiede                                      Si passa dalla
                                                relazione per
                                                ottenere il cliente
                                                associato all'account

  Cliente                                       Lettura dei dati del
                                                cliente che possiede
                                                l'account, in
                                                particolare viene
                                                controllato il codice
                                                della carta

  Pagamenti                                     Scrittura del
                                                pagamento intestato
                                                al cliente

  effettua                                      Aggiornamento della
                                                relazione tra il
                                                cliente ed il
                                                pagamento

  Spedizione                                    Scrittura di una
                                                nuova spedizione con
                                                stato `spedita`

  consegnato da                                 Aggiornamento della
                                                relazione tra la
                                                spedizione e l'ordine
                                                a cui è associata

  Ordine                                        Aggiornamento dello
  Prodotti                                      stato dell'ordine a
                                                `spedito`

  processata da                                 Aggiornamento della
                                                relazione tra
                                                l'ordine ed il centro
                                                di smistamento per
                                                cui attraversa

  Spedizione                                    Aggiornamento dello
                                                stato della
                                                spedizione a
                                                `in consegna`

  Spedizione                                    Aggiornamento dello
                                                stato della
                                                spedizione a
                                                `consegnata`

  Ordine                                        Aggiornamento dello
  Prodotti                                      stato dell'ordine a
                                                `evaso`

                                                
  -------------------------------------------------------------------

Operazione : Prescrizione delle terapie {#operazione-prescrizione-delle-terapie .unnumbered}
---------------------------------------

*Descrizione:* Alla registrazione di una nuova terapia da parte di un
veterinario, viene controllato se questa è la terza consecutiva sullo
stesso animale, nel qual caso viene effettuato un ricollocamento in una
zona di quarantena

*Input:* la nuova terapia e l'animale a cui è assegnata

*Output:* Trasferimanto dell'animale in un nuovo locale di quarantena

*Frequenza giornaliera:* 110[^9]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-6 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="115%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-6 .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  Terapia                                Si suppone che ogni anno
                                         vengano prescritte 2 terapie
                                         per ogni animale
                                         $2\times 20000= 40000$

  abita            R         20000       Cardinalità (1,1) con Animale
  ----------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-6 .unnumbered}

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  Terapia                                       Controllo se l'ultima
                                                terapia che non si è
                                                conclusa è marcata
                                                come la seconda
                                                consecutiva

  abita                                         Ricollocamento del
                                                locale abitato
                                                dall'animale tramite
                                                l'aggiornamento della
                                                relazione con un
                                                locale di quarantena

                                                
  -------------------------------------------------------------------

Operazione : Controllo degli animali dispersi {#operazione-controllo-degli-animali-dispersi .unnumbered}
---------------------------------------------

*Descrizione:* Durante le attività di pascolo viene monitorato ad
intervalli regolari il segnale GPS di ogni singolo animale affinchè ci
si assicuri che rientri negli spazi delimitati dalle recinzioni per le
zone dedicate al pascolo

*Input:* codice dell'attività di pascolo

*Output:* segnalazione se l'animale è disperso

*Frequenza giornaliera:* 3968[^10]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-7 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="115%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-7 .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  attività locale  R         90000       Cardinalità (1,1) con Attività
                                         pascolo

  abita            R         20000       Cardinalità (1,1) con Animale

  localizzato      R         20000       Cardinalità (1,1) con Animale e
                                         con GPS

  GPS              E         20000       Ogni animale è dotato di un
                                         dispositivo GPS

  collocazione     R         90000       Cardinalità (1,1) con Attività
  attività                               pascolo

  divisione        R         180         Cardinalità (1,1) con
  pascolo                                Recinzione divisoria e zona di
                                         pascolo

  Recinzione       E         180         Ogni area di pascolo è divisa
  divisoria e zona                       in 3 recinsioni
  di pascolo                             $60\times 3= 180$
  ----------------------------------------------------------------------

### Tavola degli accessi: {#tavola-degli-accessi-7 .unnumbered}

E' presente la ridondanza *partecipazione attività* tra Attività pascolo
e Animale che influenza la tavola degli accessi

  -------------- ------- -------------- ------- ---------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           

  attività                                      Si passa dalla
  locale                                        relazione per
                                                ottenere il codice
                                                del locale che svolge
                                                l'attività di pascolo

  abita                                         Si passa dalla
                                                relazione per
                                                ottenere i codici
                                                degli animali che
                                                abitano il locale

  localizzato                                   Si passa dalla
                                                relazione per
                                                ottenere il codice
                                                del GPS associato
                                                agli animali

  GPS                                           Lettura delle
                                                coordinate
                                                posizionali dei GPS

  collocazione                                  Si passa dalla
  attività                                      relazione per
                                                ottenere la
                                                collocazione
                                                dell'attività di
                                                pascolo

  divisione                                     Si passa dalla
  pascolo                                       relazione per
                                                ottenere le zone
                                                appartenenti all'area
                                                di pascolo

  Recinzione                                    Lettura della
  divisoria e                                   posizione delle
  zona di                                       recinzioni delle zone
  pascolo                                       di pascolo

                                                
  -------------- ------- -------------- ------- ---------------------

  ----------------- ------- -------------- ------- ---------------------
  **Nome                    **Numero               **Descrizione**
  costrutto**               operazioni             
                            elementari**           

  partecipazioine                                  Si passa dalla
  attività                                         relazione per
                                                   ottenere i codici
                                                   degli animali che
                                                   partecipano
                                                   all'attività

  localizzato                                      Si passa dalla
                                                   relazione per
                                                   ottenere il codice
                                                   del GPS associato
                                                   agli animali

  GPS                                              Lettura delle
                                                   coordinate
                                                   posizionali dei GPS

  collocazione                                     Si passa dalla
  attività                                         relazione per
                                                   ottenere la
                                                   collocazione
                                                   dell'attività di
                                                   pascolo

  divisione pascolo                                Si passa dalla
                                                   relazione per
                                                   ottenere le zone
                                                   appartenenti all'area
                                                   di pascolo

  Recinzione                                       Lettura della
  divisoria e zona                                 posizione delle
  di pascolo                                       recinzioni delle zone
                                                   di pascolo

                                                   
  ----------------- ------- -------------- ------- ---------------------

  ---------------- ------- -------------- ------- ---------------------
  **Nome                   **Numero               **Descrizione**
  costrutto**              operazioni             
                           elementari**           

  attività locale                                 Si passa dalla
                                                  relazione per
                                                  ottenere il codice
                                                  del locale che svolge
                                                  l'attività di pascolo

  abita                                           Si passa dalla
                                                  relazione per
                                                  ottenere i codici
                                                  degli animali che
                                                  abitano il locale

  partecipazione                                  Aggiornamento della
  attività                                        relazione tra
                                                  l'animale e
                                                  l'attività di pascolo
                                                  a cui partecipa

                                                  
  ---------------- ------- -------------- ------- ---------------------

In sintesi: $$\begin{aligned}
&f^T=3968
\\
&o^T = 128
\\
&n^T = 3968\times128= 507904
\\
&o^T_{RID}= 127
\\
&n^T_{RID} = 3968\times 127 = 503936
\\
&f^A= 247
\\
&o^A= 42
\\
&n^A = 247\times 42 = 10374
\\\end{aligned}$$

Quindi poichè $n^T - n^T_{RID} < n^A$, in quanto
$507904 - 503936 = 3968 < 10374$, non conviene mantenere la ridondanza

Operazione : Registrazione nuovo account {#operazione-registrazione-nuovo-account .unnumbered}
----------------------------------------

*Descrizione:* All' inserimento di un nuovo account nello store online,
viene controllato se i dati inseriti corrispondono a quelli di un
cliente già registrato ma senza un account. Nel caso viene aggiunto un
record in Account con i dati forniti durante la registrazione,
altrimenti viene prima registrato il nuovo cliente a partire dal codice
della sua carta

*Input:* anagrafica del cliente, dati dei documenti e informazioni
sull'account da registrare

*Output:* aggiunta di un account e del cliente che lo possiede

*Frequenza giornaliera:* 19 [^11]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-8 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="115%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-8 .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  Cliente                                Ogni agriturismo ha in media
                                         500 clienti all'anno

  Account                                Si suppone che il 70% degli
                                         utenti sia registrato, e
                                         possegga di conseguenza un
                                         account

  possiede                               Cardinalità (1,1) con Scheda
                                         Medica
  ----------------------------------------------------------------------

  -------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- ---------------------
  Cliente                                       Si ricava, se è
                                                presente, il cliente
                                                già registrato con
                                                questo codice di
                                                carta

  Cliente                                       Aggiunta di un record
                                                in Cliente

  Account                                       Aggiunta di un nuovo
                                                account nello store
                                                online

  possiede                                      Aggiornamento della
                                                relazione tra il
                                                cliente e il suo
                                                nuovo account

                                                
  -------------------------------------------------------------------

Operazione : Ridistribuzione degli animali all'aggiunta di un nuovo locale {#operazione-ridistribuzione-degli-animali-allaggiunta-di-un-nuovo-locale .unnumbered}
--------------------------------------------------------------------------

*Descrizione:* All'aggiunta di un nuovo locale, vengono smistati gli
animali già presenti nella stalla affinchè sia mantenuto costante il
numero di animali per locale

*Input:* dati del nuovo locale e codice della stalla a cui appartiene

*Output:* ridistribuzione degli animali nel nuovo locale aggiunto e
registrazione dei nuovi sensori

*Frequenza giornaliera:* 0.27[^12]

### Porzione del diagramma interessata: {#porzione-del-diagramma-interessata-9 .unnumbered}

![image](operazioni/schemi_parziali/operazione-\thecounterAccessi.png){width="115%"}

### Porzione della tavola dei volumi interessata: {#porzione-della-tavola-dei-volumi-interessata-9 .unnumbered}

  ----------------------------------------------------------------------
  **Nome**         **E/R**   **Numero    **Motivazione**
                             Istanze**   
  ---------------- --------- ----------- -------------------------------
  divisione locale R         500         Cardinalità (1,1) con Locale

  abita            R         20000       Cardinalità (1,1) con Animale

  Locale           E         500         Ogni stalla ha in media 5
                                         locali

  Visivi           E         500         Ogni locale è dotato di un
                                         sensore per i parametri visivi

  rilievo          R         500         Cardinalità (1,1) con Visivi
  parametri visivi                       

  Ambientali       E         500         Ogni locale è dotato di un
                                         sensore per i parametri
                                         ambientali

  rilievo          R         500         Cardinalità (1,1) con rilievo
  parametri                              parametri ambientali
  ambientali                             

  Composti         E         500         Ogni locale è dotato di un
  volatili                               sensore per i composti volatili

  rilievo composti R         500         Cardinalità (1,1) con Composti
  volatili                               volatili
  ----------------------------------------------------------------------

  ---------------------------------------------------------------------------
  **Nome                 **Numero               **Descrizione**
  costrutto**            operazioni             
                         elementari**           
  -------------- ------- -------------- ------- -----------------------------
  divisione                                     Si passa dalla relazione per
  locale                                        ricavare i 5 locali in cui
                                                abitano gli animali da
                                                ridistribuire

  abita                                         Si passa dalla relazione per
                                                ottenere gli animali da
                                                ridistribuire

  Locale                                        Registrazione del nuovo
                                                locale

  Visivi                                        Registrazione dei nuovi
                                                sensori visivi per il locale

  rilievo                                       Aggiornamento della relazione
  parametri                                     tra i sensori ed il locale
  visivi                                        

  Ambientali                                    Registrazione dei nuovi
                                                sensori ambientali per il
                                                locale

  rilievo                                       Aggiornamento della relazione
  parametri                                     tra i sensori ed il locale
  ambientali                                    

  Composti                                      Registrazione dei nuovi
  volatili                                      sensori ambientali per il
                                                locale

  rilievo                                       Aggiornamento della relazione
  composti                                      tra i sensori ed il locale
  volatili                                      

  abita                                         Aggiornamento della relazione
                                                per il ricollocamento dei 200
                                                animali tra i 5 locali più
                                                quello appena registrato
                                                $\frac{200}{5+1}\approx 33$

                                                
  ---------------------------------------------------------------------------

Progettazione logica
====================

Schema logico
-------------

-   Animale(, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita,
    altezza, peso, razza, posizione, orario, codiceGps, codLocale)

-   acquistoanimale(, ragioneSocialeFornitore, dataAcquisto, dataArrivo)

-   Fornitore(, indirizzo, partitaIva)

-   Riproduzione(, complicanza, orario, data, stato, codVeterinario,
    codiceMadre, codicePadre)

-   SchedaGestazione(, codRiproduzione, codVeterinario)

-   Agriturismo(, indirizzo, indirizzoWeb, contatto)

-   Stalla(,)

-   Locale(, pavimentazione, capienzaMax, temperatura, umidità,
    orientazioneFinestre, specieOspitata, altezza, lunghezza, larghezza,
    tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano,
    codiceStalle, nomeAgriturismo)

-   Visivi(, livelloSporcizia, orarioRilevazione, codLocale)

-   Ambientali(, temperatura, umidità, orarioRilevazione, codLocale)

-   CompostiVolatili(, concentrazioneMetano, concentrazioneAzoto,
    orarioRilevazione, codLocale)

-   Illuminazione(, consumoEnergetico, codLocale)

-   CondizionatoreAria(, consumoEnergetico, codLocale)

-   PuliziaLocale(, , , stato, personale, concentrazioneMetano,
    concentrazioneAzoto, livelloSporcizia)

-   PastoPerLocale(, , , fibre, proteine, glucidi, concentrazioneSali,
    concentrazioneVitamine)

-   Pasto(,,, ,)

-   Foraggio(, ,, cereali, frutta, piante, forma, kcalkg)

-   Acqua(, ) j

-   Mangiatoia(, quantitàRestante, codLocale)

-   Abberveratoio(, quantitàRestante, codLocale)

-   AttivitàPascolo(, fasciaOraria, codLocale, codArea)

-   AreaPascolo()

-   RecinzioneDivisoriaeZoneDiPascolo(,, posizione)

-   Mungitura(, ,, , quantità)

-   Mungitrice(, posizione, marca, modello)

-   chemunge(, )

-   Latte(, quantitàSostanzeDisciolte, codAnimale, codSilos)

-   Silos(, capacità, livello)

-   prodottocon(, )

-   Lotto(, codDipendenti, dataProd, codLab, durata)

-   stoccaggiocantine(, )

-   stoccaggiomagazzini(, )

-   Cantine()

-   Magazzini()

-   Scaffalature(, )

-   Parametri(, , temperatura, umidità, codCantina)

-   Scaffali(, )

-   ControlloParametriFase(, ,,, )

-   Fasi(, nome, durataFaseEffettiva, temperaturaLatteEffettiva,
    tempoRiposoEffettivo, durata)

-   divisain(, )

-   Ricetta(, collocazioneGeografica, ricetta, durataStagionatura)

-   Formaggio(, , deperibilita, codRicetta)

-   Indicisalute(, , tipologiaRespirazione, lucentezzaPelo, vigilanza,
    idratazione, deambulazione)

-   Visita(, esito, descrizione, dataEffettiva, dataProgrammata,
    codAnimale, codVeterinario)

-   Esame(, descrizione, data, macchinario, nome, codAnimale,
    codVeterinario)

-   Veterinario(, nome, cognome, contatto)

-   Terapia(, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)

-   compostada(, , posologia)

-   Farmaco(, principioAttivo, dosaggio)

-   SchedaMedica(, massaMagra, carenze, patologie, data,
    rispostaOculare, emocromo, spessoreZoccolo, fegato, cuore, pancreas,
    codAnimale, codVeterinario)

-   DisturbiComportamentali(, , )

-   Lesioni(, , , )

-   Cliente(, anticipo)

-   Pagamenti(, tipoPagamento, totaleCosto, data, ora, codCliente)

-   PrenotazioneStanza(,, , ,dataPartenza)

-   Stanza(,, costoGiornaliero, suite, numLetti, tipoLetti)

-   ServizioperStanza(,,,, ,, dataFineUtilizzo)

-   ServizioAggiuntivo(, costo)

-   PrenotazioneEscursione(,,)

-   Escursione(, giorno, orario, codGuida)

-   Guida(, nome, cognome, contatto)

-   legataa(,)

-   Itinerario(, numSentieri, codAgriturismo)

-   compostoda( , )

-   Tappe(, tempoPermanenza)

-   Account(, , domandaRec, rispostaRec, numTelefono, codFiscale,
    scadenzaDoc, numDoc, dataIscrizione, codDoc, cognome, nome,
    enteRilascio, tipoDoc, indirizzo, codiceCarta)

-   Recensione(, gradimentoGenerale, qualitaPercepita, conservazione,
    campoTestuale, gusto, utente, password, codProdotto)

-   FormaggioProdotto(, prezzo, peso, localeAppartenenza,
    rimastiInStock, scadenza, nome, nomeAgriturismo)

-   contenutoordine(, , quantità, reso)

-   OrdineProdotti(, stato, data, tipoConsegnaReso, utente, password,
    codSpedizione)

-   Spedizione(, dataConsegnaEffettiva, dataConsegnaPrevista, percorso,
    stato)

-   processatada(, )

-   CentridiSmistamento(, nome, indirizzo, contatto)

Vincoli d'integrità
-------------------

### Vincoli di integrità referenziale

-   Esiste un vincolo di integrità referenziale tra l'attributo codice
    in Animale e l'attributo codiceAnimale in acquistoanimale

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in Locale e codLocale in Animale

-   Esiste un vincolo di integrità referenziale tra l'attributo
    ragioneSociale in Fornitore e l'attributo ragioneSocialeFornitore in
    acquistoanimale

-   Esiste un vincolo di integrità referenziale tra l'attributo codice
    in Animale e codiceAnimale in coinvolge

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceRiproduzione in Riproduzione e codRiproduzione in coinvolge

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codVeterinario in Riproduzione e codiceFiscale in Veterinario

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codVeterinario in SchedaGestazione e codiceFiscale in Veterinario

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codRiproduzione in SchedaGestazione e codiceRiproduzione in
    Riproduzione

-   Esiste un vincolo di integrità referenziale tra l'attributo nome in
    Agriturismo e nomeAgriturismo in Stalla

-   Esiste un vincolo di integrità referenziale tra l'attributo nome in
    Agriturismo e nomeAgriturismo in Locale

-   Esiste un vincolo di integrità referenziale tra l'attributo
    numeroProgressivo in Stalla e numProgressivo in Locale

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in locale e codLocale in Ambientali

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in locale e codLocale in Composti Volatili

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in locale e codLocale in Visivi

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in locale e codLocale in Illuminazione

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in locale e codLocale in CondizionatoreAria

-   Esiste un vincolo di integrità referenziale tra l'attributo
    codiceLocale in locale e codLocale in PuliziaLocale

-   Esiste un vincolo di integrità referenziale tra gli attributi fibre,
    proteine, glucidi in PastoPerLocale con fibre, proteine, glucidi in
    Foraggio

-   Esiste un vincolo di integrità referenziale tra codLocale in
    PastoPerLocale e codiceLocale in Locale

-   Esiste un vincolo di integrità referenziale tra concentrazioneSali e
    concentrazioneVitamine in PastoPerLocale e concentrazioneSali e
    concentrazioneVitamine in Acqua

-   Esiste un vincolo di integrità referenziale tra gli attributi fibre,
    proteine, glucidi in Pasto con fibre, proteine, glucidi in Foraggio

-   Esiste un vincolo di integrità referenziale tra concentrazioneSali e
    concentrazioneVitamine in Pasto e concentrazioneSali e
    concentrazioneVitamine in Acqua

-   Esiste un vincolo di integrità referenziale tra codLocale in
    Mangiatoia e codiceLocale in Locale

-   Esiste un vincolo di integrità referenziale tra codLocale in
    Abbeveratoio e codiceLocale in Locale

-   Esiste un vincolo di integrità referenziale tra codLocale in
    AttivitàPascolo e codiceLocale in Locale

-   Esiste un vincolo di integrità referenziale tra codArea in
    AttivitàPascolo e codiceArea in AreaPascolo

-   Esiste un vincolo di integrità referenziale tra codArea in
    RecinzioneDivisoriaeZoneDiPascolo e codiceArea in AreaPascolo

-   Esiste un vincolo di integrità referenziale tra codAnimale in
    Mungitura e codice in Animale

-   Esiste un vincolo di integrità referenziale tra codMungitrice in
    Mungitura e codice in Mungitrice

-   Esiste un vincolo di integrità referenziale tra codLatte in chemunge
    e codiceLatte in Latte

-   Esiste un vincolo di integrità referenziale tra codMungitrice in
    chemunge e codice in mungitrice

-   Esiste un vincolo di integrità referenziale tra codAnimale in Latte
    e codice in Animale

-   Esiste un vincolo di integrità referenziale tra codSilos in Latte e
    codice in Silos

-   Esiste un vincolo di integrità referenziale tra codLatte in
    prodottocon e codiceLatte in Latte

-   Esiste un vincolo di integrità referenziale tra codLotto in
    prodottocon e codiceLotto in Lotto

-   Esiste un vincolo di integrità referenziale tra codLotto in
    stoccaggiocantine con codiceLotto in Lotto

-   Esiste un vincolo di integrità referenziale tra codCantina in
    stoccaggiocantine e codice in Cantine

-   Esiste un vincolo di integrità referenziale tra codLotto in
    stoccaggiomagazzini e codiceLotto in Lotto

-   Esiste un vincolo di integrità referenziale tra codMagazzino in
    stoccaggiomagazzini e codice in Magazzini

-   Esiste un vincolo di integrità referenziale tra codCantina in
    Scaffalature e codice in Cantine

-   Esiste un vincolo di integrità referenziale tra codCantina in
    Parametri e codice in Cantine

-   Esiste un vincolo di integrità referenziale tra codMagazzieno in
    Scaffali e codice in Magazzini

-   Esiste un vincolo di integrità referenziale tra codLotto in
    ControlloParametriFase e codiceLotto in Lotto

-   Esiste un vincolo di integrità referenziale tra codFase in
    ControlloParametriFase e codiceFase in Fasi

-   Esiste un vincolo di integrità referenziale tra codRicetta in
    divisain e codiceRicetta in Ricetta

-   Esiste un vincolo di integrità referenziale tra codFase in divisain
    e codiceFase in Fasi

-   Esiste un vincolo di integrità referenziale tra nomeAgriturismo in
    Formaggio e nome in Agriturismo

-   Esiste un vincolo di integrità referenziale tra codRicetta in
    Formaggio e codiceRicetta in Ricetta

-   Esiste un vincolo di integrità referenziale tra codAnimale in
    Indicisalute e codice in Animale

-   Esiste un vincolo di integrità referenziale tra codAnimale in Visita
    con codice in Animale

-   Esiste un vincolo di integrità referenziale tra codVeterinario in
    Visita e codiceVeterinario in Veterinario

-   Esiste un vincolo di integrità referenziale tra codAnimale in Esame
    e codice in Animale

-   Esiste un vincolo di integrità referenziale tra codVeterinario in
    Esame e codiceVeterinario in Veterinario

-   Esiste un vincolo di integrità referenziale tra codAnimale in
    Terapia e codice in Animale

-   Esiste un vincolo di integrità referenziale tra codTerapia in
    compostada e codiceTerapia in Terapia

-   Esiste un vincolo di integrità referenziale tra nomeFarmaco in
    compostada e nome in Farmaco

-   Esiste un vincolo di integrità referenziale tra codAnimale in
    SchedaMedica e codice in Animale

-   Esiste un vincolo di integrità referenziale tra codVeterinario in
    SchedaMedica e codiceVeterinario in Veterinario

-   Esiste un vincolo di integrità referenziale tra codScheda in
    DisturbiComportamentali e codiceScheda in SchedaMedica

-   Esiste un vincolo di integrità referenziale tra codScheda in Lesioni
    e codiceScheda in SchedaMedica

-   Esiste un vincolo di integrità referenziale tra codCliente in
    Pagamenti e codCarta in Cliente

-   Esiste un vincolo di integrità referenziale tra codCliente in
    PrenotazioneStanza e codCarta in Cliente

-   Esiste un vincolo di integrità referenziale tra numStanza in
    PrenotazioneStanza e numStanza in Stanza

-   Esiste un vincolo di integrità referenziale tra codAgriturismo in
    Stanza e nome in Agriturismo

-   Esiste un vincolo di integrità referenziale tra codStanza in
    ServizioperStanza e numStanza in Stanza

-   Esiste un vincolo di integrità referenziale tra codServizio in
    ServizioperStanza e tipoServizio in ServizioAggiuntivo

-   Esiste un vincolo di integrità referenziale tra codEscursione in
    PrenotazioneEscursione e codice in Escursione

-   Esiste un vincolo di integrità referenziale tra codGuida in
    Escursione e codfisc in Guida

-   Esiste un vincolo di integrità referenziale tra codEscursione in
    legataa e codice in Escursione

-   Esiste un vincolo di integrità referenziale tra codItinerario in
    legataa e codice in Itinerario

-   Esiste un vincolo di integrità referenziale tra codAgriturismo in
    legataa e nome in Agriturismo

-   Esiste un vincolo di integrità referenziale tra codItinerario in
    compostoda e codice in Itinerario

-   Esiste un vincolo di integrità referenziale tra nome in Agriturismo
    e codice in Itinerario

-   Esiste un vincolo di integrità referenziale tra nomeTappa in
    compostoda e nome in Tappa

-   Esiste un vincolo di integrità referenziale tra codCarta in Cliente
    e codiceCarta in Account

-   Esiste un vincolo di integrità referenziale tra utente e password in
    Recensione e utente e password in Account

-   Esiste un vincolo di integrità referenziale tra codiceProdotto in
    FormaggioProdotto e codProdotto in Recensione

-   Esiste un vincolo di integrità referenziale tra nome in
    FormaggioProdotto e nome in Formaggio

-   Esiste un vincolo di integrità referenziale tra nome in Agriturismo
    e nomeAgriturismo in FormaggioProdotto

-   Esiste un vincolo di integrità referenziale tra codOrdine in
    contenutoordine e codiceOrdine in OrdineProdotti

-   Esiste un vincolo di integrità referenziale tra codFormaggioProdotto
    in contenutoordine e codiceProdotto in FormaggioProdotto

-   Esiste un vincolo di integrità referenziale tra utente e password in
    Account ed utente e password in OrdineProdotti

-   Esiste un vincolo di integrità referenziale tra codSpedizione in
    OrdineProdotti e codice in Spedizione

-   Esiste un vincolo di integrità referenziale tra codSpedizione in
    processatada e codice in Spedizione

-   Esiste un vincolo di integrità referenziale tra codCentro in
    processata da e codice in CentridiSmistamento

### Vincoli di integrità generici

-   Esiste un vincolo di integrità che lega il codice di un animale al
    codice della madre e del padre (idMadre,idPadre)

-   Esiste un vincolo di integrità che lega l'attributo data in
    diproduzione con l'attributo dataDiNascita in Animale

-   Esiste un vincolo di integrità che lega l'attributo codicePadre in
    coinvolge con l'attributo codice in Animale

-   Esiste un vincolo di integrità che lega gli attributi temperatura e
    umidità in Locale con temperatura e umidità in Ambientali

-   Esiste un vincolo di integrità che lega gli attributi fibre proteine
    glucidi in Foraggio e kcal/kg in Foraggio

-   Esiste un vincolo di integrità che lega gli attributi dataInizio
    durata e secondaTerapiaConsecutiva in Terapia

-   Esiste un vincolo di integrità che lega dataProd e durata in Lotto e
    deperibilità in Formaggio a scadenza in Formaggio Prodotto

-   Esiste un vincolo di integrità che lega dataPartenza in
    PrenotazioneStanza a data in Pagamenti

-   Esiste un vincolo di integrità che lega anticipo in cliente, a
    tipoPagamento e a totaleCosto in Pagamenti.

-   Esiste un vincolo tra quantità in contenutoordine, rimastiinstock in
    FormaggioProdotto e stato in OrdineProdotti

-   Esiste un vincolo di integrità tra reso in contenutoordine e stato e
    tipoConsegnaReso in Ordine Prodotti

-   Esiste un vincolo di integrità tra stato in Spedizione e stato in
    OrdineProdotti

-   Esiste un vincolo di integrità sul codiceGPS degli animali affinché
    sia sempre il minore disponibile

-   Esiste un vincolo di integrità che lega il codiceAnimale in una
    mungitura con il codice di un animale femmina in Animale

Normalizzazione
---------------

In questo capitolo viene affrontata la normalizzazione delle tabelle
ricavate, al fine di raggiungere uno schema logico composto solamente da
tabelle in Forma normale di Boyce-Codd.

1.  **Tabella Animale:**

    Animale(, sesso, specie, famiglia, idMadre, idPadre, dataDiNascita,
    altezza, peso, razza, posizione, orario, codiceGps, codLocale)

    -   codice $\Rightarrow$ sesso, specie, famiglia, idMadre, idPadre,
        dataDiNascita, altezza, peso, razza, posizione, orario,
        codiceGps, codLocale

    Poichè la parte sinistra è superchiave, Animale è in BCNF

2.  **Tabella acquistoanimale:**

    acquistoanimale(, ragioneSocialeFornitore, dataAcquisto, dataArrivo)

    -   codiceAnimale $\Rightarrow$ dataAcquisto, dataArrivo,
        ragioneSocialeFornitore

    Poichè la parte sinistra è superchiave, acquistoanimale è in BCNF

3.  **Tabella Fornitore:**

    Fornitore(, indirizzo, partitaIva)

    -   ragioneSociale $\Rightarrow$ indirizzo, partitaIva

    -   partitaIva $\Rightarrow$ ragioneSociale, indirizzo

    Poichè la parte sinistra è superchiave, Fornitore è in BCNF[^13]

4.  **Tabella Riproduzione:**

    Riproduzione(, complicanza, orario, data, stato, codVeterinario,
    codiceMadre, codicePadre)

    -   codiceRiproduzione $\Rightarrow$ complicanza, orario, data,
        stato, codVeterinario, codiceMadre, codicePadre

    Poichè la parte sinistra è superchiave, Riproduzione è in BCNF

5.  **Tabella SchedaGestazione:**

    SchedaGestazione(, codRiproduzione, codVeterinario)

    -   codiceGestazione $\Rightarrow$ codRiproduzione, codVeterinario

    Poichè la parte sinistra è superchiave, SchedaGestazione è in BCNF

6.  **Tabella Agriturismo:**

    Agriturismo(, indirizzo, indirizzoWeb, contatto)

    -   Nome $\Rightarrow$ indirizzo, indirizzoWeb, contatto

    Poichè la parte sinistra è superchiave, Agriturismo è in BCNF

7.  **Tabella Stalla:**

    Stalla(,)

    Poichè non esistono dipendenze funzionali, Stalla è in BCNF

8.  **Tabella Locale:**

    Locale(, pavimentazione, capienzaMax, temperatura, umidità,
    orientazioneFinestre, specieOspitata, altezza, lunghezza, larghezza,
    tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano,
    codiceStalla, nomeAgriturismo)

    -   codiceLocale $\Rightarrow$ pavimentazione, capienzaMax,
        temperatura, umidità, orientazioneFinestre, specieOspitata,
        altezza, lunghezza, larghezza, tollerabilitaAzoto,
        tollerabilitaSporcizia, tollerabilitaMetano, numProgressivo,
        codiceStalla, nomeAgriturismo

    -   altezza, lunghezza, larghezza, specieOspitata $\Rightarrow$
        capienzaMax

    -   specieOspitata $\Rightarrow$ pavimentazione

    Poichè sono presenti dipendenze funzionali non banali, è necessario
    dividere la relazione in due tabelle. Seguendo l'algoritmo di
    decomposizione senza perdite, otteniamo due tabelle in BCNF così
    formate:

    -   Locale(, temperatura, umidità, orientazioneFinestre,
        tollerabilitaAzoto, tollerabilitaSporcizia, tollerabilitaMetano,
        codiceStalla, nomeAgriturismo, specieOspitata, altezza,
        lunghezza, larghezza)

    -   CaratteristichePerTipoLocale(, , , , capienzaMax,
        pavimentazione)

9.  **Tabella Visivi:**

    Visivi(, livelloSporcizia, orarioRilevazione, codLocale)

    -   codiceVisivo $\Rightarrow$ livelloSporcizia, orarioRilevazione,
        codLocale

    Poichè la parte sinistra è superchiave, Visivi è in BCNF

10. **Tabella Ambientali:**

    Ambientali(, temperatura, umidità, orarioRilevazione, codLocale)

    -   codiceAmbientale $\Rightarrow$ temperatura, unidità,
        orarioRilevazione, codLocale

    Poichè la parte sinistra è superchiave, Ambientali è in BCNF

11. **Tabella CompostiVolatili:**

    CompostiVolatili(, concentrazioneMetano, concentrazioneAzoto,
    orarioRilevazione, codLocale)

    -   codiceVolatili $\Rightarrow$ concentrazioneMetano,
        concentrazioneAzoto, orarioRilevazione, codLocale

    Poichè la parte sinistra è superchiave, CompostiVolatili è in BCNF

12. **Tabella Illuminazione:**

    CompostiVolatili(, consumoEnergetico, codLocale)

    -   codice $\Rightarrow$ consumoEnergetico, codLocale

    Poichè la parte sinistra è superchiave, Illuminazione è in BCNF

13. **Tabella CondizionatoreAria:**

    CompostiVolatili(, consumoEnergetico, codLocale)

    -   codice $\Rightarrow$ consumoEnergetico, codLocale

    Poichè la parte sinistra è superchiave, CondizionatoreAria è in BCNF

14. **Tabella PuliziaLocale:**

    PuliziaLocale(, , , stato, personale, concentrazioneMetano,
    concentrazioneAzoto, livelloSporcizia)

    -   codLocale, orarioRilevazione, dataRilevazione $\Rightarrow$
        stato, personale, concentrazioneMetano, concentrazioneAzoto,
        livelloSporcizia

    Poichè la parte sinistra è superchiave, PuliziaLocale è in BCNF

15. **Tabella PastoPerLocale:**

    PastoPerLocale(, , , fibre, proteine, glucidi, concentrazioneSali,
    concentrazioneVitamine)

    -   giorno, orario, codLocale $\Rightarrow$ fibre, proteine,
        glucidi, concentrazioneSali, concentrazioneVitamine

    Poichè la parte sinistra è superchiave, PastoPerLocale è in BCNF

16. **Tabella Pasto:**

    Pasto(,,, ,)

    Poichè non esistono dipendenze funzionali, Pasto è in BCNF

17. **Tabella Foraggio:**

    Foraggio(, ,, cereali, frutta, piante, forma, kcalkg)

    -   fibre, proteine, glucidi $\Rightarrow$ cereali, frutta, piante,
        forma, kcalkg

    Poichè la parte sinistra è superchiave, Foraggio è in BCNF

18. **Tabella Acqua:**

    Acqua(, )

    Poichè non esistono dipendenze funzionali, Acqua è in BCNF

19. **Tabella Mangiatoia:**

    Mangiatoia(, quantitàRestante, codLocale)

    -   codice $\Rightarrow$ quantitàRestante, codLocale

    Poichè la parte sinistra è superchiave, Mangiatoia è in BCNF

20. **Tabella Abberveratoio:**

    Abberveratoio(, quantitàRestante, codLocale)

    -   codice $\Rightarrow$ quantitàRestante, codLocale

    Poichè la parte sinistra è superchiave, Abberveratoio è in BCNF

21. **Tabella Attivit:**

    AttivitàPascolo(, fasciaOraria, codLocale, codArea)

    -   codiceAttività $\Rightarrow$ fasciaOraria, codLocale, codArea

    Poichè la parte sinistra è superchiave, Pascolo è in BCNF

22. **Tabella AreaPascolo:**

    AreaPascolo()

    Poichè non esistono dipendenze funzionali, AreaPascolo è in BCNF

23. **Tabella RecinsioneDivisoriaeZoneDiPascolo:**

    RecinsioneDivisoriaeZoneDiPascolo(,, posizione)

    -   codiceZona, codArea $\Rightarrow$ posizione

    Poichè la parte sinistra è superchiave,
    RecinsioneDivisoriaeZoneDiPascolo è in BCNF

24. **Tabella Mungitura:**

    Mungitura(, ,, , quantità)

    -   codAnimale, codMungitrice, data, ora $\Rightarrow$ quantità

    Poichè la parte sinistra è superchiave, Mungitura è in BCNF

25. **Tabella Mungitrice:**

    Mungitrice(, posizione, marca, modello)

    -   codice $\Rightarrow$ posizione, marca, modello

    Poichè la parte sinistra è superchiave, Mungitrice è in BCNF

26. **Tabella Chemunge:**

    Chemunge(, )

    Poichè non esistono dipendenze funzionali, Chemunge è in BCNF

27. **Tabella Latte:**

    Latte(, quantitàSostanzeDisciolte, codAnimale, codSilos)

    -   codiceLatte $\Rightarrow$ quantitàSostanzeDisciolte, codAnimale,
        codSilos

    Poichè la parte sinistra è superchiave, Latte è in BCNF

28. **Tabella Silos:**

    Silos(, capacità, livello)

    -   codice $\Rightarrow$ capacità, livello

    Poichè la parte sinistra è superchiave, Silos è in BCNF

29. **Tabella prodottocon:**

    prodottocon(, )

    Poichè non esistono dipendenze funzionali, prodottocon è in BCNF

30. **Tabella Lotto:**

    Lotto(, codDipendenti, dataProd, codLab, durata)

    -   codiceLotto $\Rightarrow$ codDipendenti, dataProd, codLab,
        durata

    Poichè la parte sinistra è superchiave, Lotto è in BCNF

31. **Tabella stoccaggiocantine:**

    stoccaggiocantine(, )

    Poichè non esistono dipendenze funzionali, stoccaggiocantine è in
    BCNF

32. **Tabella stoccaggiomagazzini:**

    stoccaggiomagazzini(, )

    Poichè non esistono dipendenze funzionali, stoccaggiomagazzini è in
    BCNF

33. **Tabella Cantine:**

    Cantine()

    Poichè non esistono dipendenze funzionali, Cantine è in BCNF

34. **Tabella Magazzini:**

    Magazzini()

    Poichè non esistono dipendenze funzionali, Magazzini è in BCNF

35. **Tabella Scaffalature:**

    Scaffalature(, )

    Poichè non esistono dipendenze funzionali, Scaffalature è in BCNF

36. **Tabella Parametri:**

    Parametri(, , temperatura, umidità, codCantina)

    -   data, idSensore $\Rightarrow$ temperatura, umidità, codCantina

    Poichè la parte sinistra è superchiave, Parametri è in BCNF

37. **Tabella Scaffali:**

    Scaffali(, )

    Poichè non esistono dipendenze funzionali, Scaffali è in BCNF

38. **Tabella ControlloParametriFase:**

    ControlloParametriFase(, ,,, )

    Poichè non esistono dipendenze funzionali, ControlloParametriFase è
    in BCNF

39. **Tabella Fasi:**

    Fasi(, nome, durataFaseIdeale, temperaturaLatteIdeale,
    tempoRiposoIdeale, durata)

    -   codiceFase $\Rightarrow$ nome, durataFaseIdeale,
        temperaturaLatteIdeale, tempoRiposoIdeale, durata

    Poichè la parte sinistra è superchiave, Fasi è in BCNF

40. **Tabella divisain:**

    divisain(, )

    Poichè non esistono dipendenze funzionali, divisain è in BCNF

41. **Tabella Ricetta:**

    Ricetta(, collocazioneGeografica, ricetta, durataStagionatura)

    -   codiceRicetta $\Rightarrow$ collocazioneGeografica, ricetta,
        durataStagionatura

    Poichè la parte sinistra è superchiave, Ricetta è in BCNF

42. **Tabella Formaggio:**

    Formaggio(, , deperibilita, codRicetta)

    -   nome, nomeAgriturismo $\Rightarrow$ deperibilità, codRicetta

    Poichè la parte sinistra è superchiave, Formaggio è in BCNF

43. **Tabella Indicisalute:**

    Indicisalute(, , tipologiaRespirazione, lucentezzaPelo, vigilanza,
    idratazione, deambulazione)

    -   codiceAnimale, dataRilevazione $\Rightarrow$
        tipologiaRespirazione, lucentezzaPelo, vigilanza, idratazione,
        deambulazione

    Poichè la parte sinistra è superchiave, Indicisalute è in BCNF

44. **Tabella Visita:**

    Visita(, esito, descrizione, dataEffettiva, dataProgrammata,
    codAnimale, codVeterinario)

    -   codiceVisita $\Rightarrow$ esito, descrizione, dataEffettiva,
        dataProgrammata, codAnimale, codVeterinario

    Poichè la parte sinistra è superchiave, Visita è in BCNF

45. **Tabella Esame:**

    Esame(, descrizione, data, macchinario, nome, codAnimale,
    codVeterinario)

    -   codiceEsame $\Rightarrow$ descrizione, data, macchinario, nome,
        codAnimale, codVeterinario

    Poichè la parte sinistra è superchiave, Esame è in BCNF

46. **Tabella Veterinario:**

    Veterinario(, nome, cognome, contatto)

    -   codFiscale $\Rightarrow$ nome, cognome, contatto

    Poichè la parte sinistra è superchiave, Veterinario è in BCNF

47. **Tabella Terapia:**

    Terapia(, dataInizio, durata, secondaTerapiaConsecutiva, codAnimale)

    -   codiceTerapia $\Rightarrow$ dataInizio, durata,
        secondaTerapiaConsecutiva, codAnimale

    Poichè la parte sinistra è superchiave, Terapia è in BCNF

48. **Tabella compostada:**

    compostada(, , posologia)

    -   codTerapia, nomeFarmaco $\Rightarrow$ posologia

    Poichè la parte sinistra è superchiave, compostada è in BCNF

49. **Tabella Farmaco:**

    Farmaco(, principioAttivo, dosaggio)

    -   nome $\Rightarrow$ pricipioAttivo, dosaggio

    Poichè la parte sinistra è superchiave, Farmaco è in BCNF

50. **Tabella SchedaMedica:**

    SchedaMedica(, massaMagra, carenze, patologie, data,
    rispostaOculare, emocromo, spessoreZoccolo, fegato, cuore, pancreas,
    codAnimale, codVeterinario)

    -   codiceScheda $\Rightarrow$ massaMagram carenzem patologie, data,
        rispostaOculare, emocromo, spessoreZoccolo, fegato, cuore,
        pancreas, codAnimale, codVeterinario

    Poichè la parte sinistra è superchiave, SchedaMedica è in BCNF

51. **Tabella DisturbiComportamentali:**

    DisturbiComportamentali(, , )

    Poichè non esistono dipendenze funzionali, DisturbiComportamentali è
    in BCNF

52. **Tabella Lesioni:**

    Lesioni(, , , )

    Poichè non esistono dipendenze funzionali, Lesioni è in BCNF

53. **Tabella Cliente:**

    Cliente(, anticipo)

    -   codCarta $\Rightarrow$ anticipo

    Poichè la parte sinistra è superchiave, Cliente è in BCNF

54. **Tabella Pagamenti:**

    Pagamenti(, tipoPagamento, totaleCosto, data, ora, codCliente)

    -   codPagamento $\Rightarrow$ tipoPagamento, totaleCosto, data,
        ora, codCliente

    Poichè la parte sinistra è superchiave, Pagamenti è in BCNF

55. **Tabella PrenotazioneStanza:**

    PrenotazioneStanza(, , , , dataPartenza )

    -   dataArrivo, codCliente, numStanza, nomeAgriturismo $\Rightarrow$
        dataPartenza

    Poichè la parte sinistra è superchiave, PrenotazioneStanza è in BCNF

56. **Tabella Stanza:**

    Stanza(, , costoGiornaliero, suite, numLetti, tipoLetti )

    -   numStanza, codAgriturismo $\Rightarrow$ costoGiornaliero, suite,
        numLetti, tipoLetti

    Poichè la parte sinistra è superchiave, Stanza è in BCNF

57. **Tabella ServizioperStanza:**

    ServizioperStanza(, , , , , , dataFineUtilizzo)

    -   dataInizioUtilizzo, dataArrivo, codCliente, numStanza,
        nomeAgriturismo, codServizio $\Rightarrow$ dataFineUtilizzo

    Poichè la parte sinistra è superchiave, ServizioperStanza è in BCNF

58. **Tabella ServizioAggiuntivo:**

    ServizioAggiuntivo(, costo)

    -   tipoServizio $\Rightarrow$ costo

    Poichè la parte sinistra è superchiave, ServizioAggiuntivo è in BCNF

59. **Tabella PrenotazioneEscursione:**

    PrenotazioneEscursione(, , )

    Poichè non esistono dipendenze funzionali, PrenotazioneEscursione è
    in BCNF

60. **Tabella Escursione:**

    Escursione(, giorno, orario, codGuida)

    -   codice $\Rightarrow$ giorno, orario, codGuida

    Poichè la parte sinistra è superchiave, Escursione è in BCNF

61. **Tabella Guida:**

    Guida(, nome, cognome, contatto)

    -   codfisc $\Rightarrow$ nome, cognome, contatto

    Poichè la parte sinistra è superchiave, Guida è in BCNF

62. **Tabella legataa:**

    legataa(,)

    Poichè non esistono dipendenze funzionali, legataa è in BCNF

63. **Tabella legataa:**

    Itinerario(, numSentieri, codAgriturismo)

    -   codice $\Rightarrow$ numSentieri, codAgriturismo

    Poichè la parte sinistra è superchiave, Itinerario è in BCNF

64. **Tabella compostoda:**

    compostoda(, )

    Poichè non esistono dipendenze funzionali, compostoda è in BCNF

65. **Tabella Tappe:**

    Tappe(, tempoPermanenza)

    -   nome $\Rightarrow$ tempoPermanenza

    Poichè la parte sinistra è superchiave, Tappe è in BCNF

66. **Tabella Account:**

    Account(, , domandaRec, rispostaRec, numTelefono, codFiscale,
    scadenzaDoc, numDoc, dataIscrizione, codDoc, cognome, nome,
    enteRilascio, tipoDoc, indirizzo, codiceCarta)

    -   utente, password $\Rightarrow$ damandaRec, rispostaRec,
        numTelefono, codFiscale, scadenzaDoc, numDoc, dataIscrizione,
        codDoc, cognome, nome, enteRilascio, tipoDoc, indirizzo,
        codiceCarta

    Poichè la parte sinistra è superchiave, Account è in BCNF

67. **Tabella Recensione:**

    Recensione(, gradimentoGenerale, qualitaPercepita, conservazione,
    campoTestuale, gusto, utente, password, codProdotto)

    -   codiceRecensione $\Rightarrow$ gradimentoGenerale,
        qualitàPercepita, conservazione, campoTestuale, gusto, utente,
        password, codProdotto

    Poichè la parte sinistra è superchiave, Recensione è in BCNF

68. **Tabella FormaggioProdotto:**

    FormaggioProdotto(, prezzo, peso, lottoAppartenenza, rimastiInStock,
    scadenza, nome, nomeAgriturismo)

    -   codiceProdotto $\Rightarrow$ prezzo, peso, lottoAppartenenza,
        rimastiInStock, scadenza, nome, nomeAgriturismo

    Poichè la parte sinistra è superchiave, FormaggioProdotto è in BCNF

69. **Tabella contenutoordine:**

    contenutoordine(, , quantità, reso)

    -   codOrdine, codFormaggioprodotto $\Rightarrow$ quantità, reso

    Poichè la parte sinistra è superchiave, contenutoordine è in BCNF

70. **Tabella OrdineProdotti:**

    OrdineProdotti(, stato, data, tipoConsegnaReso, utente, password,
    codSpedizione)

    -   codiceOrdine $\Rightarrow$ stato, data, tipoConsegnaReso,
        utente, passsword, codSpedizione

    Poichè la parte sinistra è superchiave, OrdineProdotti è in BCNF

71. **Tabella Spedizione:**

    Spedizione(, dataConsegnaEffettiva, dataConsegnaPrevista, percorso,
    stato)

    -   codice $\Rightarrow$ dataConsegnaEffettiva,
        dataConsegnaPrevista, percorso, stato

    Poichè la parte sinistra è superchiave, Spedizione è in BCNF

72. **Tabella processatada:**

    processatada(, )

    Poichè non esistono dipendenze funzionali, processatada è in BCNF

73. **Tabella CentridiSmistamento:**

    CentridiSmistamento(, nome, indirizzo, contatto)

    -   codice $\Rightarrow$ nome, indirizzo, contatto

    Poichè la parte sinistra è superchiave, CentridiSmistamento è in
    BCNF

Implementazione MySQL
=====================

Nota sugli attributi:

-   Per sfruttare i tipi di dato offerti dall'architettura mySQL, si è
    deciso di trasformare tutte le istanze di data e orario in un unico
    attributo data\_orario di tipo TIMESTAMP. Inoltre tutte le
    occorrenze di data sono state opportunamente ridenominate, affinchè
    non ci siano conflitti con la keyword omonima.

-   Tutti gli attributi che riguardano una posizione geografica sono
    stati trasformati in due attributi latitudine e longitudine di tipo
    float.

Data Analytics
--------------

Sono state sviluppate quattro funzionalità di data analytic capaci di
aggregare ed evidenziare dati salienti per il corretto ed efficiente uso
del database per la gestione delle imprese legate alla catena di
agriturismi *FarmHouse 4.0*\

AN\_salute\_gruppi: 

:   La funzione sfrutta le informazioni dei GPS per selezionare i capi
    di bestiame in gruppi di vicinanza (i gruppi contengono animali
    vicini entro un certo range e vengono formati in modo procedurale
    attraverso l'utilizzo di un cursore e scorrendo gli animali
    precedentemente ordinati per latitudine crescente attraverso un
    rank). Così facendo si ricavano gli indici di salute medi di ogni
    gruppo tramite gli indici di salute associati. La funzione permette
    di verificare fenomeni di emarginamento o vicinanza tra animali di
    costituzione fisica differente. Con sufficienti dati è possibile far
    emergere pattern ricorrenti, soprattutto in fase di pascolo, utili
    per prevenire il diffondersi di eventuali patologie, e per
    confrontare lo stato di salute di animali che pascolano in precise
    zone geografiche, in modo da poter eventualmente spostare le aree di
    pascolo nelle zone più frequentate così da garantire un minore stato
    di stress fisico agli animali..

AN\_tracciabilità\_filiera: 

:   La funzione analizza i singoli prodotti venduti sullo store online
    costruendo una view in cui sono affiancati ad ognuno di essi un
    resoconto dei parametri di processo, la recensione media da parte
    dei clienti, oltre che l'informazione se il il prodotto è stato reso
    oppure no. Da ciò attraverso una tabella pivot si evidenziano quali
    caratteristiche del processo produttivo hanno un maggiore impatto
    sulla qualità percepita del prodotto. La funzione esprime inoltre la
    probabilità con cui il prodotto verrà reso in base a ciascuno dei
    parametri di produzione.

AN\_controllo\_vendite: 

:   La funzione effettua un rank delle tipologie di formaggio vendute
    sullo store in funzione delle vendite e degli incassi generati,
    tenendo conto anche degli eventuali resi. Inoltre affianca ad ognuno
    di essi la valutazione media da parte dei clienti che hanno
    recensito il prodotto, così da evidenziare i formaggi di tendenza, o
    al contrario, quelli ben apprezzati seppur poco conosciuti. Questo
    permette, tra l'altro, di proporre con maggior fiducia i prodotti
    che hanno generato minor guadagno.

AN\_controllo\_qualità\_del\_processo: 

:   La funzione stila un rank dei singoli lotti della produzione in base
    all'attinenza di questi ultimi con i parametri ideali di produzione
    e all'omogeneità delle componenti utilizzate, dalla composizione
    chimico-fisica del latte agli sbalzi di salute degli animali, in
    funzione anche dell'apporto alimentare dei pasti somministrati.
    Questi dati vengono poi visualizzati attraverso una tabella pivot
    per garantire una visione più immediata dell'andamento della qualità
    del prodotto conseguentemente ai vari parametri.

[^1]: In questo modo, ognuno dei 25 locali viene pulito
    ${730\over 25}=29$ volte l'anno

[^2]: In ogni locale viene cambiato pasto 24 volte all'anno(circa ogni 2
    settimane) per un totale di $24\times 500 = 12000$ cambiamenti
    annui.Dunque la frequenza giornaliera è di
    $\frac{12000}{365}\approx 33$

[^3]: Il numero delle riproduzioni con successo in un anno è 11610. Ogni
    giorno ne vengono effettuate $\frac{11610}{365}\approx 32$

[^4]: Le mungiture annuali sono 5475000. Ogni giorno ne vengono eseguite
    $\frac{5475000}{365}=15000$

[^5]: Ognuno dei 20 agriturismi richiede 2 interventi di pulizia al
    giorno

[^6]: In questo modo, ognuno dei 25 locali viene pulito
    ${730\over 25}=29$ volte l'anno

[^7]: Ogni agriturismo gestisce circa 20 ordini al giorno:
    $20\times 20= 400$

[^8]: Per ipotesi, ogni ordine è composto da 20 prodotti

[^9]: 40000 terapie in un anno corrispondono a circa
    $\frac{40000}{365}\approx 110$ nuove terapie ogni giorno

[^10]: Viene eseguito un controllo ogni 15 minuti durante le 8 ore
    dell'attività, quindi 32 controlli per ognuna delle
    $\frac{90000}{365}\approx 247$ attività giornaliere. Allora vengono
    eseguiti $247\times 32 = 7904$ controlli

[^11]: I 7000 accounts vengono registrati nel corso di un anno:
    $\frac{7000}{365}\approx 19$

[^12]: Si stima che in un anno vengano aggiunti 100 nuovi locali, che
    corrispondono per un agriturismo ad un nuovo locale per ognuna della
    5 stalle: $\frac{100}{365}\approx 0.27$

[^13]: Infatti anche partitaIva, pur non essendo chiave primaria, è pur
    sempre una superchiave, in quanto non esistono due istanze diverse
    di Fornitore che abbiano lo stesso valore di partitaIva
