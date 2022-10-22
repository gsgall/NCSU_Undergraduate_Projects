/**
  @file agency.c
  @author Grayson Gall ( gsgall )
  File contains the main function for running the agency program.
  File contains other comporison and sorting functions for database management
*/
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "database.h"
#include "input.h"
/** String for comparison for the list command */
#define LIST_CMD "list"
/** String for comparison for listing employees by skill */
#define SKILL_LIST "skill"
/** String for comparison for listing employees by assignment */
#define ASSIGNMENT_LIST "assignment"
/** String for comparison for the assign command */
#define ASSIGN_CMD "assign"
/** String for comparison for the unassign command */
#define UNASSIGN_CMD "unassign"
/** String for comparison for quitting the program */
#define QUIT_CMD "quit"
/** Starting character for checking to make sure that the  id only numbers */
#define NUM_START '0'
/** Ending character for checking to make sure that the  id only numbers */
#define NUM_END '9'
/** Error message for invalid commands */
#define INVALID_CMD "Invalid command\n\n"

/**
  Comparison for two employees. Function compares employees by id only
  @param va the first employee to be used in the comparison
  @param vb the second employee to be used in the comparison
  @return -1 if va should appear vb, 0 if the two have the same id, 1 if va
          should appear after vb
*/
static int compareById( void const *va, void const *vb )
{
  int ida;
  int idb;
  // Getting the ids as integer types
  sscanf( ( ( Employee* )va )->id, "%d", &ida );
  sscanf( ( ( Employee* )vb )->id, "%d", &idb );
  // comparing the ids
  if ( ida < idb ) {
    return -1;
  }
  if ( ida > idb ) {
    return 1;
  }
  return 0;
}

/**
  Comparison for two employees. Function compares employees by skill first and
  for two employees with the same skills they are compared by id
  @param va the first employee to be used in the comparison
  @param vb the second employee to be used in the comparison
  @return -1 if va should appear before vb, 0 if the two have the same id and
          skill, 1 if va should appear after vb
*/
static int compareBySkill( void const *va, void const *vb )
{
  // comparing both employees skills
  int result = strcmp( ( (Employee*)va )->skill, ( (Employee*)vb )->skill );
  if ( result < 0 ) {
    return -1;
  } else if ( result  > 0 ) {
    return 1;
  } else {
    // comparing by id if both skills are the same
    return compareById( va, vb );
  }
}

/**
  Function expects the list of the database to be ascending order by id and
  checks if there are two empoyees with the same id. If the program makes it
  through the function then there are no duplicate ids
  @param database the database to be checked
  @param filename the file that the employee list is being read from for error
         message printing
*/
static void findDuplicates( Database *database, char *filename )
{
  // getting the list for reading
  Employee *list = database->list;
  for ( int i = 0; i < database->count; i++ ) {
    // special case for the first element
    if ( i == 0 ) {
      if ( !strcmp( list[ i ].id, list[ i + 1 ].id ) ) {
        fprintf( stderr, "Invalid employee file: %s\n", filename );
        exit( EXIT_FAILURE );
      }
    // special case for the last element
    } else if ( i == database->count - 1 ) {
      if ( !strcmp( list[ i ].id, list[ i - 1 ].id ) ) {
        fprintf( stderr, "Invalid employee file: %s\n", filename );
        exit( EXIT_FAILURE );
      }
    // case for the rest of the elements
    } else {
      if ( !strcmp( list[ i ].id, list[ i - 1 ].id ) || !strcmp( list[ i ].id, list[ i + 1 ].id ) ) {
        fprintf( stderr, "Invalid employee file: %s\n", filename );
        exit( EXIT_FAILURE );
      }
    }
  }
}

/**
  Test for the list command when the entire list is being asked to be printed
  @param e required param for list command it is not needed for this function
           and NULL should be passed to this function
  @param str required param for list function it is not needed and NULL should
             be passed
  @return will always return true to enable printing
*/
static bool printAllTest( const Employee *e, const char *str )
{
  return true;
}

/**
  Test for the list command when printing employees by skill is desired
  @param e the employee to be checked for printing
  @param str the skill that should be printed
  @return returns true if employee should be printed and false if not
*/
static bool skillTest ( const Employee *e, const char *str )
{
 return !strcmp( e->skill, str );
}

