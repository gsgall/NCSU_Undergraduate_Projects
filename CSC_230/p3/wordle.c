/**
  @file wordle.c
  @author Grayson Gall ( gsgall )
  File is the main file to play the wordle game. Contains the game logic for
  this game as well.
*/
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <time.h>
#include <string.h>
#include "lexicon.h"
#include "io.h"
#include "history.h"
/** The number of arguments if there is no seed provided by the user */
#define TIMESEED 2
/** The number of arguments if there is a seed provided by the user */
#define USERSEED 3
/** The index of the user provided seed */
#define USERSEED_IDX 2
/** The index of the list file provided by the user */
#define FILENAME_IDX 1
/** The error message displayed if the user guess is invalid */
#define INVALID_GUESS "Invalid guess\n"
/** Error message for when the improper arguments are passed by the user */
#define INVALID_ARGS "usage: wordle <word-list-file> [seed-number]\n"
/** Character marking the start of digits. Used for verifying the seed provided */
#define NUM_START '0'
/** Character marking the end of digits. Used for verifying the seed provided */
#define NUM_END '9'
/** Character marking the start of letters. Used for verifying user guesses */
#define LETTER_START 'a'
/** Character marking the end of letters. Used for verifying user guesses */
#define LETTER_END 'z'
/** The command used when the user wants to end the game */
#define QUIT_COMMAND "quit"
/** Numeric value assigned when printing color is Green */
#define COLOR_GREEN 2
/** Numeric value assigned when printing color is Yellow */
#define COLOR_YELLOW 1
/** Numeric value assigned when printing color is the default */
#define COLOR_DEFAULT 0

/**
  Value used in mapping the index of a letter when a letter in the user guess
  is not in the word selected from the list
*/
#define NOT_IN_WORD -1

/**
  Value used in mapping the index of a letter when a letter in the user guess
  is in the word selected from the list
*/
#define IN_WORD 1

/** initialzation of the word list as a global variable */
char list[ WORD_LIMIT ][ WORD_LEN + NULL_LEN ];

/**
  Method used to exit the program if invalid arguments are passed
*/
static void invalidArgs()
{
  fprintf( stderr, "%s", INVALID_ARGS );
  exit( EXIT_FAILURE );
}

/**
  Used to verify a user provided seed. Returns false if args are in valid
  true if they are legal
  @param numStr the string containing the seed provided by the user
  @return the status of the seed provided. True if seed if valid and program
          exits if the seed is not valid
*/
static bool checkSeed( const char numStr[] )
{
  int len = strlen( numStr );
  // looping through all characters in the seed to make sure all characters
  // are digits
  for ( int i = 0; i < len; i++ ) {
    if ( numStr[ i ] < NUM_START || numStr[ i ] > NUM_END ) {
      // if invalid args program exits
      invalidArgs();
    }
  }
  return true;
}

/**
  Used to validate guesses provided by the user. Guesses must be 5 characters
  long and only contain lower case letters. If not it is not valid
  @param guess the guess provided by the user
  @return status of the guess returns true if valid false if not
*/
static bool validGuess( char guess[] )
{
  // Getting the first character in the user guess
  char curr = getchar();
  int charCount = 0;
  // checking for the end of file to terminate program
  if ( curr == EOF ) {
    guess[ 0 ] = curr;
    return true;
  }
  // reading all characters on a line
  while( curr != EOL && curr != EOF ) {
    // storing all letters before letter limit
    if ( charCount < WORD_LEN ) {
      guess[ charCount ] = curr;
    }
    // getting the next character
    curr = getchar();
    charCount++;
  }
  // checking for quit command
  if ( strcmp( guess, QUIT_COMMAND ) == 0 ) {
    return true;
  }
  // checking for invalid length words
  if ( charCount != WORD_LEN ) {
    printf( "%s", INVALID_GUESS );
    return false;
  }
  // making sure all characters on the line are valid
  for ( int i = 0; i < charCount - NULL_LEN ; i++ ) {
    if ( guess[ i ] < LETTER_START || guess[ i ] > LETTER_END ) {
      printf( "%s", INVALID_GUESS );
      return false;
    }
  }
  // making sure guess is in the word
  //if ( !inList( guess ) ) {
  //  printf( "%s", INVALID_GUESS );
  //  return false;
  //}

  return true;
}

