// Factorijel

#include <stdio.h>

int factoriel(int n)
{
	if( n == 1)
		return 1;
	return n * factoriel(n-1);
}

int main()
{
	printf("%d\n", factoriel(5));
	return 0;
}
