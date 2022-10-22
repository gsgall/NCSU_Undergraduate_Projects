CC = gcc
CFLAGS = -Wall -std=c99 -g

driver: driver.o input.o map.o integer.o text.o

textTest:
	gcc -Wall -std=c99 -g textTest.c text.c vtype.c -o textTest

mapTest: mapTest.c map.c integer.c vtype.c

driver.o: driver.c

input.o: input.c input.h

map.o: map.h map.c vtype.o

integer.o: integer.c integer.h vtype.o

text.o: text.c text.h vtype.o

vtype.o: vtype.c vtype.h

clean:
	rm *.o
	rm stderr.txt
	rm output.txt
