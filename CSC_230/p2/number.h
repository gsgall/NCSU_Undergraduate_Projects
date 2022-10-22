/**
  @file number.h
  @author Grayson Gall (gsgall)
  Header file provides the function prototypes and constants
  for reading and writing numbers in a given base
*/
/** Exit status indicating that the program was given invalid input. */
#define FAIL_INPUT 102
/** THe space character used to detect white space */
#define SPACE ' '
/** THe tab character used to detect white space */
#define TAB '\t'
/** THe carriage return character used to detect white space */
#define CARRIAGE '\r'
/** THe vertical tab character used to detect white space */
#define VERT '\v'
/** THe form feed character used to detect white space */
#define FORM '\f'
/** The character representaion of the addition operator */
#define ADD '+'
/** The character representaion of the subtraction operator */
#define SUBTRACT '-'
/** The character representaion of the multiplication operator */
#define MULTIPLY '*'
/** The character representaion of the division operator */
#define DIVIDE '/'
/** The end of line operator used to detect when an expression ends */
#define EOL '\n'
/** The frist acceptable character in the numeric character range */
#define BEGIN_NUM '0'
/** The last acceptable character in the numeric character range */
#define END_NUM '9'
/** The frist acceptable character in the letter character range */
#define BEGIN_LETTER 'A'
/** The last acceptable character in the letter character range */
#define END_LETTER 'O'
/** Constant used to define a postive sign on a number */
#define POSITIVE 1
/** Constant used to change the sign of a negative number */
#define NEGATIVE -1
/**
  Used to skip blank spaced in an expression
  @return the first non whtie space character code as an int
*/
int skipSpace();

/**
  Reads numbers in from the standard input
  @return the long representation of the number read from standard input
*/
long parseValue();

/**
  Prints a number to the standard output
  @param val the number to be printed to the standard output
*/
void printValue( long val );
