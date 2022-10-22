# setting the standard rules for the common platform
CC = gcc
CFLAGS = -Wall -std=c99 -g

# rule builds both calc10 and calc25 executables
all: calc10 calc25

# rule links calc.o and number10.o into calc10 executable
calc10: number10.o calc.o
	gcc calc.o number10.o operation.o -o calc10

# rule links calc.o and number25.o into calc25 executable
calc25: number25.o calc.o
	gcc calc.o number25.o operation.o -o calc25

# rule creates the calc.o object
calc.o: calc.c

# rule creates the number10.o object file
number10.o: operation.o number.h number10.c

# rule creates the number25.o object file
number25.o: operation.o number.h number25.c

# rule created the number.o object file
operation.o: operation.c operation.h

# rule for deleting any output files, objects, and executables
clean:
	rm -f *.o
	rm -f *output*
	rm -f calc10 calc25
