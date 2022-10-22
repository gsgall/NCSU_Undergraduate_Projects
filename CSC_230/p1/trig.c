/**
    @file trig.c
    @author Grayson Gall (gsgall)
    Program will take an angle between -pi and pi radians and make progressively
    more accurate approximations of sine, cosine and tangent for the given angle.
    Once the differnce between the previous and current approximation is less
    than 1e-6 for both cosine and sine the program exits.
*/
#include <stdio.h>
#include <stdlib.h>

/** Approximation of PI.  For now, we're using our own constant for
    this. There's also one provided by the gnu math library, once we
    learn about that.
*/
#define PI 3.14159265358979323846

/** Will be used to help alternate the signs terms in taylor series */
#define SIGN 1
/** For modulous operations to test is a number is even or not */
#define EVEN 2
/** The max error between two approximations before the program stops */
#define MAX_ERROR 1e-6
/** The number of characters wide the display column is for the terms  */
#define TERMS_WIDTH 6
/** The number of characters wide the display columns for each function are */
#define COLUMN_WIDTH 13
/** The number of functions being approximated */
#define NUM_FUNC 3
/** A number out of range that will be returned if NAN angle is given */
#define INVALID -10
/** The character for the intersection of rows and cols in the table */
#define INTERSECTION_CHAR '+'
/** The character for horizontal seperation in the table */
#define HORIZ_SEPERATOR '-'
/** The character for vertical seperation of coumns in the table */
#define VERT_SEPERATOR '|'


/**
    This function will get the angle that the user wants to evaulate the
    functions at. Function returns INVALID if user provides an input that is not
    a number
    @return a double, the angle that the user wants to approximate
*/
double getAngle()
{
    // initializing the varibale to store the angle
    double angle;
    // getting the angle from the user
    int matches = scanf("%lf", &angle );
    // if the input is not a number return the defualt invalid marker
    if ( matches == 0 ) {
        return INVALID;
    }
    // return the angle if it is a number
    return angle;
}

/**
    Function returns the absolute value of the difference between two given
    values
    @param a the first number used to find the difference
    @param b the second number used to find the difference
    @return the absolute value of the difference between the two numbers
*/
double diff( double a, double b )
{
    // finding the signed difference between the two
    double diff = a - b;
    // if the difference is negative make it positive
    if ( diff < 0 ) {
        return -diff;
    }
    return diff;
}

/**
    Function will compute the factorial of the given integer
    @param n the number for the factorial desired
    @return the factorial of n
*/
unsigned long long  fact( int n )
{
    // initializing to an unsigned long long to help avoid overflow
    unsigned long long  ans = 1;
    // calculating the factorial
    for ( int i = 1; i <= n; i++ ) {
        ans *= i;
    }
    return ans;
}


/**
    Function will raise the base to power of n
    @param base the base number that you want to exponential
    @param n the power to raise the base to
    @return the base raised to the power n
*/
long double raise( double base, int n )
{
    // using a long double to avoid overflow issues
    long double ans = 1;
    // multiplying the base to the current answer n times
    for ( int i = 0; i < n; i++) {
        ans *= base;
    }
    return ans;
}

/**
    A taylor series approximation for the function cosine
    @param angle the angle where the function will be evaulated
    @param terms the number of terms to be included in approximation
    @return the approximation of the function cosine
*/
long double cosine( double angle, int terms )
{
    // intialiing the approximation
    long double sum = 0;
    // getting the sign for the first term in the series
    int sign = SIGN;
    for ( int i = 0; i < terms; i++ ) {
        // excluding all odd terms for the series
        if ( i % EVEN == 0) {
            // adding the next term to the series
            sum += sign * raise( angle, i ) / fact( i );
            // flipping the sign for the next term
            sign *= -SIGN;
        }
    }
    return sum;
}

/**
    A taylor series approximation for the function sine
    @param angle the angle where the function will be evaulated
    @param terms the number of terms to be included in approximation
    @return the approximation of the function sine
*/
long double sine( double angle, int terms )
{
    // intialiing the approximation
    long double sum = 0;
    // getting the sign for the first term in the series
    int sign = SIGN;
    for ( int i = 0; i < terms; i++ ) {
        // excluding all even terms for the series
        if ( i % EVEN != 0) {
            sum += sign * raise( angle, i ) / fact( i );
            // flipping the sign for the next term
            sign *= -SIGN;
        }
    }
    return sum;
}

/**
    Function to print the table header of the output table
*/
void tableHeader()
{
    // printing the labels all seperated by the seperator
    printf( "terms %c %11s %c %11s %c %11s \n", VERT_SEPERATOR, "sin",
                                               VERT_SEPERATOR, "cos",
                                               VERT_SEPERATOR, "tan" );
    // printing the lower seperator line for the terms section
    for ( int i = 0; i < TERMS_WIDTH; i++ ) {
        printf( "%c", HORIZ_SEPERATOR );
    }
    // printing the char for an intersection of vert and horizontal lines
    printf( "%c", INTERSECTION_CHAR );
    // looping for the number of functions we are approximating
    for ( int i = 0; i < NUM_FUNC; i++ ) {
        // printing horizontal seperators for the column width
        for ( int j = 0; j < COLUMN_WIDTH; j++ ) {
            printf( "%c", HORIZ_SEPERATOR );
        }
        // for all but the last column we print an intersection char at the end
        if ( i < NUM_FUNC - 1 ) {
            printf( "%c", INTERSECTION_CHAR );
        }

    }
    putchar( '\n' );
}

/**
    Function to print each successive row of the output table
    @param terms the number of terms used in the approximation
    @param s the approximation of sine
    @param c the approximation of cosine
    @param t the approximation of tangent
*/
void tableRow( int terms, double s, double c, double t )
{
    // printing the chars with the specified char widths
    printf( "%5d %c %11.7f %c %11.7f %c %11.7f\n", terms, VERT_SEPERATOR, s,
                                                          VERT_SEPERATOR, c,
                                                          VERT_SEPERATOR, t );
}

/**
    Main function that gets approximations until the difference between
    successive approximations is less then MAX_ERROR
  */
int main()
{
    // gettting the angle
    double angle = getAngle();
    // checking that the angle is in the bounds
    if (angle < -PI || angle > PI || angle == EOF) {
        // exiting program for invalid angle
        printf( "Invalid input\n" );
        return EXIT_FAILURE;
    }
    // starting by approximating with one term
    int terms = 1;
    // getting the initial approximations
    double currSin = sine( angle, terms );
    double currCos = cosine( angle, terms );
    double tan = currSin / currCos;
    // initializing to store the prev approximations
    double prevSin = 0;
    double prevCos = 0;
    // setting variables for the difference to 1 to start loop
    double cosDiff = 1;
    double sinDiff = 1;
    // printing the table header
    tableHeader();
    // printing the 1 term approximations
    tableRow( terms, currSin, currCos, tan );
    // looping until the desired accuracy
    while ( cosDiff > MAX_ERROR || sinDiff > MAX_ERROR ) {
        // increment the number of terms
        terms++;
        // storing the current approximations
        prevCos = currCos;
        prevSin = currSin;
        // getting new approximations
        currCos = cosine( angle, terms );
        currSin = sine( angle, terms);
        tan = currSin / currCos;
        // printing results
        tableRow( terms, currSin, currCos, tan );
        // updating the difference 
        cosDiff = diff( currCos, prevCos );
        sinDiff = diff( currSin, prevSin );
    }

    return EXIT_SUCCESS;
}
