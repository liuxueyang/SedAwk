/*
 * =====================================================================================
 *       Filename : transfer.c
 *    Description : hex
 *    Version     : 0.1
 *        Created : 07/20/14 08:13
 *         Author : Liu Xue Yang (LXY), liuxueyang457@163.com
 *         Motto  : Suicide is Painless
 * =====================================================================================
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* 
 * ===  FUNCTION  ======================================================================
 *         Name: main
 * =====================================================================================
 */

	int
main ( int argc, char *argv[] )
{
	FILE *fp = fopen("in", "r");
//	FILE *fw = fopen("out", "w");
//	freopen("in", "r", stdin);

	char str[100];
	int i;
	fgets(str, 100, fp);
//	scanf ( "%s", str );
	for ( i = 0 ; i < strlen(str); ++i ) {
		printf ( " %02X", str[i] );
		if ( (i % 15 == 0) && (i != 0) ) {
			printf ( "\n" );
		}
	}
	printf ( "\n" );

		return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */

