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

use Scalar::Util qw(looks_like_number);

# handle flags
$isRevert = 0;
$isSummary = 0;
$isBlank = 0;

foreach $flag(@ARGV) {
	if(($flag cmp "-r") == 0) {
		$isRevert = 1;
	}
	if(($flag cmp "-s") == 0) {
		$isSummary = 1;
	}
	if(($flag cmp "-b") == 0) {
		$isBlank = 1;
	}
}

open(DATA, "<input.txt") or die "Couldn't open file file.txt, $!";

$data = <DATA>;
@dataArray = split //, $data;
$index = 0;
$maxIndex = length($data) - 1;

# getting column count
$numStr = "";
while($index <= $maxIndex) {
	$char = @dataArray[$index];

	if (looks_like_number ($char)) {
		$numStr = $numStr . $char;
	} elsif ($char == "!") {
		$columnCount = $numStr + 0;
		$index = $index + 1;
		last;
	} else {
		die "Incorrect columnCount in input.txt";
	}

	$index = $index + 1;
}

# getting row count
$numStr = "";
while($index <= $maxIndex) {
	$char = @dataArray[$index];

	if (looks_like_number ($char)) {
		$numStr = $numStr . $char;
	} elsif ($char == "!") {
		$rowCount = $numStr + 0;
		$index = $index + 1;
		last;
	} else {
		die "Incorrect  rowCount in input.txt";
	}

	$index = $index + 1;
}

# print $columnCount;
# print $rowCount;

# getting all table rows
$rowIndex = 0;	
@rows = qw//;
while($rowIndex + 1 <= $rowCount) {

	@row = qw//;

	# getting all numbers in row
	$columnIndex = 0;
	while($columnIndex + 1 <= $columnCount) {

		# getting number in column
		$numStr = "";
		while($index <= $maxIndex) {
			$char = @dataArray[$index];

			if (looks_like_number ($char)) {
				$numStr = $numStr . $char;
			} elsif ($char == ";" || $char == "@") {
				$num = $numStr + 0;
				$index = $index + 1;
				last;
			} 

			$index = $index + 1;
		}
		push(@row, $num);
		$columnIndex = $columnIndex + 1;
	}

	$rows[$rowIndex] = [ @row ];
	$rowIndex = $rowIndex + 1;
}

close(DATA) || die "Couldn't close file properly";

# print table
# print $rows[0][0];
# print $rows[0][1];
# print $rows[0][2];
# print $rows[0][3];
# print "\n";
# print $rows[1][0];
# print $rows[1][1];
# print $rows[1][2];
# print $rows[1][3];
# print "\n";
# print $rows[2][0];
# print $rows[2][1];
# print $rows[2][2];
# print $rows[2][3];
# print "\n";
# print "\n";

# reverse table
$reverseRowCount = $columnCount;
$reverseColumnCount = $rowCount;

for($column = 0 ; $column < $reverseColumnCount ; $column = $column + 1){
	for($row = 0 ; $row < $reverseRowCount ; $row = $row + 1) {
		$reverseRows[$row][$column] = $rows[$column][$row];
	}
}

# print reverse table
# print $reverseRows[0][0];
# print $reverseRows[0][1];
# print $reverseRows[0][2];
# print "\n";
# print $reverseRows[1][0];
# print $reverseRows[1][1];
# print $reverseRows[1][2];
# print "\n";
# print $reverseRows[2][0];
# print $reverseRows[2][1];
# print $reverseRows[2][2];
# print "\n";
# print $reverseRows[3][0];
# print $reverseRows[3][1];
# print $reverseRows[3][2];
# print "\n";

# set table orientation
if($isRevert) {
	@table = @reverseRows;
	$column = $reverseColumnCount;
	$row = $reverseRowCount;
} else {
	@table = @rows;
	$column = $columnCount;
	$row = $rowCount;
}


# generate latex file
@colSum = qw//;
unlink ("latex.tex");
open(LATEX, ">>latex.tex") or die "Couldn't create file latex.tex, $!";

print LATEX "\\documentclass{article}\n";
print LATEX "\\begin{document}\n";
	print LATEX "\\begin{tabular}{";
	for($i = 0 ; $i < $column ; $i = $i + 1) {
		print LATEX "| c ";
	}
	if($isBlank) {
		print LATEX "| c ";
	}
	if($isSummary) {
		print LATEX "| c ";
	}
	print LATEX "|}\n";
		print LATEX "\\hline\n";

		if($isBlank) {
			for($j = 0 ; $j < $column + 1 ; $j = $j + 1) {
				if($j != 0) {
					print LATEX " & ";
				}
				print LATEX "~";
			}
			if ($isSummary) {
				print LATEX " & ";
				print LATEX "~";
			}
			print LATEX " \\\\ \\hline\n"
		}
		
		for($i = 0 ; $i < $row ; $i = $i + 1) {
			$rowSum = 0;

			if($isBlank) {
				print LATEX "~ & ";
			}

			for($j = 0 ; $j < $column ; $j = $j + 1) {
				$rowSum = $rowSum + $table[$i][$j];
				if($isSummary) {
					$colSum[$j] = $colSum[$j] + $table[$i][$j];
				}
				if($j != 0) {
					print LATEX " & ";
				}
				print LATEX $table[$i][$j];
			}
			if ($isSummary) {
				print LATEX " & ";
				print LATEX $rowSum;
			}
			print LATEX " \\\\ \\hline\n"
		}
		if($isSummary) {

			if($isBlank) {
				print LATEX "~ & ";
			}

			for($j = 0 ; $j < $column ; $j = $j + 1) {
				if($j != 0) {
					print LATEX " & ";
				}
				print LATEX $colSum[$j];
			}
			print LATEX " & ";
			print LATEX "~";
			print LATEX " \\\\ \\hline\n"
		}

	print LATEX "\\end{tabular}\n";
print LATEX "\\end{document}\n";

close(LATEX) || die "Couldn't close file properly";