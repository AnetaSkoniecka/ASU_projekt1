# ASU_projekt1
Projekt z przedmiotu ASU, Zadanie 8 - generator plików LATEX.

####################################################################################
#
#	AUTOR:
#	Aneta Skoniecka
#
#	PROJEKT:
#	ASU, Zadanie 8 - tabelki
#
#	OPIS ZADANIA:
#	Skrypt na podstawie pliku wejsciowego tworzy tabelę w języku LATEX.
#	Plik wejściowy (o nazwie input.txt) zawiera informacje o ilosci kolumn i wierwszy,
#	oraz definicje kolejnych wierszy tabeli.
#	Skrypt, w zaleznosci od flag moze dokladach podsumowanie w wierszach i kolumnach,
#	puste naglowki wierszy i kolumn oraz dokonywac transpozycji tabeli.
#
#	WYWOLANIE SKRYPTU:
#	$ perl latex.pl [flags]
#	flagi: -r, -b, -s
#	-r Wystapienie tej flagi powoduje transpozycje tabeli.
#	-b Wystapienie tej flagi powoduje dodanie pustych naglowkow wierszy i kolumn.
#	-s Wystapienie tej flagi powoduje dodanie podsumowania w wierszach i kolumnach.
#	Kazda z flag jest nieobowiazkowa.
#
#	PLIK WEJSCIOWY:
#	W tym samym folderze co wywolywany skrypt nalezy umiescic plik input.txt.
#	1. Pierwsze cztery znaki zawieraja definicje ilosci kolumn i wierszy:
#		Np: 4!3! oznacza, ze tabela zawiera 4 kolumny i 3 wiersze.
#		Znaki "!" oznaczaja definicje ilosci kolumn i wierszy.
#	2. Nastepne znaki sa definicja kolejnych wierszy. Kazdy wiersz konczy sie znakiem "@".
#	3. Kazda komorka konczy sie znakiem ";" z wyjatkiem ostatniej komorki w wierszu, ktora
#		konczy sie znakiem "@".
#
#	WARUNKI:
#	- Ilosc wierszy i kolumn ma byc zgodna ze zdefiniowanymi ilosciami na poczatku pliku input.txt.
#	- W komorkach znajduja sie liczby/cyfry. Ilosc cyfr w komorce nie ma znaczenia.
#
#	PLIK WYJSCIOWY:
#	Efektem skryptu jest utworzenie pliku latex.tex, ktory zawiera gotowy plik latex do konwertowania.
#	Poprawnosc i efektywnosc pliku latex.tex sprawdzono za pomoca programu pdflatex z pakietu MiKTeX.
#
#	PRZYKLAD:
#	Przeslane pliki zawieraja przykladowy plik wejsciowy i odpowiadajacy mu przykladowy efekt koncowy.
#
####################################################################################
