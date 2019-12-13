#!/usr/bin/python3
from sys import *

# Un semplice script per la creazione di longtables personalizzate in latex
# E' necessaria la modifica manuale delle variabili utilizzate per modificare numero di colonne
# e la relativa formattazione
#
# Quseto è un hack, ed ogni utilizzo al di fuori della notazione consigliata non è stato testato!

#notazione:
#
#   ***YOUR TITLE***
#   #COMMENT
#   [
#   > !ELEMENT!E!{-ENUMERATED ELEMENT-due-tre-quattro}!400#INLINE COMMENT con ! caratteri [ speciali
#   > !{-uno-due-tre-quattro}!{-uno-due-tree-quattro}!{-uno-duue-tre-quattro}!bello
#   > !\textbf{Totale}!?3r9001#INJECTED LATEX & MULTICOLUMN ROW
#   ]

#utilizzo:
#
#   $python3 pseudolatex.py TEXT.txt
#   $./pseudolatex TEXT.txt output.txt DEBUG


# VARIABILI DI FORMATTAZIONE #
column_width = ["0.23","0.1","0.11","0.45"]

prologo_tabella = "\\begin{center}\setlength{\extrarowheight}{1.5pt}\\begin{longtable}{|p{" + column_width[0] + "\linewidth}|p{" + column_width[1] + "\linewidth}|p{" + column_width[2] + "\linewidth}|p{" + column_width[3] + "\linewidth}|}\hline \\textbf{Nome}   & \\begin{center}\\vspace{-15pt}\\textbf{E/R}\end{center} & \\textbf{Numero Istanze} & \\textbf{Motivazione}\\\\ "
prologo_itemize = " \\begin{itemize}\\setlength{\\itemindent}{-1em}\\vspace{-25pt}\\setlength\\itemsep{-0.25em}"
prologo_titolo = "\\subsubsection{"
prologo_multi_col = "\\multicolumn{"

first_multi_col = "}{|"
second_multi_col = "|}{"

epilogo_tabella = "\end{longtable}\end{center}"
epilogo_itemize = "\\end{itemize}"
epilogo_titolo = "}"
epilogo_multi_col = "}"

nuova_riga = "\hline"
fine_riga = "\\\\"

before_content = ["", "\\begin{center}\\vspace{-25pt}", "\\begin{center}\\vspace{-25pt}", "\\begin{flushleft}\\vspace{-25pt}" ]
before_item = "\\item "
after_content = ["", "\end{center}", "\end{center}", "\end{flushleft}"]
after_item = ""

# CODICE #
mio_latex = []
if len(argv) > 1:
    mio_file = argv[1]
else:
    print ("Please specify an input file! Usage:\n./pseudolate.py inputfile.txt [outputfile.txt] [DEBUG]")
    quit()

f = open(mio_file, "r")
if f == 'NULL':
    print ("The file " + mio_file + " cannot be found!")
    quit()
for line in f:
    # Per l'inline commenting:
    # viene considerato solo ciò che sta alla sinistra del primo '#' di ogni riga
    if '#' in line:
        line = line.split('#')[0]

    # Per il titolo di ogni tabella:
    # ciò che è racchiuso dalla sequenza '***' viene considerato come il titolo della tabella
    if '***' in line:
        mio_latex.append(prologo_titolo + line.split('***')[1] + epilogo_titolo)

    # Per l'inizio di una tabella:
    # permette di inserire l'intenstazione definita nel prologo tabella
    if '[' in line:
        mio_latex.append(prologo_tabella)

    # Per l'inizio di una nuova riga
    # le colonne di ogni riga vengono identificate dal separatore '!'
    if '>' in line:
        mio_latex.append(nuova_riga)
        columns = line.split('!')[1:]
        columns[-1] = columns[-1][:-1]
        for c in columns:
            if columns.index(c) != 0:
                mio_latex.append(" & ")
            # Per le liste innerstate in una tabella
            # introduce una nuova lista i cui elementi sono separati da '-'
            if '{' in c:
                items = c.split('-')[1:]
                items[-1] = items[-1][:-1]
                mio_latex.append(prologo_itemize)
                for i in items:
                    mio_latex.append(before_item + i + after_item)
                mio_latex.append(epilogo_itemize)
            # Per le multicolums rows:
            # se una colonna viene introdotta da '?n[l|c|r]' con n nel range [1-9], essa occuperà lo spazio di n colonne
            # ed il suo contenuto sarà allineato (l)eft, (c)enter o (r)ight
            # ATTENZIONE: lo stile delle colonne successive verrà shifto 
            if c[0] == '?':
                mio_latex.append(prologo_multi_col + c[1] + first_multi_col + c[2] + second_multi_col + c[3:] + epilogo_multi_col)
            else:
                mio_latex.append(before_content[columns.index(c)] + c + after_content[columns.index(c)])
        mio_latex.append(fine_riga)

    # Per la fine di una tabella:
    # permette di inserire l'intestazione per la conclusione di una tabella
    if ']' in line:
        mio_latex.append(nuova_riga)
        mio_latex.append(epilogo_tabella)

if len(argv) > 2:
    if argv[2] != "DEBUG":
        output_file = argv[2]
    else:
        print ("The output_file wasn't specified: redirecting output to latex.txt...")
        output_file = "latex.txt"
else:
    print ("The output_file wasn't specified: redirecting output to latex.txt...")
    output_file = "latex.txt"
l = open(output_file, "w")
for line in mio_latex:
    line = line.replace("\t","")
    # Se è presente l'opzione DEBUG verrà printato a video il contenuto di mio_latex 
    if "DEBUG" in argv:
        print(line)
    l.write(line + "\n")

