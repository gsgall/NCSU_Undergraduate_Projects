/**
  @file encode.c
  @author Grayson Gall ( gsgall )
  Main file for the encoding functionality. Converting from  binary to characters
*/
#include  <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "state24.h"
#include "filebuffer.h"
/** The min number of command line arguments that should be provided */
#define NUM_ARGS 3
/** Error message for invalid use of program */
#define INVALID_ARGS "usage: encode [-b] [-p] <input-file> <output-file>\n"
/** The min required length for an input string so it will have the proper file extenstion */
#define MIN_LEN 4
/** The allowed number of characters on a single line if breaks are required */
#define LINE_LEN 76
/** the number of bytes to be processed before a new line character is added to the output buffer */
#define NUM_BYTES_NL ( 3 * LINE_LEN / 4 )
/**
  Function for checkign to make sure commdnline arguments are valid
  @param argc the number of command line arguments passes
  @param argv the array that stores the command line arguments
*/
static void validArgs( int argc, char *argv[] )
{
  // checking to extra options
  if ( argc > NUM_ARGS ) {
    for ( int i = 1; i < argc - 2; i++ ) {
      if ( strcmp( argv[ i ], "-b") && strcmp( argv[ i ], "-p") ) {
        fprintf( stderr, "%s", INVALID_ARGS );
        exit( EXIT_FAILURE );
      }
    }
  }
  // making sure file names are long enough for extensions
  if ( argc < NUM_ARGS || strlen( argv[ argc - 1 ] ) < MIN_LEN || strlen( argv[ argc - 2 ]) < MIN_LEN ) {
    fprintf( stderr, "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
  // checking for txt file
  char *test = argv[ argc - 1 ] + ( strlen( argv[ argc - 1 ] ) - MIN_LEN );
  if ( strcmp( test, ".txt" ) ) {
    fprintf( stderr, "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
  // checking for binary file
  test = argv[ argc - 2 ] + ( strlen( argv[ argc - 2 ] ) - MIN_LEN );
  if ( strcmp( test, ".bin" ) ) {
    fprintf( stderr, "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
}

/**
  Checks command line arguments for the no break options
  @param argc the number of command line arguments
  @param argv the arry of command line arguments
  @return false if no breaks are requested true if not
*/
static bool lineBreaks( int argc, char *argv[] )
{
  for ( int i = 1; i < argc - 2; i++ ) {
    if ( strcmp( argv[ i ], "-b") ){
      return false;
    }
  }
  return true;
}

/**
  Checks command line arguments for the no padding options
  @param argc the number of command line arguments
  @param argv the arry of command line arguments
  @return false if no padding is requested true if not
*/
static bool padding( int argc, char *argv[] )
{
  for ( int i = 1; i < argc - 2; i++ ) {
    if ( strcmp( argv[ i ], "-p" ) ){
      return false;
    }
  }
  return true;
}

/**
  Main function for the encode program
  @param argc the number of command line arguments
  @param argv the array of command line arguments
  @return 0 for successful program 1 for error
*/
int main( int argc, char *argv[] )
{
  // checking command line arguments
  validArgs( argc, argv );
  // checking for additional requests
  bool breaks = lineBreaks( argc, argv );
  bool pad = padding( argc, argv );
  // reading the input file
  FileBuffer *input = loadFileBuffer( argv[ argc - 2 ] );
  // setting up output buffer
  FileBuffer *output = makeFileBuffer();
  // initialzing state
  State24 state;
  initState( &state );
  // checking if number of bytes is a multiple of 3
  int extraBytes = input->numBytes % NUM_BYTES;
  int numNewLine = 0;
  for ( int i = 0; i < input->numBytes; i++ ) {
    // getting the next byte
    addByte( &state, input->data[ i ] );
    // adding new line if needed
    if ( breaks && ( output->numBytes != 0 ) && ( i % NUM_BYTES_NL == 0 ) ) {
      appendFileBuffer( output, '\n');
      numNewLine++;
      //printf( "%d\n", i );
    }
    // emptying the number of bytes when needed
    if ( state.numBytes == NUM_BYTES ) {
      char tmp[ MAX_CHARS ];
      getChars( &state, tmp );
      for ( int j = 0; j < MAX_CHARS; j++ ) {
        appendFileBuffer( output, tmp[ j ]);
      }
    }
  }

  char tmp[ MAX_CHARS ];
  getChars( &state, tmp );
  if ( extraBytes ) {
    for ( int i = 0; i < extraBytes + 1; i++ ) {
      appendFileBuffer( output, tmp[ i ] );
    }
  }

  // adding padding if needed
  if ( pad && extraBytes ) {
    for ( int i = 0; i < ( NUM_BYTES - extraBytes ); i++ ) {
      appendFileBuffer( output, '=' );
    }
  }
  // adding newline at the end
  appendFileBuffer( output, '\n' );
  // saving and then freeing buffers
  saveFileBuffer( output, argv[ argc - 1 ] );
  freeFileBuffer( input );
  freeFileBuffer( output );
  return EXIT_SUCCESS;
}
