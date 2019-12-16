$$\newcounter{counterAccessi}

# module

# $$\stepcounter{counterAccessi}
# ***Operazione \thecounterAccessi{}: NomeOperazione***
# $$\noindent\textit{Descrizione:}
# $$\noindent\textit{Input:}
# $$\noindent\textit{Output:}
# $$\noindent\textit{Frequenza giornaliera:}
# 
# [
# >!Nome costrutto!Tipo costrutto!Numero operazioni elementari!Tipo operazione!Descrizione
# ]

# end module

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Controllo qualità del pasto***
$$\noindent\textit{Descrizione:} Viene controllato che il pasto che viene somministrato agli animali non abbia ripercussioni sul loro stato di salute: in particolare vengono controllati gli indici di salute di tutti gli animali appartenenti ai locali nei quali è stato somministrato il pasto in esame
$$\noindent\textit{Input:} codice del pasto da controllare e giorno e orario di somministrazione
$$\noindent\textit{Output:} media degli indici di salute
$$\noindent\textit{Frequenza giornaliera:} 0.066\footnote{Frequenza annuale: 24. Frequenza giornaliera: $\frac{24}{365}=0.066$}
$$E' presente la ridondanza \textit{qualità pasto} tra Pasto per Locale e Indici Salute che influenza la tavola degli accessi

[
>!?5cSenza ridondanza
>!locale assegnato!R!1!L!Si passa dalla relazione per ricavare in quale locale è distribuito il pasto
>!Locale!E!1!L!Si ricavano i dati del locale
>!abita!R!40!L!Si passa dalla relazione per ottenere gli animali che abitano il locale
>!Animale!E!40!L!Si ricavano i dati relativi ai singoli animali
>!stato salute!R!44!L!Si passa dalla relazione per ricavare gli indici di salute degli animali
>!Indici salute!E!44!L!Lettura dei dati relativi alla salute degli animali
>!?4l\textbf{Totale}!\textbf{170}
]

[
>!?5cCon ridondanza
>!qualità pasto!R!44!L!Si ricavano gli indici di salute associati al pasto somministrato
>!Indici salute!E!44!L!Lettura dei dati relativi alla salute degli animali
>!?4l\textbf{Totale}!\textbf{88}
]