/**
  Finds the unique characters that exist in a given word
  @param word the word that will be parsed for its letters
  @param unique the location where the unique letters will be stored
*/
static void findUniqueChars( char const word[], char unique[] )
{
  // starting the search for unique chars
  int uniqueIdx = 0;
  for ( int i = 0; i < WORD_LEN; i++ ) {
    // starts assuming that the letter is unique
    bool inUnique = false;
    for ( int j = 0; j < WORD_LEN; j++ ) {
      // case for when the letter is already in the unique list
      if ( word[ i ] == unique[ j ] ) {
        inUnique = true;
        break;
      }
    }
    // if not in the list it is added
    if ( !inUnique ) {
      unique[ uniqueIdx ] = word[ i ];
      uniqueIdx++;
    }
  }
}

/**
  Creates a matrix of 1s and 0s for each letters location in the word matrix
  will be WORD_LEN x WORD_LEN the rows will be the unique letter of the word and
  colum will be the location of that letter in the word
  Ex Word = these
  t | 1 0 0 0 0 |
  h | 0 1 0 0 0 |
  e | 0 0 1 0 1 |
  s | 0 0 0 1 0 |
    | 0 0 0 0 0 |
  Also creates a count of all the letters in a word. will be WORD_LEN x 1
  t h e s
  1 1 2 1 0
  Also creates a letter map for letters in a given word to another
  mapping letters in these to the count of after
   a  f  t  e  r
  -1 -1  0  2 -1
  @param word the word to create a matrix and others for
  @param unique the list of letters to map the letters in word to
  @param lettMat the location where the word matrix will be stored
  @param letterCount the location where the letter count will be stored
  @param letterMap the location where the letter map will be stored
*/
static void createLetterMat( char const word[], char const unique[],
                             int lettMat[][ WORD_LEN ],
                             int letterCount[],
                             int letterMap[] )
{
  for ( int i = 0; i < WORD_LEN; i++ ) {
    for ( int j = 0; j < WORD_LEN; j++ ) {
      // if the letter in the word is in the unique list it is added to the
      // letter matrix
      if ( unique[ i ] == word[ j ] ) {
        // adding a 1 to the location where the letters are in list and given
        // word
        lettMat[ i ][ j ] = IN_WORD;
        letterCount[ i ]++;
        letterMap[ j ] = i;
      }
    }
  }
}

/**
  Gets the information where the correct letter guesses are located as well as
  creating a matrix of correct guesses
  Creating the correct mat. A matrix that stores the correctly place letters in
  the guess.
  Logical and of wordMat and guessMat
  Ex. word = their guess = there
  correctMat
  t  | 1 0 0 0 0 |
  h  | 0 1 0 0 0 |
  e  | 0 0 1 0 0 |
  i  | 0 0 0 0 0 |
  r  | 0 0 0 0 0 |
  numCorrect is the list of the numbers for each unique letter
  Ex | 1 1 1 0 0 |
  printGreen a list of indices of the correctly placed letters in the guess
  Ex | 1 1 1 0 0 |
  In this example they are the same but not gaurenteed to be
  @param wordMat the matrix of the word mapped to unique letters
  @param guessMat the matrix of the guess mapped to unique letters in the word
  @param printGreen the matrix to map where the letters are to be printed green
  @param numCorrect the matrix of the number of correctly place letters
  @param correctMat the logical and of the guess and word letter matrix
*/
static void getGreenLetters( int const wordMat[][ WORD_LEN ],
                             int const guessMat[][ WORD_LEN],
                             int printGreen[],
                             int numCorrect[],
                             int correctMat[][ WORD_LEN ] )
{
  for ( int i = 0; i < WORD_LEN; i++ ) {
    for ( int j = 0; j < WORD_LEN; j++ ) {
      // checking for correct letter and location in matrix
      if ( wordMat[ i ][ j ] == guessMat[ i ][ j ] && guessMat[ i ][ j ] == 1) {
        printGreen[ j ] = COLOR_GREEN;
        correctMat[ i ][ j ] = 1;
        numCorrect[ i ]++;
      }
    }
  }
}

