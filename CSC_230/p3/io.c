/**
  @file io.c
  @author Grayson Gall ( gsgall )
  File holds input and output functionality for the wordle game. File supports
  reading a line from a file and chaning the colors for output to output
*/

#include "io.h"

bool readLine( FILE *fp, char str[], int n )
{
  // getting first char
  char curr = getc( fp );
  int i = 0;
  // if no chars are in file
  if ( curr == EOF ) {
    return false;
  }
  // reading all chars in a line
  while( curr != EOL && curr != EOF ) {
    if ( i < n ) {
      str[ i ] = curr;
      i++;
    }
    curr = getc( fp );
  }
  // adding padding to end of string if fewer than n chars are read 
  if ( i < n ) {
    for ( int j = i; j < n; j++ ) {
      str[ i ] = '\0';
    }
  }
  return true;
}

void colorGreen()
{
  printf("\033[32m");
}

void colorYellow()
{
  printf("\033[33m");
}

void colorDefault()
{
  printf("\033[0m");
}
