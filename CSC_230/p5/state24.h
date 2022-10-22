/**
  @file state24.h
  @author Grayson Gall ( gsgall )
  header file for the state structure and its functions
*/
#ifndef _STATE64_H_
#define _STATE64_H_

#include <stdbool.h>

// Include filebuffer to get the byte type.
#include "filebuffer.h"
/** Maximum number of characters that can be added to the struct */
#define MAX_CHARS 4
/** The character that begins the uppercase letter range */
#define START_UP_ALPHA 'A'
/** The binary value associated with the letter A */
#define START_UP_BYTE 0x00
/** The character that ends the uppercase letter range */
#define END_UP_ALPHA 'Z'
/** The character that begins the lowercase letter range */
#define START_LOW_ALPHA 'a'
/** The binary value associated with the letter a */
#define START_LOW_BYTE 0x68
/** The character that ends the lowercase letter range */
#define END_LOW_ALPHA 'z'
/** The character that begins the numeric range */
#define START_NUM '0'
/** The binary value associated with the number 0 */
#define START_NUM_BYTE 0xD0
/** The character that ends the numeric range */
#define END_NUM '9'
/** The first allowed special character */
#define SPECIAL_1 '+'
/** The first allowed special characters binary value */
#define SPECIAL_1_BYTE 0xF8
/** The second allowed special character */
#define SPECIAL_2 '/'
/** The second allowed special characters binary value */
#define SPECIAL_2_BYTE 0xFC
/** The number of bytes that are allowed to be stored in the bytes field of state24 */
#define NUM_BYTES 3
/** The number of bits the bytes need to be shifted for conversion to and from char */
#define CONVERSION_SHIFT 2
/** The number of character associated with adding a single byte */
#define MIN_CHAR 2
/** Number bits that must be shifted to access the second characters bits */
#define SHIFT_2 6
/** Number bits that must be shifted to access the third characters bits */
#define SHIFT_3 4
/** Number bits that must be shifted to access the forth characters bits */
#define SHIFT_4 2
/** Mask that is applied to convert the first character to char */
#define MASK_1 0xFC
/** Mask that is applied to convert the first part of the second character to char */
#define MASK_2_1 0x03
/** Mask that is applied to convert the second part of the second character to char */
#define MASK_2_2 0xF0
/** Mask that is applied to convert the first part of the third character to char */
#define MASK_3_1 0x0F
/** Mask that is applied to convert the second part of the third character to char */
#define MASK_3_2 0xC0
/** Mask that is applied to convert the fourth character to char */
#define MASK_4 0x3F
/**
  Holds the state of data to be converted to and from bytes to chars or the
  reverse
  @field bytes an array of the bytes that are in holding, waiting to be converted
  @field numChars the number of characters stored in the struct
  @field numBytes the number of bytes stored in the struct
*/
typedef struct {
  byte bytes[ NUM_BYTES ];
  int numChars;
  int numBytes;
  // ...
} State24;

/**
  Initialization for the state24 struct sets all bytes in bytes, and all counts
  to 0s
  @param state the pointer to the state to be changed
*/
void initState( State24 *state );

/**
  Checks character values to make sure that they are allowed to be used
  valid ranges
  A-Z
  a-z
  0-9
  + and /
  @param ch the character to be checked
  @return a boolean true if valid false if not
*/
bool validChar( char ch );

/**
  Adds a byte to the bytes array in state24 struct in the next avilable spot
  @param state the state struct being used
  @param b the byte to be added
*/
void addByte( State24 *state, byte b );

/**
  Adds the byte values associated with a character to the bytes array
  @param state the state to add the bytes to
  @param the character value to be converted to bytes
*/
void addChar( State24 *state, char ch );

/**
  Gets all of the full bytes from the state24 byte array and then resets the state
  @param state the state where everything is being stored
  @param buffer the place to store the bytes
  @return the number of full bytes written to buffer
*/
int getBytes( State24 *state, byte buffer[] );

/**
  Gets all of the character values from the bytes stored in the state and then
  resets the state
  @param state the state where everything is being stored
  @param buffer the place to store the bytes
  @return the number of full bytes written to buffer
*/
int getChars( State24 *state, char buffer[] );

#endif
