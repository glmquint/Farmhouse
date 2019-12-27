$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Registrazione nuovo account***
$$\noindent\textit{Descrizione:} All' inserimento di un nuovo account nello store online, viene controllato se i dati inseriti corrispondono a quelli di un cliente già registrato ma senza un account. Nel caso viene aggiunto un record in Account con i dati forniti durante la registrazione, altrimenti viene prima registrato il nuovo cliente a partire dal codice della sua carta
$$\noindent\textit{Input:} anagrafica del cliente, dati dei documenti e informazioni sull'account da registrare
$$\noindent\textit{Output:} aggiunta di un account e del cliente che lo possiede
$$\noindent\textit{Frequenza giornaliera:} 19 \footnote{I 7000 accounts vengono registrati nel corso di un anno: $\frac{7000}{365}\approx 19$}

$$\subsubsection*{Porzione del diagramma interessata:}
$$
$$\includegraphics[scale=2, width=1.15\textwidth]{operazioni/schemi_parziali/operazione-\thecounterAccessi.png} 
$$
$$\subsubsection*{Porzione della tavola dei volumi interessata:}
$$
$$\begin{center}\setlength{\extrarowheight}{1.5pt}\begin{longtable}{|p{0.23\linewidth}|p{0.1\linewidth}|p{0.11\linewidth}|p{0.45\linewidth}|}
$$
$$\hline \textbf{Nome}   & \begin{center}\vspace{-15pt}\textbf{E/R}\end{center} & \textbf{Numero Istanze} & \textbf{Motivazione}\\ 
$$
$$\hline
$$
$$\end{longtable}\end{center}

[
>!Cliente!E!1!L!Si ricava, se è presente, il cliente già registrato con questo codice di carta
>!Cliente!E!1!S!Aggiunta di un record in Cliente
>!Account!E!1!S!Aggiunta di un nuovo account nello store online
>!possiede!R!1!S!Aggiornamento della relazione tra il cliente e il suo nuovo account
>!?4lTotale!7
]

$$\stepcounter{counterAccessi}
***Operazione \thecounterAccessi{}: Ridistribuzione degli animali all'aggiunta di un nuovo locale***
$$\noindent\textit{Descrizione:} All'aggiunta di un nuovo locale, vengono smistati gli animali già presenti nella stalla affinchè sia mantenuto costante il numero di animali per locale
$$\noindent\textit{Input:} dati del nuovo locale e codice della stalla a cui appartiene
$$\noindent\textit{Output:} ridistribuzione degli animali nel nuovo locale aggiunto e registrazione dei nuovi sensori
$$\noindent\textit{Frequenza giornaliera:} 0.27\footnote{Si stima che in un anno vengano aggiunti 100 nuovi locali, che corrispondono per un agriturismo ad un nuovo locale per ognuna della 5 stalle: $\frac{100}{365}\approx 0.27$}

$$\subsubsection*{Porzione del diagramma interessata:}
$$
$$\includegraphics[scale=2, width=1.15\textwidth]{operazioni/schemi_parziali/operazione-\thecounterAccessi.png} 
$$
$$\subsubsection*{Porzione della tavola dei volumi interessata:}
$$
$$\begin{center}\setlength{\extrarowheight}{1.5pt}\begin{longtable}{|p{0.23\linewidth}|p{0.1\linewidth}|p{0.11\linewidth}|p{0.45\linewidth}|}
$$
$$\hline \textbf{Nome}   & \begin{center}\vspace{-15pt}\textbf{E/R}\end{center} & \textbf{Numero Istanze} & \textbf{Motivazione}\\ 
$$
$$\hline
$$
$$\end{longtable}\end{center}

[
>!divisione locali!R!5!L!Si passa dalla relazione per ricavare i 5 locali in cui abitano gli animali da ridistribuire
>!abita!R!200!L!Si passa dalla relazione per ottenere gli animali da ridistribuire
>!Locale!E!1!S!Registrazione del nuovo locale
>!Visivi!E!2!S!Registrazione dei nuovi sensori visivi per il locale
>!rilievo parametri visivi!R!2!S!Aggiornamento della relazione tra i sensori ed il locale
>!Ambientali!E!2!S!Registrazione dei nuovi sensori ambientali per il locale
>!rilievo parametri ambientali!R!2!S!Aggiornamento della relazione tra i sensori ed il locale
>!Composti volatili!E!2!S!Registrazione dei nuovi sensori ambientali per il locale
>!rilievo composti volatili!R!2!S!Aggiornamento della relazione tra i sensori ed il locale
>!abita!R!33!S!Aggiornamento della relazione per il ricollocamento dei 200 animali tra i 5 locali più quello appena registrato $\frac{200}{5+1}\approx 33$
>!?4lTotale!297
]