[
>!?5cAggiornamento ridondanza (ad ogni nuovo indice di salute)
>!locale assegnato!R!1!L!Si passa dalla relazione per ricavare in quale locale è distribuito il pasto
>!Locale!E!1!L!Si ricavano i dati del locale
>!abita!R!40!L!Si passa dalla relazione per ottenere gli animali che abitano il locale
>!Animale!E!40!L!Si ricavano i dati relativi ai singoli animali
>!stato salute!R!44!L!Si passa dalla relazione per ricavare gli indici di salute degli animali
>!Indici salute!E!44!L!Lettura dei dati relativi alla salute degli animali
>!Indici salute!R!44!S!Aggiornamento della relazione tra il nuovo indice di salute e il pasto precedentenente somministrato
>!?4l\textbf{Totale}!\textbf{258}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Controllo qualità del prodotto***
$$\noindent\textit{Descrizione:} La qualità percepita del prodotto venduto viene regolarmente controllata tramite le recensioni lasciate dai clienti sullo store online. In particolare si evidenzia quanto il feedback degli utenti venga influenzato dal discostamento dei processi produttivi rispetto ai parametri ideali specificati dalle ricette
$$\noindent\textit{Input:} recensione degli utenti su un prodotto
$$\noindent\textit{Output:} differenza tra i parametri ideali di produzione e e quelli effettivamente registrati
$$\noindent\textit{Frequenza giornaliera:} <++>
$$E' presente la ridondanza "controllo qualità" tra Recensione e Controllo Parametri Fase che influisce sulla tavola degli accessi

[
>!?5cSenza ridondanza
>!valuta!R!1!L!Si passa dalla relazione per ricavare il prodotto relativo alla recensione
>!Formaggio Prodotto!E!1!L!Si ricavano le informazioni relative al prdotto valutato
>!appartenente a!R!1!L!Si passa dalla relazione per ottenere il lotto di appartenenza del prodotto
>!Lotto!E!1!L!Si ricavano le informazioni del lotto di produzione
>!controllo lotti!R!10!L!Si passa dalla relazione per ottenere i parametri di produzione del formaggio
>!Controllo Parametri Fase!E!10!L!Si ricavano i dati relativi ai parametri effettivi rilevati durante il controllo delle fasi
>!controllo fasi!R!10!L!Si passa dalla relazione per ottenere i parametri idelai della determinata fase
>!Fasi!E!10!L!Si leggono i parametri di processo della specifica fase della ricetta
>!?4l\textbf{Totale}!\textbf{44}
]

[
>!?5cCon ridondanza
>!controllo qualità!R!10!L!Si passa dalla relazione per ottenere i parametri di produzione relativi al formaggio valutato
>!Controllo Parametri Fase!E!10!L!Si ricavano i dati relativi ai parametri effettivi rilevati durante il controllo delle fasi
>!controllo fasi!R!10!L!Si passa dalla relazione per ottenere i parametri idelai della determinata fase
>!Fasi!E!10!L!Si leggono i parametri di processo della specifica fase della ricetta
>!?4l\textbf{Totale}!\textbf{40}
]

[
>!?5cAggiornamento ridondanza (ad ogni nuova recensione)
>!valuta!R!1!L!Si passa dalla relazione per ricavare il prodotto relativo alla recensione
>!Formaggio Prodotto!E!1!L!Si ricavano le informazioni relative al prdotto valutato
>!appartenente a!R!1!L!Si passa dalla relazione per ottenere il lotto di appartenenza del prodotto
>!Lotto!E!1!L!Si ricavano le informazioni del lotto di produzione
>!controllo lotti!R!10!L!Si passa dalla relazione per ottenere i parametri di produzione del formaggio
>!Controllo Parametri Fase!E!10!L!Si ricavano i dati relativi ai parametri effettivi rilevati durante il controllo delle fasi
>!controllo qualità!R!10!S!Aggiornamento della relazione
>!?4l\textbf{Totale}!\textbf{44}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Registrazione delle riproduzioni***
$$\noindent\textit{Descrizione:} <++>
$$\noindent\textit{Input:} <++>
$$\noindent\textit{Output:} <++>
$$\noindent\textit{Frequenza giornaliera:} <++>

[
>!<++>!<++>!<++>!<++>!<++>
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Pagamento delle stanze***
$$\noindent\textit{Descrizione:} Ogni giorno viene registrato il pagamento cumulativo di ogni cliente per ogni stanza prenotata e per ogni eventuale servizio aggiuntivo utilizzato
$$\noindent\textit{Input:} la data di partenza dei clienti
$$\noindent\textit{Output:} i pagamenti da effettuare
$$\noindent\textit{Frequenza giornaliera:} 1

[
>!Prenotazione Stanza!E!28\footnote{Considerate 10000 prenotazioni annuali: $\frac{10000}{365}=27.4$}!L!Vengono lette tutte le prenotazioni che scandono in questo giorno
>!assegnazione stanza!R!28!L!Si passa dalla relazione per ottenere la stanza prenotata
>!Stanza!E!28!L!Si leggono i dati relativi alla stanza
>!stanza associata!R!42\footnote{Per ipotesi, la metà delle prenotazioni utilizza mediamente 3 servizi: $28\times 1.5=42$}!L!Si passa dalla relazione per ricavare i servizia aggiuntivi associati alla prenotazione
>!Servizio per Stanza!E!42!L!Lettura dei servizi utilizzati assieme alla prenotazione
>!servizio associato!R!42!L!Si passa dalla relazione per ricavare le informazioni sugli specifici servizi
>!Servizio Aggiuntivo!E!42!L!Lettur dei dati relativi al servizio utilizzato, ivi compreso il prezzo
>!assegnazione cliente!R!28!L!Si passa dalla relazione per ottenere i dati relativi al cliente
>!Cliente!E!28!E!Lettura dei dati relativi al cliente, ivi compreso il codice della carta e se è già stato pagato un anticipo
>!Pagamenti!E!28!S!Inserimento di un nuovo pagamento
>!effettua!28!R!S!Aggiornamento della relazione tra il cliente ed il pagamento
>!?4l\textbf{Totale}!\textbf{420}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Stoccaggio del latte munto***
$$\noindent\textit{Descrizione:} Il latte munto viene conservato in appositi silos contenenti tutti latte con composizione chimico-fisica simile
$$\noindent\textit{Input:} data e ora della mungitura, oltre che il codice del latte munto
$$\noindent\textit{Output:} Aggiornamento della quntità stoccata nel corretto silos
$$\noindent\textit{Frequenza giornaliera:} (<Volume Mungitura>/365)

[
>!Mungitura!E!1!L!Lettura della quantità di latte munta
>!Latte!E!1!L!Lettura delle quantità di sostanze disciolte nel latte
>!Silos!E!1!S!Aggiornamento del livello presente nel silos di destinazione
>!stoccato in!R!1!S!Aggiornamento della relazione tra il latte ed il silos nel quale è stoccato
>!?4l\textbf{Totale}!\textbf{6}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Controllo igiene dei locali***
$$\noindent\textit{Descrizione:} Per garantire il rispetto delle condizioni di benessere degli animali all'interno dei locali, viene frequentemente controllato che i parametri rilevati rientrino nelle soglie di tollerabilità, ed eventualmente viene inviata una richiesta di intervento di pulizia
$$\noindent\textit{Input:} Il locale da controllare
$$\noindent\textit{Output:} Richiesta d'intervento di pulizia
$$\noindent\textit{Frequenza giornaliera:} 40\footnote{Ognuno dei 20 agriturismi richiede 2 interventi di pulizia al giorno}

[
>!rilievo parametri visivi!R!2!L!Si passa dalla relazione per ottenere i dati dei sensori visivi
>!Visivi!E!2!L!Lettura dei dati rilevati dai sensori visivi
>!rilievo parametri ambientali!R!2!L!Si passa dalla relazione per ottenere i dati dei sensori ambientali
>!Ambientali!E!2!L!Lettura dei dati rilevati dai sensori ambientali
>!rilievo composti volatili!R!2!L!Si passa dalla relazione per ottenere i dati dei sensori dei composti volatili
>!Composti volatili!E!2!L!Lettura dei dati rilevati dai sensori di composti volatili
>!Locale!E!1!S!Aggiornamento dei parametri del locale
>!Locale!E!1!L!Lettura delle soglie di tollerabilità per il locale
>!Pulizia locale!E!1!S!Scrittura di una nuova richiesta d'intervento di pulizia
>!richiesta intervento!R!1!S!Aggiornamento della relazione tra il locale e l'intervento di pulizia
>!?4l\textbf{Totale}!\textbf{21}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Processamento degli ordini***
$$\noindent\textit{Descrizione:} Gli utenti che si sono registrati nello store online possono acquistare i prodotti caseari e ricevere il proprio ordine tramite le spedizioni gestite dal database
$$\noindent\textit{Input:} Il nuovo ordine effettuato dal cliente sullo store online
$$\noindent\textit{Output:} Processamento ed invio dell'ordine
$$\noindent\textit{Frequenza giornaliera:} 400\footnote{Ogni agriturismo gestisce circa 20 ordini al giorno: $20\times 20= 400$}

[
>!Ordine Prodotti!E!1!S!Aggiornamento dello stato dell'odine che passa a \texttt{in processazione}
>!contenuto ordine!R!20!L!Si passa dalla relazione per conoscere il contenuto dell'ordine oltre che la quantità dei prodotti acquistati
>!Formaggio prodotto!E!20!L!Lettura dei dati relativi al formaggio acquistato, in particolare viene controllato che ve ne sia rimasto in stock
>!Ordine Prodotti!E!1!S!Aggiornamento dello stato dell'ordine che passa a \texttt{in preparazione}
>!esegue ordine!R!1!L!Si passa dalla relazione per ottenere i dati dell'account che ha effettuato l'ordine
>!Account!E!1!L!Lettura dei dati relativi all'account acquirente
>!possiede!R!1!L!Si passa dalla relazione per ottenere il cliente associato all'account
>!Cliente!E!1!L!Lettura dei dati del cliente che possiede l'account, in particolare viene controllato il codice della carta
>!Pagamenti!E!1!S!Scrittura del pagamento intestato al cliente
>!effettua!R!1!S!Aggiornamento della relazione tra il cliente ed il pagamento
>!Spedizione!E!1!S!Scrittura di una nuova spedizione con stato \texttt{spedita}
>!Ordine Prodotti!E!1!S!Aggiornamento dello stato dell'ordine a \texttt{spedito}
>!processata da!R!x\footnote{<Volume processata da>/<Volume Spedizioni>}!S!Aggiornamento della relazione tra l'ordine ed il centro di smistamento per cui attraversa
>!Spedizione!E!1!S!Aggiornamento dello stato della spedizione a \texttt{in consegna}
>!Spedizione!E!1!S!Aggiornamento dello stato della spedizione a \texttt{consegnata}
>!Ordine Prodotti!E!1!S!Aggiornamento dello stato dell'ordine a \texttt{evaso}
>!?4l\textbf{Totale}!\textbf{62+2x}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Prescrizione delle terapie***
$$\noindent\textit{Descrizione:} Alla registrazione di una nuova terapia da parte di un veterinario, viene controllato se questa è la terza consecutiva sullo stesso animale, nel qual caso viene effettuato un ricollocamento in una zona di quarantena
$$\noindent\textit{Input:} la nuova terapia e l'animale a cui è assegnata
$$\noindent\textit{Output:} Trasferimanto dell'animale in un nuovo locale di quarantena
$$\noindent\textit{Frequenza giornaliera:} 0.3\footnote{100 terapie in un anno corrispondono a circa una nuova terapia ogni 3 giorni}

[
>!Terapia!E!5\footnote{Stima di quante terapie sono già state assegnate in precedenza a questo animale}!L!Controllo se l'ultima terapia che non si è conclusa è marcata come la seconda consecutiva
>!abita!R!1!S!Ricollocamento del locale abitato dall'animale tramite l'aggiornamento della relazione con un locale di quarantena
>!?4l\textbf{Totale}!\textbf{7}
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Controllo degli animali dispersi***
$$\noindent\textit{Descrizione:} Durante le attività di pascolo viene monitorato ad intervalli regolari il segnale GPS di ogni singolo animale affinchè ci si assicuri che rientri negli spazi delimitati dalle recinzioni per le zone dedicate al pascolo
$$\noindent\textit{Input:} codice del GPS e orario di rilevazione
$$\noindent\textit{Output:} segnalazione se l'animale è disperso
$$\noindent\textit{Frequenza giornaliera:} (<Volume Attività pascolo>/365 * <Volume Animali>/<Volume Locale>)

[
>!<++>!<++>!<++>!<++>!<++>
]

##############################

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Aggiornamento delle recinzioni delle zone di pascolo***
$$\noindent\textit{Descrizione:} Seguendo le abitudini degli animali durante il pascolo, è possibile modificare la posizione delle recinzioni affinchè "seguano" le aree di maggior interesse per gli animali
$$\noindent\textit{Input:} codice dell'attività di pascolo #Da controllare tutti i GPS di tutti gli animali che partecipano a questa attività di pascolo
$$\noindent\textit{Output:} aggiornamento della posizione delle recinzioni rispetto alle aree mediamente più visitate dagli animali
$$\noindent\textit{Frequenza giornaliera:} <Volume Attività pascolo>/365

[
>!<++>!<++>!<++>!<++>!<++>
]
