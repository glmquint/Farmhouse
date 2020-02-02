# Progetto di Base Dati

## *Log dei ragionamenti*

[TOC]

**Definizione:**

> *FarmHouse 4.0* 	 
>
> una grande impresa che si occupa di gestire una rete di agriturismi

## Area Allevamento

Ogni allevamento è gestito con i più alti standard tecnologici

#### Anagraﬁca animali 

Ogni **animale** di un agriturismo è  caratterizzato da :

- un codice
- sesso
- famiglia
- razza
- data di nascita
- altezza
- peso
- dei due genitori:
  - il codice identificativo
- specie:
  - bovino
  - ovino
  - caprino

Ogni animale puo' essere:
- nato nell' agriturismo
  oppure
- acquisito
  - data acquisto

  - data arrivo

  - informazzioni sul fornitore

    - ragione sociale
    - nome
    - partita IVA
    - indirizzo

[Stats]
Secondo l' [ISTAT](http://dati.istat.it/Index.aspx?DataSetCode=DCSP_CONSISTENZE): al 1 Dicembre 2018 è stato rilevato un totale di 
5 949 393 capi bovini
7 215 433 capi ovini
992 177 capi caprini
sul territorio italiano, seguendo un indagine che ha coinvolto circa 9000 aziende agricole. Ne risulta un dato stimato per azienda di circa:
661 capi bovini
801 capi ovini
110 capi caprini

Si sceglie allora di considerare una media di 1500 animali differenti per agriturismo come indice di riferimento per le stime da effettuare d'ora in avanti.

Stimiamo 5 fornitori di bestiame per ogni azienda.

| Concetto         | Tipo | Volume        | Analisi                                                      |
| ---------------- | ---- | ------------- | ------------------------------------------------------------ |
| Animale          | E    | 50*1500=75000 | Ognuno dei 50 agriturismi detiene circa 1500 animali         |
| acquisto animale | R    | 75000         | Si accorpa con l'entità Animale, dunque ne eredita il volume |
| Fornitore        | E    | 10            | Si considerano 3 fornitori per razza più uno di scarto       |

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Anagrafica animali.png)

#### Organizzazione stalle

*FarmHouse:*

- Agriturismi
  - stalle
    - numero progressivo
    - locali
      - codice
      - specie ospitante (**una per locale**)
      - dimensione (larghezza, lunghezza, altezza)
      - punto cardinale orientazione finestre
      - tipologia pavimentazione
      - numero massimo di animali (a seconda della dimensione e della specie)
      - allestimenti (diversi dipendentemente dalla specie)
        - numero mangiatoie
        - tipologia mangiatoie
          - codificata
          - indicatore sensorizzato
          - quantitativo foraggio contenuto (da inviare ad intervalli regolari)
          - tipologia foraggio contenuto (da inviare ad intervalli regolari)
        - tipologia abbeveratoi
          - codificata
          - indicatore sensorizzato
          - quantitativo acqua contenuta (da inviare ad intervalli regolari)
          - tipologia acqua contenuta (da inviare ad intervalli regolari)
            - possibilmente arricchita
        - dispositivi condizionamento aria
        - dispositivi illuminazione

