/**
    @file textbox.
    @author Grayson Gall (gsgall)
    This program reads lines of text from a file and then prints our the text in
    the file in a box where each line in the box is limited to a maximum of 60
    characters long. The box will be bordered with the * character. Any
    characters after the 60 limit will not be included in the new box. If the
    line has less than 60 characters then the extra space will be padded with
    spaces.
*/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

/** Width of each line of text in the box. */
#define LINE_WIDTH 60
/** Width of the top and bottom borders of the box. */
#define BORDER_WIDTH 62
/** Symbol used to draw the border around the box. */
#define BORDER '*'
/** The outer width of the border walls that will surround the text. */
#define WALL_WIDTH 1
/** The space character will be used to fill space at the end of shorter lines */
#define FILLER ' '
/** This character will define the end of a line of text */
#define EOL '\n'

/**
    Function prints a line of the same characters
    @param ch the character to be printed
    @param count the number of times the character will be printed
*/
void lineOfChars( char ch, int count )
{
    // Looping to prinr count times
    for ( int i = 0; i < count; i++) {
        // printing the desired character
        putchar( ch );
    }
    // printing the new line character
    putchar( EOL );
}

/**
    Function will get characters from text files until either the end of line
    or 60 characters have been reached. If less than 60 characters are found in
    a line the rest of the space will be filled by spaces. Function will return
    true until EOF has been reached
    @return boolean false if EOF has been reached at the end of a line true if not
*/
bool paddedLine()
{
    // reading the first character in the file
    char curr = getchar();
    // initializign to keep track of the number of characters on the line
    int charCount = 0;
    // if there are characters in the file then we print the first boreder
    if (curr != EOF ) {
        putchar( BORDER );
    }
    // Looping until the end of the line or file has been reached
    while ( curr != EOF && curr != EOL ) {
        // if there are less than 60 chars printed then print the curr char
        if (charCount < LINE_WIDTH ) {
            putchar( curr );
        }
        // getting the next char and incrementing the count
        curr = getchar();
        charCount++;
    }
    // if there are less than 60 chars on a line then fill the rest with spaces
    if ( charCount < LINE_WIDTH && curr != EOF ) {
        for ( int i = 0; i < LINE_WIDTH - charCount; i++) {
            putchar( FILLER );
        }
    }
    // once the end of the line has been reached print the closing border
    if (curr == EOL ) {
        lineOfChars( BORDER, WALL_WIDTH );
        // return true since the curr char is not EOF
        return true;
    }
    // returns false if the curr char is EOF
    return false;
}

/**
    Main is resposinle for calling all helper functions. If main runs
    successfully then the input text will be put into a box surrounded by the
    * character
    @return main returns 0 if it runs successfully if it returns any thing else
            there is an error
*/
int main()
{
    // printing the top border
    lineOfChars( BORDER, BORDER_WIDTH );
    // getting the first line
    bool moreLines = paddedLine();
    // if there is more than one line get lines until EOF
    while ( moreLines ) {
        moreLines = paddedLine();
    }
    // printing the bottom border
    lineOfChars( BORDER, BORDER_WIDTH );
    // program has finished successfully
    return EXIT_SUCCESS;
}