/**
  Test for the list command when printing employees by assignment is desired
  @param e the employee to be checked for printing
  @param str the skill that should be printed
  @return returns true if employee should be printed and false if not
*/
static bool assignmentTest ( const Employee *e, const char *str )
{
  return !strcmp( e->assignment, str );
}

/**
  Function used to read user provided commands from std in
  @return the most recent line of user provided string. returns NULL if there is
          no input left to be read
*/
static char *getCmd()
{
  printf( "cmd> ");
  char *cmd = readLine( stdin );
  // if there is a user provided line it is echoed
  if ( cmd ) {
    printf( "%s\n", cmd );
  }
  return cmd;
}

/**
  Searching function for the employee list. Expects the list to be sorted in
  ascending order by id. Implements the binary serach algorithm
  @param list list of employees in sorted order by id
  @param id the id of the employee that is being searched for
  @param startIdx the starting idx of the section of the list that is searched
  @param endIdx the ending idx of the section of the list that is searched
  @return If the employee is in the list a pointer to that employee is returned
          If not there is no employee in the list then a NULL is returned
*/
static Employee *binarySearch( Employee *list, char* id, int startIdx, int endIdx )
{
  // checking to make sure we can still search
  if ( startIdx <= endIdx ) {
    // getting the mid point
    int idx = startIdx + ( ( endIdx - startIdx ) / 2 );
    // getting the id of the employee at the mid point
    char *currId = list[ idx ].id;
    // case for id matching
    if ( !strcmp( id, currId ) ) {
      return &list[ idx ];
    }
    // case for searching lower half of list segment
    if ( strcmp( id, currId ) < 0 ) {
      return binarySearch( list, id, startIdx, idx - 1 );
    }
    // case for searching upper half of list segment
    if ( strcmp( id, currId ) > 0 ) {
      return binarySearch( list, id, idx + 1, endIdx );
    }
  }
  // case when there is no employee with the given id in the list
  return NULL;
}

/**
  Function for checking for valid ids in commands
  An id is considered valid if there is an employee in the list, is 4 digits and
  no non-digit characters in the id string
  @param database the database of employees
  @param id the id in question
  @return If employee is in the list then a pointer to that employee is returned
          If employee is not in the list or id is invalid NULL is returned
*/
static Employee *checkId( Database *database, char *id )
{
  // make sure id is correct length
  if ( strlen( id ) != ID_LENGTH ) {
    return NULL;
  }
  // making sure there are no non-digit characters in the id
  for (int i = 0; i < ID_LENGTH; i++ ) {
    if ( id[ i ] < NUM_START || id[ i ] > NUM_END ) {
      return NULL;
    }
  }
  // searching for the employee in the list
  return binarySearch( database->list, id, 0, database->count - 1 );
}

/**
  Function for completing desired assignment given by the user.
  An employee will be assigned if the employee does not currently have an
  assignment.
  @param e the employee that should be assigned to a given assignment
  @param assignment the job that the employee should be assigned
  @return true if the assignment was successful false if not
*/
static bool assign( Employee *e, char *assignment )
{
  // checking for an assignment that may be too long or an empty string
  if ( strlen( assignment ) > ASSIGNMENT_LENGTH || strlen( assignment ) == 0 ) {
    return false;
  }
  // Checking if the employee has already been assigned
  if ( strcmp(e->assignment, DEFAULT_AVAILABILITY ) != 0 ) {
    return false;
  }
  // performing the assignment if it is available
  sscanf( assignment, "%s", e->assignment );
  return true;
}

/**
  Function for completing the desired unassignment given by the user
  An employee cannot be unassigned if they do not current have an assignment
  @param e the employee that should be unassigned
  @return true if the assignment was successful false if not
*/
static bool unassign( Employee *e ) {
  // checking if the employee has an assignment
  if ( !strcmp( e->assignment, DEFAULT_AVAILABILITY ) ) {
    return false;
  }
  // performing the unassignment
  sscanf( DEFAULT_AVAILABILITY, "%s", e->assignment );
  return true;
}