[Stats]
*FarmHouse* gestisce una rete di agriturismi (1-100), in media 50.
Ogni agriturismo è dotato di stalle (1-10), in media 5.
Ogni stalla è suddivisa in locali(può contenere fino a 35,40 capi, [info](http://www.amicabile.net/archivio/man/sfogliamanuale.pdf)), in media 8,7.
Ogni locale prevede un allestimento formato da una combinazione tra mangiatoie, abbeveratoi, condizionatori ed illuminazione (1-4), molto probabilmente presenti tutti insieme, quindi 4.

| Concetto               | Tipo | Volume      | Analisi                                                      |
| ---------------------- | ---- | ----------- | ------------------------------------------------------------ |
| Agriturismo            | E    | 50          | Numero medio di agriturismi                                  |
| divisione stalle       | R    | 250         | Si accorpa con l'entità Stalla                               |
| Stalla                 | E    | 5*50=250    | In media ogni agriturismo è diviso in 5 stalle               |
| divisione locali       | R    | 2000        | Si accorpa con l'entità Locale                               |
| Locale                 | E    | 250*8=2000  | Ogni stalla è divisa in 8 locali per contenere al meglio 40 capi di bestiame |
| divisione allestimenti | R    | 8000        | Si accorpa con l'entità Allestimento                         |
| Allestimento           | E    | 2000*4=8000 | Ogni locale contiene mediamente tutti e 4 gli allestimenti   |
| acqua contenuta        | R    | 2000        | Si accorpa ad un quarto del volume dell'entità Allestimento  |
| Acqua                  | E    | 20          | Statisticamente non si considerano più di 20 qualità d'acqua differenti |
| foraggio contenuto     | R    | 2000        | Si accorpa ad un quarto del volume dell'entità Allestimento  |
| Foraggio               | E    | 20          | Statisticamente non si considerano più di 20 tipi di foraggio differenti |

[Operazioni significative]

| Nome                           | Descrizione                                                  | Input                                        | Output                                                | Frequenza giornaliera     | Tipo di operazione | Numero di operazioni elementari |
| ------------------------------ | ------------------------------------------------------------ | -------------------------------------------- | ----------------------------------------------------- | ------------------------- | ------------------ | ------------------------------- |
| Aggiornamento quantità residue | Aggiornamento delle quantità di acqua e foraggio rimanente rilevate dai sensori degli allestimenti | Dati ricevuti dai sensori degli allestimenti | quantità acqua rimanente, quantità foraggio rimanente | 96 volte (ogni 15 minuti) | S                  | $2\times 96\times 4000=768000$  |

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Organizzazione stalle.png)

#### Alimentazione

> Gli animali nei vari locali sono alimentati *automaticamente*

Ogni *pasto* è caratterizzato da:

- tipologia di foraggio (automaticamente somministrato a specifici orari della giornata)

  - percentuale diversa di componenti

    - piante
    - cereali
    - frutta

  - quantità di fibra (carboidrati strutturali)

  - quantità di proteine

  - quantità di glucidi

  - per ogni chilogrammo

    - chilocalorie di energia (dipendente dalla composizione)

  - conservazione

    - freschi

    oppure

    - conservati (sotto forma di)

      - fieno

      oppure

      - insilato

L' *acqua* contenuta negli abbeveratoi può essere

- arricchita (variabile per giorno) (variabile per stato di salute e benessere degli animali)
  - concentrazione sali disciolti
  - concentrazione vitamine disciolte

[Stats]
3 pasti al giorno 

| Concetto           | Tipo | Volume        | Analisi                                                      |
| ------------------ | ---- | ------------- | ------------------------------------------------------------ |
| Locale             | E    | 250*8=2000    | Ogni stalla è divisa in 8 locali per contenere al meglio 40 capi di bestiame |
| composizione pasto | R    | 2000*20=40000 | Ad ogni Locale possono essere assegnati 20 tipi di foraggio  |
| Foraggio           | E    | 20            | Statisticamente non si considerano più di 20 tipi di foraggio differenti |
| accompagnato da    | R    | 20*20=400     | Le possibili combinazione tra Foraggio ed Acqua              |
| Acqua              | E    | 20            | Statisticamente non si considerano più di 20 qualità d'acqua differenti |

[Operazioni significative]

| Nome                     | Descrizione                                                  | Input                    | Output  | Frequenza giornaliera | Tipo di operazione        | Numero di operazioni elementari |
| ------------------------ | ------------------------------------------------------------ | ------------------------ | ------- | --------------------- | ------------------------- | ------------------------------- |
| Calcolo apporto calorico | Calcola le kcal per kg di foraggio a partire dalle quantità dei macronutrienti | fibre, proteine, glucidi | kcal/kg | 3 volte (ogni 8 ore)  | L,<br />L,<br />L,<br />S | $(5\times3)\times 20=300$       |

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Alimentazione.png)

#### Igiene

> La gestione della pulizia delle stalle è eﬀettuata sia *manualmente* che *meccanicamente*

Ogni *locale* è dotato di:

- soglia di tollerabilità
  - di sporcizia
  - di azoto
  - di metano

