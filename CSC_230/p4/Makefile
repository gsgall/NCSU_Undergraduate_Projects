# setting default tags and compiler
CC = gcc
CFLAGS = -Wall -std=c99 -g

agency: agency.c database.o input.o

database.o: database.c database.h input.o

input.o: input.h input.c

clean:
	rm -f *.o
	rm -f output.txt
	rm -f stderr.txt
	rm -rf *.dSYM
	rm -f agency
