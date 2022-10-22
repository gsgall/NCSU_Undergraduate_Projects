#include "input.h"

char *readLine( FILE *fp )
{
  // initializing the line pointer
  char *line = NULL;
  // checking for user input
  char curr = getc( fp );
  // reading the input line character by character
  int len = 0;
  while( curr != EOF && curr != '\n' ) {
    // special case for first char
    if ( len == 0 ) {
      line = ( char* ) malloc( sizeof( char ) );
    // getting the memory for the next character
    } else {
      line = realloc( line, len + 1 );
    }
    // adding the next character to the string
    line[ len ] = curr;
    curr = getc( fp );
    len++;
  }
  // adding the null terminator to mark the end of the string 
  if ( line ) {
    line = realloc( line, len + 1 );
    line[ len ] = '\0';
  }
  return line;
}
