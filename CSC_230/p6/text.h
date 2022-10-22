/**
  @file text.h
  @author Grayson Gall (gsgall)
  Header for the Text subclass of vtype
*/


#ifndef TEXT_H
#define TEXT_H

#include "vtype.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
/** Subclass of VType for storing Text. */
typedef struct {
  /** Inherited from VType */
  void (*print)( struct VTypeStruct const *v );
  /** Inherited from VType */
  bool (*equals)( struct VTypeStruct const *a,
                  struct VTypeStruct const *b );
  /** Inherited from VType */
  unsigned int (*hash)( struct VTypeStruct const *v );
  /** Inherited from VType */
  void (*destroy)( struct VTypeStruct *v );
  /** Value stored by this integer. */
  char *val;
} Text;

/** Make an instance of Text holding a value parsed from the init string.
    @param init String containing the initializaiton value as text.
    @param n Optional return for the number of characters used from init.
    @return pointer to the new VType instance.
*/
VType *parseText( char const *init, int *n );

#endif
