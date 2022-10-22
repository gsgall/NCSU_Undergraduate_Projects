/**
  @file database.h
  @author Grayson Gall ( gsgall )
  Header file for the database managment
*/
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "input.h"
/** the allowed length of the id  */
#define ID_LENGTH 4
/** the allowed length of all string parameters other than assignment */
#define STRING_LENGTH 15
/** the allowed length of the assignment field */
#define ASSIGNMENT_LENGTH 20
/** The minimum capacity of the database list */
#define MIN_CAPACITY 5
/** Error message for an invalid employee list */
#define INVALID_EMPLOYEE "Invalid employee file:"
/** The string for default assignments */
#define DEFAULT_AVAILABILITY "Available"
/** The string for the ID table header */
#define ID "ID"
/** The string for the first name table header */
#define FIRST_NAME "First Name"
/** The string for the Last name table header */
#define LAST_NAME "Last Name"
/** The string for the skill table header */
#define SKILL "Skill"
/** The string for the Assignment table header */
#define ASSIGNMENT "Assignment"
/** The factor by which the list will grow when being resized */
#define CAPACITY_FACTOR 2
/** Structure for each employees */
typedef struct EmployeeStruct {
  char id[ ID_LENGTH + 1 ];
  char firstName[ STRING_LENGTH + 1 ];
  char lastName[ STRING_LENGTH + 1 ];
  char skill[ STRING_LENGTH + 1 ];
  char assignment[ ASSIGNMENT_LENGTH + 1 ];
} Employee;

/** Structure for the database */
typedef struct DatabaseStruct {
  Employee* list;
  int count;
  int capacity;
} Database;

/**
  Function dynamically allocates the memory for the initial database
  @param database a pointer to where the memory will be allocated
  @return the database pointer after allocation
*/
Database *makeDatabase( Database *database );

/**
  Freeing the database memory that has been allocated
  @param database the database to be freed
*/
void freeDatabase( Database *database );

/**
  Function reads the employees from a file that stores the employee data and
  stores them in the database list
  @param filename the name of the file where the data is being stored
  @param database the database where the employees will be stored
*/
void readEmployees( char const *filename, Database *database );

/**
  Function for listing employees with some ways desired by the user
  @param database the database in which the employees are stored
  @param compare a pointer to the comparison function being used for printing
  @param test a pointer to the function that determines if an employee should be
         displayed
  @param str a comparison string to be used in the compare function
*/
void listEmployees( Database *database, int (*compare)( void const *va, void const *vb ), bool (*test)( Employee const *emp, char const *str ), char const *str );

/**
  Function for sorting the database by the desired methods
  @param database the database that should be sorted
  @param compare a pointer to the comparison function to be used by qsort
*/
void sortDatabase( Database *database, int (*compare)( void const *va, void const *vb ) );
