# setting default tags and compiler 
CC = gcc
CFLAGS = -Wall -std=c99 -g

# compling the main executable
wordle: io.o lexicon.o history.o
# compiling the object for lexicon file
lexicon.o: lexicon.c lexicon.h io.o
# compiling the object for the history file
history.o: history.c history.h
# compiling the obect for the io section
io.o: io.c io.h
# removing all temporary files
clean:
	rm -f *.o
	rm -f output*
	rm -f stderr*
	rm -rf *.dSYM
	rm -f scores.txt
	rm -f wordle
