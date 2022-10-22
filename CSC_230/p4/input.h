/**
  @file input.h
  @author Grayson Gall ( gsgall )
  header file for reading information from input
*/
#include <stdlib.h>
#include <stdio.h>

/**
  Function reads a line of variable length
  @param fp a pointer to the input buffer
  @return the string that is being read. Null if no input is provided 
*/
char *readLine( FILE *fp );
