/**
  @file filebuffer.h
  @author Grayson Gall ( gsgall )
  header for the file buffer functionality
  reads binary and txt files and stores the content in a struct
*/
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#ifndef _FILEBUFFER_H_
#define _FILEBUFFER_H_
/** The default number of elements to be stored in the data field of FileBuffer */
#define DEFAULT_CAPACITY 10
/** A shorthand for talking about a byte. */
typedef unsigned char byte;
/** The factor by which the data array grows when needed */
#define GROWTH_FACTOR 2
/** Representation of a resizable array of bytes, with functions to
    make it easy to read and write the contents of this array to a
    file. */
typedef struct {
  /** Resizable array of bytes stored in this filebuffer. */
  byte *data;
  int numBytes;
  int capacity;
} FileBuffer;

/**
  Dynamically allocates a filebuffer structure with a dynamically allocated data
  array of bytes. Sets initial number of bytle in array to 0 and default
  capacity to 10.
  @return a pointer to the filebuffer structure.
*/
FileBuffer *makeFileBuffer();

/**
  Frees the dynamically allocated memory needed for the buffers
  @param buffer the FileBuffer to be freed
*/
void freeFileBuffer( FileBuffer *buffer );

/**
  Adds a byte to the buffers data field and grows the data field if needed
  @param buffer the buffer to be added to
  @param val the byte to be added
*/
void appendFileBuffer( FileBuffer *buffer, byte val );

/**
  Reads input file and stores the content in the data field of the FileBuffer
  object
*/
FileBuffer *loadFileBuffer( char const *filename );

/**
  Dumps the buffers content into a file
  @param buffer buffer to be emptied
  @param filname the location where the data is to be stored
*/
void saveFileBuffer( FileBuffer *buffer, char const *filename );
#endif
