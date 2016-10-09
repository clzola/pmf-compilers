// Napisati rekurzivnu funkciju koja racuna broj 
// parnih cifara datog celog broja

#include <stdio.h>

int neven(int x)
{
	if( x > 0 ) 
	{
		int cifra = x % 10;
		if( cifra % 2 == 0 )
			return 1 + neven(x / 10);
		else return neven(x/ 10);
	}
}

int main()
{
	printf("%d", neven(244356));
	return 0;
}
