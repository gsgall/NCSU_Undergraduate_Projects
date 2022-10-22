/**
    @file map.c
    @author Grayson Gall (gsgall)
    Hash table implementation of a map.
*/

#include "map.h"
#include <stdlib.h>
#include <stdio.h>
#include "vtype.h"

/** Node containing a key / value pair. */
typedef struct NodeStruct {
  /** Pointer to the key part of the key / value pair. */
  VType *key;

  /** Pointer to the value part of the key / value pair. */
  VType *val;

  /** Pointer to the next node at the same element of this table. */
  struct NodeStruct *next;
} Node;

/** Representation of a hash table implementation of a map. */
struct MapStruct {
  /** Table of key / value pairs. */
  Node **table;

  /** Current length of the table. */
  int tlen;

  /** Current size of the map (number of different keys). */
  int size;
};

Map *makeMap( int len )
{
  // allocating map
  Map *m = (Map *) malloc( sizeof( Map ) );
  // initializing variables
  m->size = 0;
  m->tlen = len;
  m->table = ( Node ** ) malloc( sizeof( Node * ) * len );
  for ( int i = 0; i < len; i++ ) {
    m->table[ i ] = NULL;
  }
  return m;
}

int mapSize( Map *m )
{
  return m->size;
}

void mapSet( Map *m, VType *key, VType *val )
{
  // getting index in table
  unsigned int idx = key->hash( key ) % m->tlen;
  // checking for no entries at the table
  if ( m->table[ idx ] == NULL ) {
    m->table[ idx ] = ( Node* ) malloc( sizeof( Node ) );
    m->table[ idx ]->key = key;
    m->table[ idx ]->val = val;
    m->table[ idx ]->next = NULL;
    m->size++;
  } else {
    // if key exists remove it to garbage collect
    mapRemove( m, key );
    // if table entry is no emply use new values
    if ( m->table[ idx ] == NULL ) {
      m->table[ idx ] = ( Node* ) malloc( sizeof( Node ) );
      m->table[ idx ]->key = key;
      m->table[ idx ]->val = val;
      m->table[ idx ]->next = NULL;
      m->size++;
      return;
    }
    // navigate to end of the table list
    Node* tmp = m->table[ idx ];
    while( tmp && tmp->next != NULL) {
      tmp = tmp->next;
    }
    tmp->next = ( Node* ) malloc( sizeof( Node ) );
    tmp->next->key = key;
    tmp->next->val = val;
    tmp->next->next = NULL;
    m->size++;
  }
}

VType *mapGet( Map *m, VType *key )
{
  // get table idx
  unsigned int idx = key->hash( key ) % m->tlen;
  Node *tmp = m->table[ idx ];
  // if entry is empty
  if ( !tmp )
    return NULL;
  // nagivate until key has been reached
  while( tmp->next && !key->equals( key, tmp->key ) ) {
    tmp = tmp->next;
  }
  // if reached the end of the list value is not present
  if ( !tmp )
    return NULL;
    // if found
  if ( key->equals( key, tmp->key ) ) {
    return tmp->val;
  }

  return NULL;
}

bool mapRemove( Map *m, VType *key )
{
  // getting table entry list
  unsigned int idx = key->hash( key ) % m->tlen;
  Node *tmp = m->table[ idx ];
  // if list is empty
  if ( !tmp )
    return false;
  // edge case for first element equality
  if ( key->equals( key, tmp->key ) ) {
    tmp->key->destroy( tmp->key );
    tmp->val->destroy( tmp->val );
    m->table[ idx ] = tmp->next;
    free( tmp );
    m->size--;
    return true;
  }
  // navigate until key matches
  while( tmp->next && !key->equals( key, tmp->next->key ) ) {
    tmp = tmp->next;
  }
  // if not in list
  if ( tmp->next == NULL ) {
    return false;
  }
  // if foudn
  if ( key->equals( key, tmp->next->key ) ) {
    // store value to be removed
    Node* trash = tmp->next;
    // if it is a middle element remove it from list
    if ( trash != NULL ) {
      tmp->next = tmp->next->next;
    } else {
      // for ending element
      tmp->next = NULL;
    }
    // free memory
    trash->key->destroy( trash->key );
    trash->val->destroy( trash->val );
    free( trash );
    // decriment size
    m->size--;
    return true;
  }

  return false;
}

void freeMap( Map *m )
{
  // going through each table entry
  for ( int i = 0; i < m->tlen; i++ ) {
    Node* curr = m->table[ i ];
    Node* prev = NULL;
    // navigating each node in the linked list
    while( curr ) {
      prev = curr;
      curr = curr->next;
      prev->key->destroy( prev->key );
      prev->val->destroy( prev->val );
      free( prev );
    }
  }
  free( m->table );
  free( m );
}