- sensori

  - visivi
    - livello di sporcizia rilevati

  oppure

  - di composti volatili
    - concentrazione azoto rilevato
    - concentrazione metano rilevato

Superata la *soglia di tollerabilità* per uno dei valori:

- viene salvato nel DB la condizione del locale

  - orario rilevazione
  - livello sporcizia
  - valore azoto
  - valore metano

- invio richiesta intervento di pulizia

  - stato (`richiesto` oppure `effettuato`)

[Stats]
Ogni locale è dotato di 10 sensori: 2 telecamere, 2 termometri, 2 igrometri, 2 rilevatori di concentrazione dell' azoto e 2 rilevatori di concentrazione del metano.
I parametri di igiene di ogni locale vengono, quindi, calcolati sulla base dei dati ricavati ogni mezz'ora da circa 6 sensori facendo la media della misura di tutti i sensori dello stesso tipo al momento del controllo con la soglia di tollerabilità. 

| Concetto                 | Tipo | Volume        | Analisi                                                      |
| ------------------------ | ---- | ------------- | ------------------------------------------------------------ |
| Locale                   | E    | 250*8=2000    | Ogni stalla è divisa in 8 locali per contenere al meglio 40 capi di bestiame |                                                          |
| rilievo parametri locale | R    | 20000         | Si accorpa con l'entità Sensori                              |
| Sensori                  | E    | 10*2000=20000 | Ogni locale è dotato di 10 sensori                           |

[Operazioni significative]

| Nome                                                         | Descrizione                                                  | Input                                           | Output                                                       | Frequenza giornaliera     | Tipo di operazione                                           | Numero di operazioni elementari                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ----------------------------------------------- | ------------------------------------------------------------ | ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Aggiornamento parametri ambientali di locale                 | Si inseriscono gli attributi dei sensori ambientali e a frequenza costante se ne ricavano le medie e si compilano i parametri del locale | Dati dei sensori ambientali,                    | temperatura, umidità, temperatura (parametri), umidità (parametri), | 48 volte (ogni 30 minuti) | S,<br />S,<br />L,<br />L,<br />S,<br />S,<br />             | $2\times 4000\times 48=384000$(scrittura temperatura)<br />$2\times 4000\times 48=384000​$(scrittura umidità)<br />$2\times 192000=384000​$(lettura temperatura e umidità)<br />$2\times2\times 2000=8000​$(scrittura parametri medi per locale)<br />Totale:$384000+384000+384000+8000=1160000​$ |
| Aggiornamento parametri visivi e volatili e confronto con soglie di tollerabilità | Si inseriscono gli attributi dei sensori visivi e dei composti volatili, se ne ricavano le medie e si confrontano con le soglie di tollerabilità | Dati dei sensori visivi e dei composti volatili | livello sporcizia, concentrazione azoto, concentrazione metano | 48 volte (ogni 30 minuti) | S,<br />S,<br />S,<br />L,<br />L,<br />L,<br />L,<br />L,<br />L, | $2\times2\times 2000\times48=384000$(scrittura livello sporcizia)<br />$2\times2\times 2000\times48=384000$(scrittura concentrazione azoto)<br />$2\times2\times 2000\times48=384000$(scrittura concentrazione metano)<br />$(192000\times 3)+ 3\times 2000 \times 48=864000$(letture dei valori registrati e confronto con le soglie)<br />Totale:$3\times 384000 +864000 =2016000$ |

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Igiene.png)

#### Parametri di locale

Di ogni locale

- parametri (monitorati ad intervalli regolari) (frequenza variabile per locale) (fascia oraria variabile per locale) (invio dei valori al DB ogni volta che avviene il monitoraggio)
  - temperatura
  - umidità

[Stats]
Temperatura e umidità vengono aggiornati nella tabella locale ogni mezz'ora, facendo la media delle letture dei relativi sensori.

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Parametri locale.png)

#### Riproduzione

> La riproduzione degli animali avviene selezionando i capi in modo da ottenere specie sempre *più resistenti* e caratterizzate da un’*elevata qualità del prodotto*

Una *riproduzione* è caratterizzata da

