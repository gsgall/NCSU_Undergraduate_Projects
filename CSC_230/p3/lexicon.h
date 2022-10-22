/**
  @file lexicon.h
  @author Grayson Gall ( gsgall )
  Header file for the list managing functions for the wordle game 
*/
#include <stdbool.h>

/** Maximum lengh of a word on the word list. */
#define WORD_LEN 5

/** Maximum number of words on the word list. */
#define WORD_LIMIT 100000
/** The length of a null character used for initialzing word strings */
#define NULL_LEN 1
/** Global variable to store the list of words that will be used */
extern char list[ WORD_LIMIT ][ WORD_LEN + NULL_LEN ];

/**
  Function reads words from a list stored in the provided file. Checks for
  invalid lists. A word with anything other than WORD_LEN letters is rejected.
  If there are any characters that are not lower case letters the file is
  rejected.
  @param filename the path to the file where the list is located
*/
void readWords( char const filename[] );

/**
  Function retrieves a word from the list with a given seed.
  @param seed the seed that will be used to calcuate the pseudo random number
         that will be the index of the word that is to be randomly selected
  @param word the array where the pseudo randomly selected word will be stored
*/
void chooseWord( long seed, char word[] );

/**
  Checks to see if the given word is in the list of words.
  @param word the word that will be looked for in the list
  @return a boolean true if the word is in the list false if not
*/
bool inList( char const word[] );
