/**
  @file lexicon.c
  @author Grayson Gall ( gsgall )
  File supports reading and choosing words as well as checking for valid word
  lists and for checking wether or not a word is in a given list
*/
#include "lexicon.h"
#include "io.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>


/** Large prime multiplier used to choose a word pseudo-randomly. */
#define MULTIPLIER 4611686018453
/** The error message that will be dispayed if there is an invalid word in the list */
#define INVALID_LIST_ERROR "Invalid word file\n"
/** Error message that will be displayed if the file is not accessible */
#define INVALID_FILE_ERROR "Can't open word list: filename\n"

/**
  Method will close the file stream currently being read from and will display
  the provided error message. Program will be exited with a status of 1.
  @param stream the file stream that is being read from
  @param errorMessage the error message to be displated when the program is quit
*/
static void errorExit( FILE *stream, char errorMessage[] )
{
  // printign error message
  fprintf( stderr, "%s", errorMessage );
  // closing stream for memory leaks
  fclose( stream );
  // exiting program
  exit( EXIT_FAILURE );
}

/**
  Method will check to see if there are any duplicates in the word list
  @param wordCount the number of words in the list
*/
static void findDuplicates( int wordCount )
{
  for ( int i = 0; i < wordCount; i++ ) {
    for ( int j = 0; j < wordCount; j++ ) {
      // checking for a matching word in the list
      if ( !strcmp( list[ i ], list[ j ] ) && i != j ) {
        fprintf( stderr, INVALID_LIST_ERROR );
        exit( EXIT_FAILURE );
      }
    }
  }
}


void readWords( char const filename[] )
{
  // opening list file
  FILE *stream = fopen( filename, "r" );
  // if invalid file quit program
  if ( stream == NULL ) {
  errorExit( stream, INVALID_FILE_ERROR );
  }
  // array for the current word being read
  char curr[ WORD_LEN + NULL_LEN ];
  int wordCount = 0;
  // only reading lower case letters from file
  while ( fscanf( stream, "%[a-z]\n", curr ) == 1 ) {
    // checking for proper length
    if ( strlen( curr ) != WORD_LEN ) {
      errorExit( stream, INVALID_LIST_ERROR );
    }
    // copying word to list
    strcpy( list[ wordCount ], curr );
    wordCount++;
  }
  // cleaning any invalid input that may be remaining on line
  if ( readLine( stream, curr, 1 ) || wordCount > WORD_LIMIT ) {
    errorExit( stream, INVALID_LIST_ERROR );
  }
  // closing stream and checking for duplicates
  fclose( stream );
  findDuplicates( wordCount );
}

void chooseWord( long seed, char word[] )
{
  // getting the total number of words in the list
  int n = 0;
  while ( list[ n ][ 0 ] != '\0' && n < WORD_LIMIT ) {
    n++;
  }
  // getting seed with provided function
  int idx = ( seed % n ) * MULTIPLIER % n;
  strcpy( word, list[ idx ] );
}

bool inList( char const word[] )
{
  int i = 0;
  // checking for word in the word list 
  while ( list[ i ][ 0 ] != '\0' && i < WORD_LIMIT ) {
    if ( strcmp( list[ i ], word ) == 0 ) {
      return true;
    }
    i++;
  }
  return false;
}