/**
  Main function for the agency program
  @param argc the number of arguments passed by the user
  @param argv an array of the strings of user pass arguments
  @return the exit status of the program
*/
int main( int argc, char *argv[] ){
  // if no files are provided
  if ( argc == 1 ) {
    fprintf( stderr, "usage: agency <employee-file>*\n");
    exit( EXIT_FAILURE );
  }
  // Initializing array for file pointers
  Database *database = ( Database* ) malloc( sizeof( Database ) );
  database = makeDatabase( database );
  // opening each file
  for ( int i = 1; i < argc; i++ ) {
    readEmployees( argv[ i ], database );
    sortDatabase( database, compareById );

    if ( database->count > 1 ) {
      findDuplicates( database, argv[ i ] );
    }
  }
  // initializing the command string
  char *cmd;
  // continuing while user is providing input
  while( (cmd = getCmd() ) ) {
    // case for quit command or EOF
    if ( !strcmp( cmd, QUIT_CMD ) || cmd == NULL ) {
      // freeing memory that has been dynamically allocated
      free( cmd );
      freeDatabase( database );
      return EXIT_SUCCESS;
    // case for listing all of the employees
    } else if ( !strcmp( cmd, LIST_CMD ) ) {
      listEmployees( database, compareById, printAllTest, NULL );
    // case for other commands
    } else {
      // strings that are longer than limits for error checking
      char mainCmd[ strlen( UNASSIGN_CMD ) + 1 ];
      char secondCmd[ strlen( ASSIGNMENT_LIST ) + 1 ];
      char thirdCmd[ ASSIGNMENT_LENGTH + 1 ];
      // indicies for searchign different parts of strings
      int pos = 0;
      int prev = 0;
      // getting the first part of the user command and error checking
      if ( sscanf( cmd, "%s %n", mainCmd, &pos ) != 1 ) {
        printf( "%s", INVALID_CMD );
        free( cmd );
        continue;
      }
      // getting the second part of the user command and error checking
      prev += pos;
      if ( sscanf( cmd + prev, "%s %n", secondCmd, &pos ) != 1 ) {
        printf( "%s", INVALID_CMD );
        free( cmd );
        continue;
      }

      prev += pos;
      // getting the optional third argument from the user
      sscanf( cmd + prev, "%s %n", thirdCmd, &pos );
      prev += pos;
        // case for first argument being list
        if ( !strcmp( LIST_CMD, mainCmd ) ){
          // checking to make sure there are no extra arguments
          if ( prev != strlen( cmd ) ) {
            printf( "%s", INVALID_CMD );
            free( cmd );
            continue;
          // case for listing by skill
          } else if ( !strcmp( SKILL_LIST, secondCmd ) ) {
            listEmployees( database, compareBySkill, skillTest, thirdCmd );
          // case for listing by assignment
          } else if ( !strcmp( ASSIGNMENT_LIST, secondCmd ) ) {
            listEmployees( database, compareBySkill, assignmentTest, thirdCmd );
          // case for other invalid arguments
          } else {
            printf( "%s", INVALID_CMD );
            free( cmd );
            continue;
          }
        // case for other first commands
        } else {
          sortDatabase( database, compareById );
          Employee *e = checkId( database, secondCmd );
          if ( !e ) {
            printf( "%s", INVALID_CMD );
            free( cmd );
            continue;
          }
          // case for assign command
          if ( !strcmp( ASSIGN_CMD, mainCmd ) ) {
            if ( !assign( e, thirdCmd ) ) {
              printf( "%s", INVALID_CMD );
              free( cmd );
              continue;
            } else {
              printf( "\n");
            }
          // case for unassign command
          } else if ( !strcmp( UNASSIGN_CMD, mainCmd ) ) {
            if ( !unassign( e ) ) {
              printf( "%s", INVALID_CMD );
              free( cmd );
              continue;
            } else {
              printf( "\n");
            }
          // case for other invlaid commands
          } else {
            printf( "%s", INVALID_CMD );
            free( cmd );
            continue;
          }
        }
      }
    // freeing current command line
    free( cmd );
  }
  // freeing last command line
  free( cmd );
  // freeing database memory
  freeDatabase( database );
  return EXIT_SUCCESS;
}