- codice identificativo

  - della madre
  - del padre

- data

- orario

- codice del veterinario che ha supervisionato la riproduzione

- esito

  - `successo`
    - viene creata la *scheda di gestazione* 
    - l' animale appena nato viene registrato 
      - viene inserita la sua anagrafica
      - assieme all' esito di una visita di controllo rappresentato da
        - valori di alcuni o tutti gli *indici di salute*

  oppure

  - `insuccesso` (la gravidanza è stata interrotta)
    - vengono memorizzate le complicanze
    - viene visitato l' animale che ha interrotto la gravidanza e
    - vengono salvati i valori dei suoi *indici di salute*

###### Scheda di gestazione

*Scheda di gestazione* descrive i diversi interventi di controllo decisi dal veterinario responsabile ed eﬀettuati durante la gestazione.

- codice della riproduzione

- codice del veterinario responsabile della gestazione (indipendente dal codice del veterinario che ha supervisionato la riproduzione)

- controlli effettuati, ognuno caratterizzato da

  - data del controllo (può non coincidere con quella programmata)

  - codice del veterinario che l'ha eseguito (può non coincidere con il veterinario responsabile della gestazione)

  - esito

    - `positivo`

    oppure

    - `negativo`
      - il veterinario prescrive esami diagnostici(**vedi Healthcare**), caratterizzati ognuno da
        - codice
        - nome
        - eventuale macchinario necessario 
        - descrizione testuale della procedura
        - data
      - può prescrivere una terapia, caratterizzata da
        - farmaci, ognuno dei quali ha
          - posologia
          - durata
        - integratori, ognuno dei quali ha
          - posologia
          - durata

- interventi di controllo futuro

  - con stato pari a `programmato`

###### Indici di salute

Lo stato di un animale viene rappresentato da un set di valori dei suoi *indici di salute* quali

- livello di vigilanza
- livello di deambulazione
- lucentezza del pelo
- tipologia di respirazione
- livello di idratazione

[Stats]
Le condizioni di fertilità per ogni animale si verificano ogni 16-24 giorni.
La gestazione dura circa 9-10 mesi.
C'è da considerare quante riproduzioni vengono intraprese mediamente in un anno, e da qui considerare la percentuale di successo e insuccesso per determinare le schede di gestazione da compilare e le visite da effettuare.
Secondo l'ISTAT circa il 75% degli animali è femmina, nel nostro caso $75000\times75\%=56250​$. Di queste, il 14% non è destinato all'allevamento($56250\times 14\%=7875​$), quindi in un anno il rimanente 86% si riproduce($48375​$), inoltre il 10% delle riproduzioni è un insuccesso($4838​$).

