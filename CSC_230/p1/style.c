/**
    @author Grayson Gall (gsgall)
    @file style.c
    File generates and prints a paragraph of randomly generated words that is
    10 lines long and then prints the total number of words that appear in the
    text 
*/

#include <stdio.h>
#include <stdlib.h>
/** the maximum number of characters on a line */
#define MAX_LENGTH 72

/**
    Function prints a randomly generated word made up of lower case letters
    @param x the length of the word
*/
void printWord( int x )
{
    //printing random letters until the word length has been reached
    for ( int i = 0; i < x; i++ ) {
        // Print a random lower-case letter.
        printf( "%c", 97 + rand() % 26 );
    }
}

/**
    Function prints a randomly generated line of random words
*/
int printLine()
{
    // for storing the number of words in the line
    int count = 0;
    // For storing where we are in the line
    int pos = 0;
    // Provides logic for that allows for spaces to be printed
    int space = 0;
    // Getting a random length of the first word
    int len = 1 + rand() % 10;
    // Print a line of words up to a limited length.
    while ( pos + len + space < MAX_LENGTH ) {
        // if it is not the first word print a space before it
        if ( space > 0 ) {
            printf( " " );
        }
        // Print a randomly generator word of length len
        printWord( len );
        // Shifting the position count to account for the last word
        pos += len + space;
        // getting a new length for the next word
        len = 1 + rand() % 10;
        // allowing spaced to be printed
        space = 1;
        // updating the number of words in this line
        count += 1;
    }
    // ending the line
    printf( "\n" );
    // returning the total number of words in the line
    return count;
}

/**
    Function prints a paragraph of randomly generated words with n lines of
    text in the paragraph
    @param n the number of lines to be printed
    @return the total number of words that have been printed in the paragraph
*/
int printParagraph( int n )
{
    // initializing the total word count
    int total = 0;
    // printing n lines of text
    for ( int i = 0; i < n; i++ ) {
        // incrementing the total word count
        total += printLine();
    }
        // returning the total number of words printed
    return total;
}

/**
    Main prints a paragraph of randomly generated text that is 10 lines long
    Then the total number of words in the paragraph are printed
    @return program returns EXIT_SUCCESS if no errors occur
*/
int main()
{
    // printing the paragraph and storing the total number of words in it
    int w = printParagraph(10);
    // printing the total number of words that appear in the text
    printf("Words: %d\n",w);
    // exiting the program
    return EXIT_SUCCESS;
}
