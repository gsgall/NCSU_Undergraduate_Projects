/**
    @file map.h
    @author
    Header for the map component, a hash map.
*/

#ifndef MAP_H
#define MAP_H

#include "vtype.h"
#include <stdbool.h>

/** Incomplete type for the Map representation. */
typedef struct MapStruct Map;

/** Make an empty map.
    @param len Initial length of the hash table.
    @return pointer to a new map.
*/
Map *makeMap( int len );

/** Get the size of the given map.
    @param m Pointer to the map.
    @return Number of key/value pairs in the map. */
int mapSize( Map *m );

/**
  Sets entries in the maps table. To a given key and val pair. Handles the garbage
  collection of the key and value pairs as well. If a key alraedy exits then the
  value at that key will be overwritten
  @param m the map to add to
  @param key the key value that will be modified or added to the map
  @parm val the value that will be associated with the given key
*/
void mapSet( Map *m, VType *key, VType *val );

/** Return the value associated with the given key. The returned VType
    is still owned by the map.
    @param m Map to query.
    @param k Key to look for in the map.
    @return Value associated with the given key, or NULL if the key
    isn't in the map.
*/
VType *mapGet( Map *m, VType *key );

/**
  Removes key value pairs from the map and updates size. If key is not in map
  nothing is changed and false if returned. On success true is returned
  @param m the map to modify
  @param key the key we are searching for in the map
  @return boolean true if key was removed false if not
*/
bool mapRemove( Map *m, VType *key );

/** Free all the memory used to store a map, including all the
    memory in its key/value pairs.
    @param m The map to free.
*/
void freeMap( Map *m );

#endif