| Concetto             | Tipo | Volume                       | Analisi                                                      |
| -------------------- | ---- | ---------------------------- | ------------------------------------------------------------ |
| Riproduzione         | E    | $56250-7875=48375$           | In accordo alla precedente descrizione                       |
| supervisiona         | R    | $48375$                      | Non dipende dal volume di Veterinario ma da quello di Riproduzione |
| Veterinario          | E    | $4\times 50=200$             | Ogni agriturismo ha in media 4 veterinari distinti           |
| esegue               | R    | $HealthCare + 48375\times 2$ | Dipende dal volume di Visita                                 |
| Visita               | E    | $HealthCare + 48375\times 2$ | $\text{Ogni riproduzione ammette un massimo di 2 visite, oltre alle eventuali visite determinate dall' area HealthCare}$ |
| scrive               | R    | $48375 \times \frac 9 {10}$  | Dipende dal volume di Schede gestazione                      |
| Scheda gestazione    | E    | $48375 \times \frac 9 {10}$  | Il 90% delle Riproduzioni ha successo                        |
| controlli effettuati | R    | $HealthCare + 48375\times 2$ | Dipende dal volume di Visita                                 |
| determina            | R    | $48375 \times \frac 9 {10}$  | E' pari al volume delle Riproduzioni con successo            |
| coinvolge            | R    | $48375\times 2$              | Ogni riproduzione coinvolge i 2 Animali genitori             |
| Animale              | E    | 50*1500=75000                | Ognuno dei 50 agriturismi detiene circa 1500 animali         |
| stato salute         | R    | $HealthCare + 48375\times 2$ | Dipende dal volume di Indici salute                          |
| Indici salute        | E    | $HealthCare + 48375\times 2$ | Gli indici di salute vengono aggiornati per ogni visita dell'HeathCare più una volta all'inizio della gestazione e una volta alla fine |



![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Riproduzione.png)

#### Pascolo

Ogni *animale*

- posizione dal sensore GPS (costantemente in aggiornamento)
  - dato temporale (da salvare l'orario di rientro in particolare)

Ogni *attività di pascolo*

- zona coinvolta
- fascia oraria
- locale degli animali coinvolti

Ogni *zona per il pascolo*

- posizione delle recinzioni

[Stats]
Ogni agriturismo possiede delle specifiche zone riservate al pascolo, in accordo con le specifiche di progetto, 3.
Queste vengono impiegate per diverse attività di pascolo, 1-2 per ogni locale al giorno, quindi (7-8)*2.
La rilevazione GPS di ogni animale avviene ogni 15 minuti.

| Concetto                               | Tipo | Volume                  | Analisi                                                      |
| -------------------------------------- | ---- | ----------------------- | ------------------------------------------------------------ |
| Locale                                 | E    | 250*8=2000              | Ogni stalla è divisa in 8 locali per contenere al meglio 40 capi di bestiame |
| Attività pascolo                       | R    | $2000\times 250=500000$ | Combinazione tra tutti i Locali e le varie Aree di pascolo   |
| Area pascolo                           | E    | $5*50=250$              | Ogni Agriturismo dispone di 5 Aree di pascolo                |
| divisione pascolo                      | R    | 750                     | Si accorpa alle Zone di pascolo                              |
| Recinsione divisoria e zone di pascolo | E    | $3*250=750$             | Ogni Area di pascolo è divisa in 3 recinzioni                |
| Animale                                | E    | 50*1500=75000           | Ognuno dei 50 agriturismi detiene circa 1500 animali         |
| localizzato                            | R    | 75000                   | Scompare in quanto GPS viene accorpato ad Animale            |
| GPS                                    | E    | 75000                   | Ogni Animale dispone di un GPS                               |

| Nome | Descrizione | Input | Output | Frequenza giornaliera | Tipo di operazione | Numero di operazioni elementari |
| ---- | ----------- | ----- | ------ | --------------------- | ------------------ | ------------------------------- |
|      |             |       |        |                       |                    |                                 |

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Pascolo.png)

## Area Healthcare

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\area healthcare.png)

#### Monitoraggio della salute

#### Terapie

## Area Produzione

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\area_produzione.png)

#### Mungiture e stoccaggio

#### Procedura di produzione

## Area soggiorno

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Area soggiorno.png)

#### Prenotazioni

#### Escursioni

## Area store

#### Accounting

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Accounting.png)

#### Acquisti

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Acquisti.png)

#### Consegne e resi

#### Recensioni

![](D:\Scuola\uni\Base_Dati\Progetto FarmHouse\Recensioni.png)

## Area analytics

#### Comportamento degli animali


#### Controllo qualità di processo

#### Tracciabilità di filiera

#### Analisi delle vendite



# Ristrutturazione generalizzazioni

[OBSOLETE]

Si considera la generalizzazione Animale acquisito con Animale.

Considerando una media di 20000 animali acquisiti sui 75000 totali,

- Accorpando l'entità figlia su quella padre, si ottengono 55000 animali non acquisiti che presentano NULL sui due attributi data arrivo e data acquisto, per un totale di 110000 valori NULL, inoltre i 20000 animali acquisiti presenteranno NULL sugli attributi id madre ed id padre, per un totale di 40000+110000=150000 valori NULL.
- Mantenendo le due entità separate si ha la compilazione di 20000 record in animale acquisito per un totale di 3*20000=60000 attributi da compilare, che apporta 40000 valori NULL sugli attributi id madre ed id padre di Animale, per un totale di 60000+40000=100000 scritture

Se ne conclude che conviene mantenere le due entità separate.