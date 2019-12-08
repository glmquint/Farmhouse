from sys import *

DEBUG = True

rows = r"""
\hline 
Animale 				& \begin{flushleft}\vspace{-15pt} Anagrafica degli animali di \textit{FarmHouse 4.0} \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codice}
						\item dataNascita
						\item peso
						\item altezza
						\item razza
						\item sesso
						\item specie
						\item famiglia
						\item codLocale*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Mungitura, Latte, Scheda Medica, Animale Acquisito, Terapia, GPS, Indici Salute, Riproduzione \end{flushleft}\\ 
\hline 
Animale Acquisito 	& \begin{flushleft}\vspace{-25pt}Generalizzazio\-ne di Animale \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codAcquisizione}
						\item dataAcquisto
						\item dataArrivo
						\item ragioneFornitore*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Animale, Fornitore \end{flushleft} \\ 
\hline 
Fornitore 			& \begin{flushleft}\vspace{-25pt} Fornitore di capi di bestiame per la rete di agriturismi  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{ragioneSociale}
						\item nome
						\item indirizzo
						\item partitaIVA
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Animale Acquisito \end{flushleft} \\ 
\hline 
Agrituri\-smo 			& \begin{flushleft}\vspace{-25pt} Struttura attrezzata per l'allevamento degli animali e l'accoglienza dei clienti conforme agli standard di \textit{Industry 4.0}  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{nome}
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Cliente, Stanza, Stalla, Formaggio \end{flushleft} \\
\hline
Stalla 				& \begin{flushleft}\vspace{-25pt} Insieme di locali adibiti all'alloggio e alla nutrizione degli animali  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{numProgressivo}
						\item \underline{nomeAgriturismo*}
					\end{itemize} 
					& \begin{flushleft}\vspace{-25pt} Agriturismo, Stalla \end{flushleft} \\
\hline
Locale 				& \begin{flushleft}\vspace{-25pt} Divisione della stalla per specie ospitata e tipo di allestimento  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codice}
						\item pavimentazione
						\item capienzaMax
						\item specieOspitata
						\item orientazioneFinestre
						\item altezza
						\item lunghezza
						\item larghezza
						\item temperatura
						\item umidità
						\item tollerabilitàSporcizia
						\item tollerabilitàAzoto
						\item tollerabilitàMetano
						\item numStalla*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Stalla, Sensori, Pulizia Locale, Allestimento, Attività Pascolo, Animale, Pasto per Locale\end{flushleft} \\
\hline
Pulizia Locale 		& \begin{flushleft}\vspace{-25pt} Richieste d'intervento di pulizia di un locale \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{orarioRilevazione}
						\item \underline{dataRilevazione}
						\item stato
						\item personale
						\item \underline{codLocale*}
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale \end{flushleft}\\
\hline
Sensori 				& \begin{flushleft}\vspace{-25pt} Ge\-ne\-ra\-liz\-za\-zio\-ne dei sensori visivi, ambientali e dei composti volatili del locale  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codice}
						\item orario
						\item tipoSensore
						\item codLocale*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale \end{flushleft}\\
\hline
Visivi 				& \begin{flushleft}\vspace{-25pt} Sensore visivo del livello di sporcizia del locale \end{flushleft} 
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item livelloSporcizia
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale \end{flushleft}\\
\hline
Ambientali 			& \begin{flushleft}\vspace{-25pt} Sensore di temperatura ed umidità del locale  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item temperatura
						\item umidità
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale \end{flushleft}\\
\hline
Composti Volatili 	& \begin{flushleft}\vspace{-25pt} Sensore della concentrazione di azoto e metano nel locale  \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item concentrazioneMetano
						\item concentrazioneAzoto
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale \end{flushleft}\\
\hline
Attività Pascolo 	& \begin{flushleft}\vspace{-25pt} Esercizio di pascolo che coinvolge tutti gli animali di un locale \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codAttività}
						\item fasciaOraria
						\item codLocale*
						\item codArea*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale, Area Pascolo \end{flushleft}\\
\hline
Area Pa\-sco\-lo 		& \begin{flushleft}\vspace{-25pt} Spazio dell'agriturismo destinato al pascolo degli animali \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codiceArea}
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Attività Pascolo, Recinzione Divisoria e Zona Pascolo \end{flushleft}\\
\hline
Allestimen\-to 		& \begin{flushleft}\vspace{-25pt} Mangiatoie, Abbeveratoi, e dispositivi di illuminazione e condizionamento aria di ogni locale \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codice}
						\item codLocale*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale, Acqua, Foraggio \end{flushleft}\\
\hline
Mangiatoia 		& \begin{flushleft}\vspace{-25pt} Dispositivo per la distribuzione del foraggio agli animali nei locali \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item foraggioRestante
						\item fibre*
						\item proteine*
						\item glucidi*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale, Foraggio, Pasto \end{flushleft}\\
\hline
Abbevera\-toio 		& \begin{flushleft}\vspace{-25pt} Dispositivo per la distribuzione dell'acqua agli animali nei locali \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item acquaRestante
						\item codAcqua*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale, Acqua, Pasto \end{flushleft}\\
\hline
Recinzione Divisoria e Zona Pascolo & \begin{flushleft}\vspace{-25pt} Ogni Area di pascolo è divisa in zone recintate dinamicamente \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codiceZona}
						\item posizione
						\item codArea* 
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Area Pascolo \end{flushleft}\\
\hline
Pasto 				& \begin{flushleft}\vspace{-25pt} Alimentazione somministrata automaticamente nelle mangiatoie e negli abbeveratoi di ogni locale \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codicePasto}
						\item codAcqua*
						\item fibre*
						\item proteine*
						\item glucidi*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Pasto per Locale, Acqua, Foraggio, Abbeveratoio, Mangiatoia \end{flushleft}\\
\hline
Pasto per Locale 				& \begin{flushleft}\vspace{-25pt} Pasto specifico che viene somministrato in un locale in una certa data con un certo orario \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item giorno
						\item orario
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Locale, Pasto \end{flushleft}\\
\hline
Acqua 				& \begin{flushleft}\vspace{-25pt} Acqua eventualmente arricchita per l'idratazione degli animali \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codiceAcqua}
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Pasto, Allestimento \end{flushleft}\\
\hline
Arricchita			& \begin{flushleft}\vspace{-25pt} Variante di Acqua arricchita di sali minerali e\\o vitamine \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{concentrazioneSali}
						\item \underline{concentrazioneVitamine}
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Pasto, Allestimento \end{flushleft}\\
\hline
Foraggio 			& \begin{flushleft}\vspace{-25pt} Alimentazione degli animali identificato dai suoi ingredienti vegetali \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{fibre}
						\item \underline{proteine}
						\item \underline{glucidi}
						\item cereali
						\item frutta
						\item piante
						\item kcal/kg
						\item forma (fieno/insilato)
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Pasto, Allestimento \end{flushleft}\\
\hline
Scheda Gestazio\-ne 	& \begin{flushleft}\vspace{-25pt} Descrive i diversi interventi di controllo decisi dal veterinario in fase di gestazione \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codiceGestazione}
						\item interventi\-Controllo\-Programmati
						\item codVeterinario*
						\item codRiproduzione*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Riproduzione, Visita, Veterinario \end{flushleft}\\
\hline
Riproduzio\-ne 		& \begin{flushleft}\vspace{-25pt} Storico dei tentativi di riproduzione effettuati, sia riusciti che non \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codiceRiproduzione}
						\item stato
						\item orario
						\item data
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Animale, Veterinario \end{flushleft}\\
\hline
Successo				& \begin{flushleft}\vspace{-25pt} Riproduzioni andate a buon fine \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item codiceNeonato
						\item esitoVisitaControllo
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Animale, Veterinario, Scheda Gestazione \end{flushleft}\\
\hline
Inuccesso				& \begin{flushleft}\vspace{-25pt} Riproduzioni non andate a buon fine \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item complicanza
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Animale, Veterinario \end{flushleft}\\
\hline
GPS 					& \begin{flushleft}\vspace{-25pt} Dispositivo di localizzazione per ogni animale \end{flushleft}
					& \begin{itemize}
						\setlength{\itemindent}{-1em}
						\vspace{-25pt}
						\setlength\itemsep{-0.25em}
						\item \underline{codiceGPS}
						\item posizione
						\item orario
						\item codAnimale*
					\end{itemize}
					& \begin{flushleft}\vspace{-25pt} Animale \end{flushleft}\\
\hline


"""


#print (rows.split("\hline"))
#for index, r in enumerate(rows.split("\hline")):
	#print (r.split("\t")[0])

list = []
for l in rows.split("\hline"):
    list.append(("\n".join(l.split("\n")[1:])))
    #for line in sorted("".join(l.split("\n")[1:])):
    #    print(line + "++++++++++++")

sorted_list = sorted(list)

if len(argv) > 1:
    output = argv[1]
else:
    output = "sorted_rows.txt"

with open(output, "w") as file:
    count = 0
    for sl in sorted_list:
        line = sl + "\n\hline\n"
        file.write(line)
        count += 1
        if DEBUG:
            print (line)

print ("{} items written in {}".format(count, output))