/**
  @file number25.c
  @author Grayson Gall (gsgall)
  Provides the Implementation of the reading, writing adn skipping functions
  for a base 25 number system
*/
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#include "number.h"
#include "operation.h"

/** The number value by which the frist alphabetic value is displced from 0 */
#define LETT_SHIFT 10
/** The base of the number system beign used */
#define BASE 25
/** The minimum number that can be converted to a numeric character */
#define MIN_NUM 0
/** The maximum number that can be converted to a numeric character */
#define MAX_NUM 9
/**
  Used to convert the numbers 0-24 to their base 25 representation
  @param num the number to convert to base 25 in the range 0 to 24
  @return the base 25 representation of the given numnber as a character
*/
static char convertTo25( int num )
{
  char ch;
  // case for 0 - 9 character
  if ( num >= MIN_NUM && num <= MAX_NUM ) {
    ch = num + BEGIN_NUM;
  // case for A - O character
  } else {
    ch = BEGIN_LETTER + num - LETT_SHIFT;
  }
  return ch;
}

/**
  Used to convert fronm a base 25 representation to  an interger representation
  in base 10
  @param ch the character to convert to base 10 0-9 or A-O
  @return the integer representation of the given base 25 character
*/
static int convertFrom25( char ch )
{
  int val = 0;
  // case for 0 - 9 character
  if ( ch >= BEGIN_NUM && ch <= END_NUM ) {
    val = ch - BEGIN_NUM;
  }
  // case for A - O character
  if ( ch >= BEGIN_LETTER && ch <= END_LETTER ) {
    val = ch - BEGIN_LETTER + LETT_SHIFT;
  }
  return val;
}

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
  Implimentation reads numbers represented in base 25
*/
long parseValue()
{
  // clearngin any empty space
  skipSpace();
  long val = 0;
  long curr = 0;
  // getting the starting char
  char ch = getchar();
  int sign = POSITIVE;
  // case for a negative number
  if ( ch == SUBTRACT ) {
    sign = NEGATIVE;
  } else {
    ungetc( ch , stdin );
  }

  // beginning the first numeric values
  ch = getchar();
  while ( ( ch >= BEGIN_NUM && ch <= END_NUM ) ||
       ( ch >= BEGIN_LETTER && ch <= END_LETTER) ) {
    // converting the char to a numeric value
    curr = convertFrom25( ch );
    // moving the base to the left
    val = times( val, BASE );
    // adding the last found value
    val = plus( val, sign * curr );
    // getting the next character
    ch = getchar();
  }
  ungetc( ch, stdin );
  skipSpace();
  // checkign for in valid operators
  ch = getchar();
  if ( ch != ADD && ch != SUBTRACT &&
       ch != MULTIPLY && ch != DIVIDE &&
       ch != EOL) {
    exit( FAIL_INPUT );
  } else {
    ungetc( ch, stdin );
  }
  return val;
}

/*
  Implimentation prints number in base 25
*/
void printValue( long val )
{
  static bool first = true;
  // special case for negative number
  if ( val < 0 && val != LONG_MIN) {
    // print negative adn treate as a positive
    printf( "%c", SUBTRACT );
    val *= NEGATIVE;
  }
  // special case for when the input is the LONG_MIN
  int curr = val % BASE;
  if (val == LONG_MIN) {
    curr *= NEGATIVE;
  }
  // converitng numbers to letters
  char ch = convertTo25( curr );
  if ( val != 0 && first) {
    first = false;
    printValue( val / BASE );
    // case for the end of the number
    printf( "%c\n", ch );
    // case for intermidiate values
  } else if ( val != 0 && !first) {
    printValue( val / BASE );
    putchar( ch );
    // case for the pure 0 value
  } else if ( val == 0 && first) {
    printf( "0\n");
  }
}
