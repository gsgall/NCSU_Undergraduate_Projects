#include "text.h"


static void print( VType const *v )
{
  Text const *this = ( Text const *)v;
  printf( "%s", this->val );
}

static bool equals( VType const *a, VType const *b )
{
  // comparing types with print functions
  if ( b->print != print )
    return false;
    // casting types for value comparison 
  Text const *this = ( Text const *)a;
  Text const *that = ( Text const *)b;

  return !strcmp( this->val, that->val );

}
// Algorithm Copied from wikipedia page with very slight
// modifications
static unsigned int hash( VType const *v )
{
  Text const *this = ( Text const * ) v;

  int length = strlen( this->val ) - 1;
  int i = 1;
  unsigned int hash = 0;

  while (i != length) {
    hash += this->val[i++];
    hash += hash << 10;
    hash ^= hash >> 6;
  }
  hash += hash << 3;
  hash ^= hash >> 11;
  hash += hash << 15;
  return hash;
}

static void destroy( VType *v )
{
    Text *this = ( Text * ) v;
    free( this->val );
    free( v );
}

VType *parseText( char const *init, int *n )
{
  int len = 0;
  int count = 0;

  bool first = false;
  bool last = false;
  // allocating object
  Text *this = ( Text* ) malloc( sizeof( Text ) );
  // allocating string
  this->val = ( char* ) malloc( sizeof( char ) );
  this->print = print;
  this->equals = equals;
  this->hash = hash;
  this->destroy = destroy;

  for( int i = 0; i < strlen( init ); i++ ) {

    // skipping initial spaces
    if ( isspace( init[ i ] ) && !first ){
      count++;
      continue;
    }
    // checking for first quote
    if ( init[ i ] == '\"' && !first ) {
      first = true;
      this->val[ 0 ] = init[ i ];
      len++;
      count++;
      continue;
    }
    // if char are before first quote return null
    if ( !isspace( init[ i ] ) && !first ) {
      destroy( (VType *) this );
      return NULL;
    }
    // Checking for final quote
    if ( init[ i ] == '\"' && first ) {
      if ( init[ i - 1 ] != '\\' ) {
        this->val = realloc( this->val, len + 1 );
        this->val[ len ] = init[ i ];
        len++;
        this->val = realloc( this->val, len + 1 );
        this->val[ len ] = '\0';
        count++;
        last = true;
        break;
      }
    }
    this->val = realloc( this->val, len + 1 );
    this->val[ len ] = init[ i ];
    len++;
    count++;
  }
  // checking for both paranethesis
  if ( first && !last ) {
    destroy( (VType *) this );
    return NULL;
  }
  if ( n )
    *n = count;

  return (VType *) this;
}
