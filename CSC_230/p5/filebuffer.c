/**
  @file filebuffer.c
  @author Grayson Gall ( gsgall )
  Implementation for the file buffer functionality
  reads binary and txt files and stores the content in a struct
*/
#include "filebuffer.h"


FileBuffer *makeFileBuffer()
{
  FileBuffer *buffer = ( FileBuffer* ) malloc( sizeof( FileBuffer ) );
  buffer->data = ( byte* ) malloc( sizeof( byte ) * DEFAULT_CAPACITY );
  buffer->numBytes = 0;
  buffer->capacity = DEFAULT_CAPACITY;

  return buffer;
}


void freeFileBuffer( FileBuffer *buffer )
{
  // freeing the data field
  free( buffer->data );
  // freeing the rest of the struct
  free( buffer );
}


void appendFileBuffer( FileBuffer *buffer, byte val )
{
  // if data needs to be grown double the size
  if ( buffer->capacity == buffer->numBytes ) {
    buffer->data = ( byte* ) realloc( buffer->data, GROWTH_FACTOR * buffer->capacity * sizeof( byte ) );
    buffer->capacity *= GROWTH_FACTOR;
  }
  // add the next value
  buffer->data[ buffer->numBytes ] = val;
  buffer->numBytes++;
}


FileBuffer *loadFileBuffer( char const *filename )
{
  // opens file in binary mode
  FILE *fp = fopen( filename, "rb" );
  // check for error in opening
  if ( !fp ) {
    perror( filename );
    exit( EXIT_FAILURE );
  }
  // Creating buffer object
  FileBuffer *buffer = makeFileBuffer();
  int success;
  byte curr;
  // reading the characters into the buffer one at a time 
  while ( ( success = fread( &curr, sizeof( byte ), 1, fp ) ) ) {
      appendFileBuffer( buffer, curr );
  }
  // close the file
  fclose( fp );
  return buffer;
}


void saveFileBuffer( FileBuffer *buffer, char const *filename )
{
  // open file to store
  FILE *fp = fopen( filename, "wb" );
  // dump content in binary
  fwrite( buffer->data, sizeof( byte ), buffer->numBytes, fp );
  // close file
  fclose( fp );
}
