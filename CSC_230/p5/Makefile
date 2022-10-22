CC = gcc
CFLAGS = -Wall -std=c99 -g

all: encode decode

encode: encode.o state24.o filebuffer.o

decode: decode.o state24.o filebuffer.o

dumpbits: dumpbits.c

filebuffertest: filebuffertest.c filebuffer.o

state24test: state24test.c state24.o

encode.o: encode.c state24.o filebuffer.o

decode.o: decode.c state24.o filebuffer.o

state24.o: state24.c state24.h filebuffer.o

filebuffer.o: filebuffer.c filebuffer.h

clean:
	rm encode
	rm decode
	rm stderr.txt
	rm stdout.txt
	rm output.txt
	rm output.bin
