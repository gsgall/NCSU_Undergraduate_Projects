/**
  @file number10.c
  @author Grayson Gall (gsgall)
  Provides the Implementation of the reading, writing and skipping functions
  for a base 10 number system
*/
#include <stdlib.h>
#include <stdio.h>
#include "number.h"
#include "operation.h"

/** Base of the number system being used */
#define BASE 10
/**
  Used to skip blank spaced in an expression
  @return the first non whtie space character code as an int
*/
int skipSpace()
{
  // getting the first potential space
  char ch = getchar();
  //checking wether or not it is a space
  if ( ch != SPACE && ch != TAB && ch != CARRIAGE &&
       ch != VERT && ch != FORM ) {
    // if not a whilte space char put back
    ungetc( ch, stdin );
    return ch;
  }
  // continue to skip space until non white space
  return skipSpace();
}

/*
  Implementation reads numbers represented in base 10
*/
long parseValue()
{
  // skipping any blank space that maty exist
  skipSpace();
  long val = 0;
  long curr = 0;
  // getting the first non white space
  char ch = getchar();
  int sign = POSITIVE;
  // case of negative number
  if ( ch == SUBTRACT ) {
    // print negative sign and treat number as a positive
    sign = NEGATIVE;
  } else {
    ungetc( ch , stdin );
  }
  // getting the first numeric value
  ch = getchar();
  // veriffying valid characters
  if ( ch < BEGIN_NUM || ch > END_NUM ) {
    exit( FAIL_INPUT );
  }
  // looping through the entire number
  while( ch >= BEGIN_NUM && ch <= END_NUM ) {
    // converting from char to int
    curr = ch - BEGIN_NUM;
    // shifting the number to the left
    val = times( val, BASE );
    // adding the next found digit
    val = plus( val, sign * curr );
    // getting the next character
    ch = getchar();
  }
  ungetc( ch, stdin );
  // checking to make sure the next character is valid
  skipSpace();
  ch = getchar();
  if ( ch != ADD && ch != SUBTRACT &&
       ch != MULTIPLY && ch != DIVIDE &&
       ch != EOL) {
    exit( FAIL_INPUT );
  } else {
    // case for valid character
    ungetc( ch, stdin );
  }
  return val;
}

/*
  Prints numbers in base 10 representation to the standard output
*/
void printValue( long val )
{
  printf( "%ld\n", val );
}
