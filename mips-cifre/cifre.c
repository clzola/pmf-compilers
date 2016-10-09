/**
 * Napisati rekurzivnu funkciju koja prikazuje sve cifre
 * datog celog broja i to:
 *   a) s leva na desno
 *   b) s desna na levo
 */

#include <stdio.h>

// Right to Left
void print_number_rl(int x)
{
	if ( x != 0 )
	{
		int cifra = x % 10;
		printf("%d", cifra);
		print_number_rl( x / 10 );
	}
}

// Left to Right
void print_number_lr(int x)
{
	if( x != 0 )
	{
		int cifra = x % 10;
		print_number_lr( x / 10 );
		printf("%d", cifra);
	}
}

int main()
{
	print_number_lr(3456);
	printf("\n");

	print_number_rl(3456);
	printf("\n");
	return 0;
}
