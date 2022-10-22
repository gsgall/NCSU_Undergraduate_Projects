/**
  @file history.c
  @author Grayson Gall ( gsgall )
  File contains the implementation for updating, reading and printing the
  history of the users wordle games
*/

#include "history.h"
#include <stdlib.h>
#include <stdio.h>
/** The location where the scores data will be kept */
#define SCOREFILE "scores.txt"
/**
  Shift factor used to help display the correct number of guesses at a given
  index. Shift will be used to display n + 1 if the index is n
*/
#define COUNT_SHIFT 1


void updateScore( int guessCount )
{
  // if more than 10 setting value to 10 for indexing purposes
  if ( guessCount > NUM_CATS ) {
    guessCount = NUM_CATS;
  }
  // score array for reading and printing
  int currScores[ NUM_CATS ];
  // opening score file if it exits
  FILE *stream = fopen( SCOREFILE, "r" );
  // if no score file exits
  if ( stream == NULL ) {
    stream = fopen( SCOREFILE, "w" );
    for ( int i = 0; i < NUM_CATS; i++ ) {
      currScores[ i ] = 0;
    }
  } else {
    // getting currect scores if file exits
    for ( int i = 0; i < NUM_CATS; i++ ) {
      fscanf( stream, "%d", &currScores[ i ] );
    }
    // closing file
    fclose( stream );
    // reopening file to clear the data in it
    stream = fopen( SCOREFILE, "w" );
  }
  // incrementing number of games won at the correct index
  currScores[ guessCount - COUNT_SHIFT ]++;
  // printing scores to stdout and to the score file
  for ( int i = 0; i < NUM_CATS; i++ ) {
    if ( i != NUM_CATS - 1 ) {
      printf("%2d  : %4d\n", i + COUNT_SHIFT, currScores[ i ] );
      fprintf(stream, "%d ", currScores[ i ] );

    } else {
      printf("%2d+ : %4d\n", i + COUNT_SHIFT, currScores[ i ]);
      fprintf(stream, "%d\n", currScores[ i ] );
    }
  }
  // closing file  
  fclose( stream );
}
