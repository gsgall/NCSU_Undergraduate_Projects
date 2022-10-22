/**
  @file calc.c
  @author Grayson Gall (gsgall)
  Program reads in a mathematical expression and then evaluates it following
  proper order of operations
*/
#include <stdio.h>
#include <stdlib.h>
#include "number.h"
#include "operation.h"

/**
  Function is used to parse the terms in between addition and subtraction terms.
  This is done to ensure that oder of operations is kept
  @return the value of a term as a long
*/
static long parseTerm()
{
  // Collecting the next number
  long ans = parseValue();
  // Collecting the next operator in the term
  char operator = getchar();
  // if the operator is a * or / we need to evaluate those groups first
  while ( operator == MULTIPLY || operator == DIVIDE ) {
    if ( operator == MULTIPLY ) {
      ans = times( ans, parseValue() );
    } else {
        ans = divide( ans, parseValue() );
    }
    operator = getchar();
  }
  // ending the loop and returning the operator for the next function
  ungetc( operator, stdin );
  return ans;
}

/**
  Used to evaluate an entire line. This helps seperate the terms in the
  expression to terms between + and - operators
  Functionality is seperated as a way to make parenthesis support easier to
  implement if I have time
  @return the value of entire mathematical expression as a long
*/
static long evaluateExpression()
{
  // evaluating the first term in the expression
  long ans = parseTerm();
  // getting the next operator
  char operator = getchar();
  //  reading terms until the end of the line
  while ( operator != EOL ) {
    // checking for the seperator of terms between addition and subtraction
    if (operator == ADD ) {
      ans = plus( ans, parseTerm() );
    } else if (operator == SUBTRACT) {
      ans = minus( ans, parseTerm() );
    }
    skipSpace();
    operator = getchar();
  }
  return ans;
}

/**
  Main function reads in a mathematical expression with +, -, * or / operators
  then prints the value of the expression
  @return the exit status of the program 
*/
int main()
{
  printValue( evaluateExpression() );
  return EXIT_SUCCESS;
}