/**
  Gets the placement of all letters that in teh word and the guess but in the
  wrong places
  logical and of
  guessMat and !correctMat
  @param guessMat the letter matrix of the user guess
  @param correctMat the matrix of correctly placed letters in the guess
  @param numYellow the location where the information of possible yellow prints
         is stored
*/
static void getPossibleYellow( int const guessMat[][ WORD_LEN ],
                               int const correctMat[][ WORD_LEN ],
                               int numYellow[] )
{
  for (int i = 0; i < WORD_LEN; i++ ) {
    for ( int j = 0; j < WORD_LEN; j++ ) {
      // checking for letters in the word but not in the right locations
      if ( guessMat[ i ][ j ] == IN_WORD && correctMat[ i ][ j ] == 0 ) {
       numYellow[ j ]++;
       }
    }
  }
}

/**
  Function takes the users guess and creates an array of colors to be printed
  All letters in the correct place will be denoted as a 2 in the printColor
  array
  All letters in the word but in the wrong place will be denoted as a 1 in the
  printColor array
  All letters not in the word but in the guess will be denoted as a 0 in the
  printColor array
  @param wordLetterCount the number of each unique letter in the word
  @param numCorrect an array of the correctly placed letters
  @param printColors the array where the numeric mapping is stored
  @param numYellow the array where the yellow letter inforation is stored
*/
static void getPrintColors( int const wordLettCount[],
                            int const numCorrect[],
                            int printColors[],
                            int const numYellow[] )
{
  for ( int i = 0; i < WORD_LEN; i++ ) {
    // finding the colors for printing
    bool available = wordLettCount[ i ] - numCorrect[ i ];
    if ( wordLettCount[ i ] == 0 && numCorrect[ i ] == 0 ) {
      available = true;
    }
    printColors[ i ] += available && numYellow[ i ];
  }
}

/**
  Checks if the user has guessed the wrod correctly
  @param printColors the array where the colors to be used for chaning the colors
         to be printed to the comand line
  @return returns true if the guess is correct false if not
*/
static bool checkGuess( int const printColors[] )
{
  // checks to make sure that all letters are in the right place in a guess
  int correctCount = 0;
  for ( int i = 0; i < WORD_LEN; i++ ) {
    if ( printColors[ i ] == COLOR_GREEN ) {
      correctCount++;
    }
  }
  return correctCount == WORD_LEN;
}

/**
  Prints the users guess in the proper colors required
  Green for letters in the correct place
  Yellow for letters in the word but in the wrong place. If there are n
  instances of a letter in a guess and m instances of a letter in the word then
  the first m letters will be printed in yellow
  Default color for letters that are in the guess but not in the word
  @param guess the users guess
  @param printColors the color array for printing
  @param wordLetterCount the number of each unique letter in the word
  @param guessLetterMap the mapping of the letters in the guess to the indices
         of the unique letters in the word
*/
static void printGuess( char const guess[], int const printColors[],
                        int wordLetterCount[], int const guessLetterMap[] )
{
  // copying the wordLetterCount for use in the loop and actual values are
  // not affected
  int localCount[ WORD_LEN ] = {0};
  for ( int i = 0; i < WORD_LEN; i++ ) {
    localCount[ i ] = wordLetterCount[ i ];
    if ( printColors[ i ] == COLOR_GREEN ) {
        localCount[ guessLetterMap[ i ] ]--;
    }
  }
  // start setting current color to the default
  int currColor = COLOR_DEFAULT;
  for ( int i = 0; i < WORD_LEN; i++ ) {
    // if color needs to be changed is is changes to the proper one
    if ( printColors[ i ] == COLOR_DEFAULT && currColor != COLOR_DEFAULT ) {
      colorDefault();
      currColor = COLOR_DEFAULT;
    } else if ( printColors[ i ] == COLOR_GREEN ) {
      if ( currColor != COLOR_GREEN ) {
        colorGreen();
        currColor = COLOR_GREEN;
      }
    } else if ( printColors[ i ] == COLOR_YELLOW ) {
      // checking to make sure color can be changed to yellow
      if (currColor != COLOR_YELLOW && localCount[ guessLetterMap[ i ] ] > 0 ) {
        colorYellow();
        currColor = COLOR_YELLOW;
        // case for when the color could be yellow but is not due to game rules
      } else if ( currColor != COLOR_DEFAULT && localCount[ guessLetterMap[ i ] ] <= 0 ) {
        colorDefault();
        currColor = COLOR_DEFAULT;
      }
      // keeping track of characters to track if color can be changed to yellow
      localCount[ guessLetterMap[ i ] ]--;
    }
    // printing current character
    printf( "%c", guess[ i ]);
  }
  // resetting the default color if needed
  if ( currColor != COLOR_DEFAULT ) {
    colorDefault();
  }
  printf( "\n" );
}

