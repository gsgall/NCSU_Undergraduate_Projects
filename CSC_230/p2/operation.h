/**
  @file operation.h
  @author Grayson Gall (gsgall)
  Provides prototypes for common math operatiosn on longs and constants to be
  thrown as exit codes in the case of error
*/

/** The error code used when an overflow is detected */
#define OVERFLOW 100
/* The error code used when a divide by 0 is detected */
#define DIVIDE_BY_0 101

/*
  Computes the sum of two longs and exits with status 100
  if overflow is detected
  @param a long integer
  @param b long integer
  @return the sum of a and b
*/
long plus( long a, long b);

/**
  Computes the difference between two longs and exits with status 100
  if overflow is detected
  @param a long integer
  @param b long integer
  @return the difference between a and b
*/
long minus( long a, long b);

/**
  Computes the product of two longs a and b and checks for overflow
  @param a long integer
  @param b long integer
  @return the product of a and b
*/
long times( long a, long b);

/**
  Computes the qutient of two longs a and b and checks for overflow
  @param a long integer
  @param b long integer
  @return the quoteient of a divided by b
*/
long divide( long a, long b);
