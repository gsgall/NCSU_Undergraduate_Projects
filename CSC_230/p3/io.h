/**
  @file io.h
  @author Grayson Gall ( gsgall )
  Header file for the io.c file to communicate to the rest of the files 
*/
#include <stdbool.h>
#include <stdio.h>
/** The end of line character that will be used in checking input */
#define EOL '\n'
/** The length of the words that will be used in the program */
#define WORD_LEN 5
/**
  Reads a line from the file stream given.
  Function reads the first n characters in the line. Reads all of the characters
  on the line but does not store all of the characters if there are greater than
  n characters
  @param fp a pointer to the file stream to read from
  @param str the array where the data read will be stored
  @param n the maximum number of characters to be stored from the line
*/
bool readLine ( FILE *fp, char str[], int n );

/**
  Function changes the color of text output to Green
*/
void colorGreen();

/**
  Function changes the color of text output to Yellow
*/
void colorYellow();

/**
  Function changes the color of text output to the system Default color
*/
void colorDefault();
