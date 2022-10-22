/**
  @file operation.c
  @author Grayson Gall (gsgall)
  Provides functionality and overflow detection for common mathematical
  operations performed on longs
*/
#include "operation.h"
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
/** Constant that will help check the special case in division over flow for
    LONG_MIN / -1
*/
#define DIVIDE_OVERFLOW -1

long plus( long a, long b)
{
  long max = LONG_MAX - b;
  long min = LONG_MIN - b;
  if ( a > 0 && b > 0 && a > max ) {
    exit( OVERFLOW );
  }
  if ( a < 0 && b < 0 && a < min ) {
    exit( OVERFLOW );
  }
  return a + b;
}

long minus( long a, long b )
{
  long max = LONG_MAX + b;
  long min = LONG_MIN + b;

  if ( a > 0 && b > 0 && a < min ) {
    exit( OVERFLOW );
  }

  if ( a < 0 && b < 0 && a > max ) {
    exit( OVERFLOW );
  }
  return a - b;
}

long times( long a, long b )
{
  // checking the case for when both are the same sign
  // result must be <= LONG_MAX
  if ( ( a > 0 && b > 0 ) || ( a < 0 && b < 0 ) ) {
    long max = LONG_MAX / b;
    if ( ( a > 0 && a > max ) || ( a < 0 && a < max ) ) {
      exit( OVERFLOW );
    }
  // checking case for then both are opposite sign
  // result must be >= LONG_MIN
  } else {
    long min = LONG_MIN / b;
    if ( a < 0 &&  a < min ) {
      exit( OVERFLOW );
    }
    if ( a > 0 &&  a > min ) {
      exit( OVERFLOW );
    }
  }
  return a * b;
}

long divide( long a, long b)
{
  // divide by 0 detection
  if ( b == 0 ) {
    exit( DIVIDE_BY_0 );
  }
  // two's compliment overflow detection
  // only case for overflow is if LONG_MIN / -1 becasue
  // -LONG_MIN > LONG_MAX
  if (a == LONG_MIN && b == DIVIDE_OVERFLOW ) {
    exit( OVERFLOW );
  }
  return a / b;
}
