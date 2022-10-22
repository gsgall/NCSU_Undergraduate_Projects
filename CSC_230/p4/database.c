/**
  @file database.c
  @author Grayson Gall ( gsgall )
  Implementation file for the database managment
*/
#include "database.h"

/**
  Function for growing the list in the database when needed
  When resized the list capacity is doubled
  @param database a pointer to the current database
  @return the database with the capacity of the list is doubled
*/
static Database *resizeList( Database *database )
{
  // dynamically allocating the new list length
  Employee *newList = ( Employee* ) malloc( sizeof( Employee ) * CAPACITY_FACTOR * database->capacity );
  // assigning the current list elements to the new list
  for ( int i = 0; i < database->capacity; i++ ) {
    newList[ i ] = database->list[ i ];
  }
  // freeing the old list
  free( database->list );
  // given the database the new list
  database->list = newList;
  // doubling the capacity marker
  database->capacity *= CAPACITY_FACTOR;
  return database;
}

Database *makeDatabase( Database *database )
{
  // initializing all fields of the database
  database->list = ( Employee* ) malloc( sizeof( Employee ) * MIN_CAPACITY );
  database->count = 0;
  database->capacity = MIN_CAPACITY;
  return database;
}

void freeDatabase( Database *database )
{
  // freeing the list
  free( database->list );
  // freeing the database
  free( database );
}

/**
  Error function for when an invalid employee file exits
  @param fp a pointer to the file that is being read
  @param filename the name of the file being read
  @param database the database that is being used
*/
void invalidFile( FILE *fp, char const *filename, Database *database )
{
  fprintf( stderr, "%s %s\n", INVALID_EMPLOYEE, filename );
  freeDatabase( database );
  exit( EXIT_FAILURE );
}

void readEmployees( char const *filename, Database *database )
{
  // opening the file
  FILE *stream = fopen( filename, "r" );
  // case for file with issue
  if ( stream == NULL ) {
    fprintf( stderr, "Can't open file: %s\n", filename );
    freeDatabase( database );
    exit( EXIT_FAILURE );
  }
  // Pointer to the line currently being read
  char* line;
  // the idx of the next available spot in the list
  int i = database->count;
  // a pointer to the list
  Employee *list = database->list;
  while ( ( line = readLine( stream ) ) ) {
    // growing list if needed
    if ( database->count == database->capacity ) {
      resizeList( database );
      // updating list pointer
      list = database->list;
    }

    int pos = 0;
    int prev = 0;
    // checking and getting the id
    if ( sscanf( line, "%[0-9] %n", list[ i ].id, &pos ) != 1 ||
         strlen( list[ i ].id ) != ID_LENGTH ) {
      invalidFile( stream, filename, database );
    }
    prev = pos;
    // checking and getting the firstName
    if ( sscanf( line + prev, "%s %n", list[ i ].firstName, &pos) != 1 ||
         strlen( list[ i ].firstName ) > STRING_LENGTH ) {
      invalidFile( stream, filename, database );
    }
    // checking and getting the lastName
    prev += pos;
    if ( sscanf( line + prev, "%s %n", list[ i ].lastName, &pos) != 1 ||
         strlen( list[ i ].lastName ) > STRING_LENGTH ) {
      invalidFile( stream, filename, database );
    }
    // checking and getting the skill
    prev += pos;
    if ( sscanf( line + prev, "%s\n", list[ i ].skill ) != 1 ||
         strlen( list[ i ].skill ) > STRING_LENGTH ) {
      invalidFile( stream, filename, database );
    }
    // giving the employee the available status
    sscanf( DEFAULT_AVAILABILITY, "%s", list[ i ].assignment );
    database->count++;
    free( line );
    i++;
  }
  // updating the database list
  database->list = list;
  fclose( stream );
}

void listEmployees( Database *database, int (*compare)( void const *va, void const *vb ), bool (*test)( Employee const *emp, char const *str ), char const *str )
{
  // printing the table header
  printf( "%-4s %-15s %-15s %-15s %-s\n", ID, FIRST_NAME, LAST_NAME, SKILL, ASSIGNMENT);
  // sorting database list with comparison function
  sortDatabase( database, compare );
  // checking each element if it should be printed
  for ( int i = 0; i < database->count; i++ ) {
    Employee curr = database->list[ i ];
    if ( test( &curr, str ) ) {
      printf( "%-4s %-15s %-15s %-15s %-20s\n", curr.id, curr.firstName, curr.lastName, curr.skill, curr.assignment);
    }
  }
  printf( "\n" );
}

void sortDatabase( Database *database, int (*compare)( void const *va, void const *vb ) )
{
  qsort( (void*)database->list, database->count, sizeof( database->list[ 0 ] ), compare );
}
