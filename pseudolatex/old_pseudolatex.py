from sys import *

prologo_tabella = "\\begin{center}\setlength{\extrarowheight}{1.5pt}\\begin{longtable}{|p{0.23\linewidth}|p{0.1\linewidth}|p{0.11\linewidth}|p{0.45\linewidth}|}\hline \\textbf{Nome}   & \\begin{center}\\vspace{-15pt}\\textbf{E/R}\end{center} & \\textbf{Numero Istanze} & \\textbf{Motivazione}\\\\ "
prologo_itemize = " & \\begin{itemize}\\setlength{\\itemindent}{-1em}\\vspace{-25pt}\\setlength\\itemsep{-0.25em}"
epilogo_tabella = "\end{longtable}\end{center}"
epilogo_itemize = "\\end{itemize}"
nuova_riga = "\hline"

before_content = ["\\begin{center}\\vspace{-25pt}", "\\begin{center}\\vspace{-25pt}", "\\begin{flushleft}\\vspace{-25pt}" ]
before_item = "\\item "
after_content = ["\end{center}", "\end{center}", "\end{flushleft}"]
after_item = ""

mio_file = argv[1]

mio_latex = []
f = open(mio_file, "r")
if f == 'NULL':
    quit()
l = open("latex.txt", "w")
for line in f:
    if '[' in line:
        mio_latex.append(prologo_tabella + '\n')
    if '>' in line:
        mio_latex.append(nuova_riga + '\n')
        terms = line.split('!')
        #print (terms)
        mio_latex.append(terms[1])
        for t in range(len(terms)-2):
            if '{' in terms[t+1]:
                mio_latex.append(prologo_itemize + '\n')
                items = terms[t+1].split('-')
                for i in range(len(items)-3):
                    mio_latex.append(before_item + " " + items[i+2] + " " + after_item)
                mio_latex.append(before_item + items[len(items)-1][:-1] + after_item)
            if '}' in terms[t+1]:
                mio_latex.append(epilogo_itemize + '\n')
            if "{" not in terms[t+2]:
            mio_latex.append( ' & ' + before_content[t] + terms[t+2] + after_content[t])
        mio_latex.append('\\\\' + '\n')
    if ']' in line:
        mio_latex.append('\\hline ' + epilogo_tabella + '\n')
l.writelines(mio_latex)
l.close()
f.close()
