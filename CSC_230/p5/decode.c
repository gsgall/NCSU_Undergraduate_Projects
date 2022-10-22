/**
  @file decode.c
  @author Grayson Gall ( gsgall )
  Main file for the decoding functionality. Converting from characters to binary
*/
#include  <stdlib.h>
#include <ctype.h>
#include <string.h>

#include "state24.h"
#include "filebuffer.h"
/** Error message for invalid command line arguments */
#define INVALID_ARGS "usage: decode <input-file> <output-file>\n"
/** The number of command line arguments that should be provided */
#define NUM_ARGS 3
/** The min required length for an input string so it will have the proper file extenstion */
#define MIN_LEN 4
/**
  Function for checkign to make sure commdnline arguments are valid
  @param argc the number of command line arguments passes
  @param argv the array that stores the command line arguments
*/
static void validArgs( int argc, char *argv[] )
{
  // checking to make sure both are min lenght needed
  if ( strlen( argv[ argc - 1 ] ) < MIN_LEN || strlen( argv[ argc - 2 ]) < MIN_LEN ) {
    fprintf( stderr, "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
  // making sure the first argument is a .bin file
  char *test = argv[ argc - 1 ] + ( strlen( argv[ argc - 1 ] ) - MIN_LEN );
  if ( strcmp( test, ".bin" ) ) {
    fprintf( stderr, "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
  // making sure the second argument is a .txt file
  test = argv[ argc - 2 ] + ( strlen( argv[ argc - 2 ] ) - MIN_LEN );
  if ( strcmp( test, ".txt" ) ) {
    fprintf( stderr, "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
}

/**
  Error handling for invalid files
  gives error message and quits program and frees a buffer
  @param buffer the buffer that needs to be freed
*/
static void invalidFile( FileBuffer *buffer )
{
  freeFileBuffer( buffer );
  fprintf( stderr, "Invalid input file\n" );
  exit( EXIT_FAILURE );
}

/**
  Main function for the decode program
  @param argc the number of command line arguments
  @param argv the array of command line arguments
  @return 0 for successful program 1 for error
*/
int main( int argc, char *argv[] )
{
  // checking for proper number of arguments
  if ( argc != NUM_ARGS ) {
    printf( "%s", INVALID_ARGS );
    exit( EXIT_FAILURE );
  }
  // checking for valid arguments
  validArgs( argc, argv);
  // reading input from file
  FileBuffer *input = loadFileBuffer( argv[ 1 ] );
  // count for the number of bytes to be printed
  int numBytes = 0;
  // initializing state
  State24 state;
  initState( &state );
  for( int i = 0; i < input->numBytes; i++ ){
    // logic value for white space and padding
    bool skip = false;
    // checking for padding
    if ( ( char ) input->data[ i ] == '=' ) {
      for ( int j = i + 1; j < input->numBytes; j++ ) {
        if ( !isspace( ( char ) input->data[ j ] ) && ( char ) input->data[ j ] != '=' ) {
          invalidFile( input );
          break;
        }
        if ( j == input->numBytes - 1) {
          skip = true;
        }
      }
    }
    // checking for white space
    if ( isspace( ( char ) input->data[ i ] ) ) {
      skip = true;
    }
    // invalid file if not padding and not space
    if ( !validChar( ( char ) input->data[ i ] ) && !skip ) {
      invalidFile( input );
    }
    // adding character to state
    if ( !skip ) {
      addChar( &state, input->data[ i ] );
    }
    // when state is full converting characters to bytes and storing them
    if ( state.numChars == MAX_CHARS ) {
      numBytes += getBytes( &state, ( input->data ) + numBytes );
    }
  }
  // getting the last few bytes
  numBytes += getBytes( &state, ( input->data ) + numBytes );
  // updating the number of bytes to be printed
  input->numBytes = numBytes;
  // saving binary file
  saveFileBuffer( input, argv[ 2 ] );
  // freeing buffer
  freeFileBuffer( input );
  return EXIT_SUCCESS;
}
