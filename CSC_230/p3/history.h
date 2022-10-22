/**
  @file history.h
  @author Grayson Gall ( gsgall )
  header file for the update score function 
*/

/** The under of score categories that will be stored */
#define NUM_CATS 10

/**
  Reads, updates and displays the number of guesses it took to guess the word
  in all previous games.
  @param guessCount the number of guesses it took to guess the word
*/
void updateScore( int guessCount );
