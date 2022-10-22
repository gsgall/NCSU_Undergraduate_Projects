/**
  @file state24.c
  @author Grayson Gall ( gsgall )
  implementation file for the state struct and its fucntions. Converts chars to
  correct byte values and bytes to their correct character values.
*/
#include "state24.h"

/**
  Given a chacter function converts it to its associated byte value, left
  justified ie 12345600
  @param ch character to be converted
  @return the left justified byte value of the character
*/
static byte char2Bits( char ch )
{
  byte val;
  // converting upcase letters
  if ( ch >= START_UP_ALPHA && ch <= END_UP_ALPHA ) {
    val = START_UP_BYTE + ( ( ch - START_UP_ALPHA ) << CONVERSION_SHIFT );
  }
  // converting lower case letters
  if ( ch >= START_LOW_ALPHA && ch <= END_LOW_ALPHA ) {
    val = START_LOW_BYTE + ( ( ch - START_LOW_ALPHA ) << CONVERSION_SHIFT );
  }
  // converting numbers
  if ( ch >= START_NUM && ch <= END_NUM ) {
    val = START_NUM_BYTE + ( ( ch - START_NUM ) << CONVERSION_SHIFT ) ;
  }
  // converting +
  if ( ch == SPECIAL_1 ) {
    val = SPECIAL_1_BYTE;
  }
  // converting /
  if ( ch == SPECIAL_2 ) {
    val = SPECIAL_2_BYTE;
  }
  return val;
}

/**
  Converts left justified byte values to associated character
  @param b byte to be converted formatted 12345600
  @return the associated character value
*/
static char bits2Char( byte b )
{
  char ch;
  // converting upcase letters
  if ( b >= START_UP_BYTE && b < START_LOW_BYTE ) {
    ch = START_UP_ALPHA + ( ( b - START_UP_BYTE ) >> CONVERSION_SHIFT );
  }
  // converting lower case letters
  if ( b >= START_LOW_BYTE && b < START_NUM_BYTE ) {
    ch = START_LOW_ALPHA + ( ( b - START_LOW_BYTE ) >> CONVERSION_SHIFT );
  }
  // converting numbers
  if ( b >= START_NUM_BYTE && b < SPECIAL_1_BYTE ) {
    ch = START_NUM + ( ( b - START_NUM_BYTE ) >> CONVERSION_SHIFT );
  }
  // converting +
  if ( b == SPECIAL_1_BYTE ) {
    ch = SPECIAL_1;
  }
  // converting /
  if ( b == SPECIAL_2_BYTE ) {
    ch = SPECIAL_2;
  }

  return ch;
}


void initState( State24 *state )
{
  // resertting all bytes
  for ( int i = 0; i < NUM_BYTES; i++ ) {
    state->bytes[ i ] = 0x00;
  }
  state->numChars = 0;
  state->numBytes = 0;
}

bool validChar( char ch )
{
  return ( ( ch >= START_UP_ALPHA && ch <= END_UP_ALPHA ) ||
           ( ch >= START_LOW_ALPHA && ch <= END_LOW_ALPHA ) ||
           ( ch >= START_NUM && ch <= END_NUM ) ||
           ( ch == SPECIAL_1 || ch == SPECIAL_2 ) );
}

void addByte( State24 *state, byte b )
{
  state->bytes[ state->numBytes ] = b;

  if ( state->numBytes == 0 ) {
    state->numChars = MIN_CHAR;
  }

  if ( state->numBytes != 0 ) {
    state->numChars++;
  }
  state->numBytes++;
}

void addChar( State24 *state, char ch )
{
  // get bytes
  byte bits = char2Bits( ch );
  // 123456 00
  // first character to be in the array
  if ( state->numChars == 0 ) {
    state->bytes[ 0 ] = bits;
  }
  // second character in the array
  if ( state->numChars == 1 ) {
    // bits >> 6 = 000000 12
    state->bytes[ 0 ] = state->bytes[ 0 ] | ( bits >> SHIFT_2 );
    // bits << 2 = 3456 0000
    state->bytes[ 1 ] = bits << CONVERSION_SHIFT;
  }
  // third character in the array
  if ( state->numChars == 2 ) {
    // bits >> 4 = 0000 1234
    state->bytes[ 1 ] = state->bytes[ 1 ] | ( bits >> SHIFT_3 );
    // bits << 4 = 56 000000
    state->bytes[ 2 ] = bits << SHIFT_3;
  }
  // fourth character in the array
  if ( state->numChars == 3 ) {
    // bits >> 2 = 00 123456
    state->bytes[ 2 ] = state->bytes[ 2 ] | ( bits >> SHIFT_4 );
  }
  // incrementing counters
  if ( state->numChars == 0 ) {
    state->numBytes = 0;
  } else {
    state->numBytes++;
  }
  state->numChars++;
}

int getBytes( State24 *state, byte buffer[] )
{
  for ( int i = 0; i < state->numBytes ; i++ ) {
    buffer[ i ] = state->bytes[ i ];
  }
  int count = state->numBytes;

  initState( state );
  return count;
}


int getChars( State24 *state, char buffer[] )
{
  int count = state->numChars;
  // bits = 12345678
  byte bits;
  // case for atleast 1 character
  if ( count >= 1 ) {
    // bits & 11111100 = bits & 0xFC = 123456 00
    bits = state->bytes[ 0 ] & MASK_1;
    buffer[ 0 ] = bits2Char( bits );
  }
  // case for atleast 2 characters
  if ( count >= 2 ) {
    // ( bits & 000000 11 ) << 6 = ( bits & 0x03 ) << 6 = 78 000000
    bits = ( state->bytes[ 0 ] & MASK_2_1 ) << SHIFT_2;
    // bits | ( ( bits2 & 1111 0000 ) >> 2 )
    // bits | ( ( bits2 & 0xF0 ) >> 2  )
    // 78 1234 00
    bits = bits | ( ( state->bytes[ 1 ] & MASK_2_2 ) >> CONVERSION_SHIFT );
    buffer[ 1 ] = bits2Char( bits );
  }
  // case for atleast  3 characters
  if ( count >= 3 ) {
    // ( bits & 0000 1111 ) << 4 = ( bits & 0x0F ) << 4 = 5678 0000
    bits = ( state->bytes[ 1 ] & MASK_3_1 ) << SHIFT_3;
    // bits | ( ( bits2 & 1100 0000 ) >> 4 )
    // bits | ( ( bits2 & 0xC0 ) >> 4 )
    // 5678 12 00
    bits = bits | ( ( state->bytes[ 2 ] & MASK_3_2 ) >> SHIFT_3 );
    buffer[ 2 ] = bits2Char( bits );
  }
  // case for atleast 4 characters
  if ( count == 4 ) {
    // ( bits & 0011 1111 ) << 2 = ( bits & 0x3F ) << 2 = 345678 00
    bits = ( state->bytes[ 2 ] & MASK_4 ) << SHIFT_4;
    buffer[ 3 ] = bits2Char( bits );
  }
  initState( state );
  return count;
}