/**
  Main function used to play wordle
  @param argc the number of arguments passed to the main function
  @param argv an array containing the arguments passed to the program
*/
int main( int argc, char *argv[] ){
  long seed;
  // checking to make sure the proper number of arguments is provided
  if ( argc < TIMESEED || argc > USERSEED ) {
    invalidArgs();
  }
  // case for no user provided seed
  if ( argc == TIMESEED ) {
    seed = time( NULL );
  }
  // converting user seed to long and verifying user seed as valid
  if ( argc == USERSEED && checkSeed( argv[ USERSEED_IDX ] ) ) {
    seed = atol( argv[ USERSEED_IDX ] );
  }
  // reading word list
  readWords( argv[ FILENAME_IDX ] );
  // initialzing wordle word
  char word[ WORD_LEN + NULL_LEN ] = "";
  // getting the word for the game
  chooseWord( seed, word );
  int guessCount = 0;

  // bool for verifying valid user guesses
  bool valid;
  // initialzing the arays needed for matrices
  char wordLetters[ WORD_LEN + NULL_LEN ] = {0};
  int wordMat[ WORD_LEN ][ WORD_LEN ] = {0};
  int letterCount[ WORD_LEN ] = {0};
  // will not be used just for function call
  int tempLetterMap[ WORD_LEN ] = {0};
  // getting unique letters in the word
  findUniqueChars( word, wordLetters );
  // creating word letter matrix
  createLetterMat( word, wordLetters, wordMat, letterCount, tempLetterMap );
  // looping until user ends game
  while( true ) {
    // user current guess
    char currGuess[ WORD_LEN + NULL_LEN ] = "";
    // checkign for valid guess
    valid = validGuess( currGuess );
    // checking for EOF or user quitting games
    if ( strcmp( currGuess, QUIT_COMMAND ) == 0 || currGuess[ 0 ] == EOF ) {
      printf( "The word was \"%s\"\n" , word );
      exit( EXIT_SUCCESS );
    }
    // procedure for valid guess
    if ( valid ) {
      // initialzing all neede darrays
      int guessMat[ WORD_LEN ][ WORD_LEN ] = {0};
      int guessLettCount[ WORD_LEN ] = {0};
      int correctMat[ WORD_LEN ][ WORD_LEN ] = {0};
      int printColors[ WORD_LEN ] = {0};
      int numCorrect[ WORD_LEN ] = {0};
      int numYellow[ WORD_LEN ] = {0};
      // assuming guess contains no correct letters at start
      int letterMap[ WORD_LEN ] = { NOT_IN_WORD, NOT_IN_WORD, NOT_IN_WORD, NOT_IN_WORD, NOT_IN_WORD };
      createLetterMat( currGuess, wordLetters, guessMat, guessLettCount, letterMap );
      getGreenLetters( wordMat, guessMat, printColors, numCorrect, correctMat );
      getPossibleYellow( guessMat, correctMat, numYellow );
      getPrintColors( letterCount, numCorrect, printColors, numYellow );

      guessCount++;
      // checking for user win
      if ( checkGuess( printColors ) ) {
        if ( guessCount == 1 ) {
          printf( "Solved in 1 guess\n");
        } else {
          printf( "Solved in %d guesses\n", guessCount );
        }
        break;
      } else {
        // if not correct guess showing with proper colors
        printGuess( currGuess, printColors, letterCount, letterMap );
      }
    }
  }
  // showing and updating guess history
  updateScore( guessCount );
  return EXIT_SUCCESS;
}
