// Napisati rekurzivnu funkciju koja posle svake neparne cifre
// datog broja dodaje 0.

#include <stdio.h>

long long odd10(long long x)
{
	if( x > 0 )
	{
		int cifra = x % 10;
		long long y = odd10(x/ 10) * 10 + cifra;

		if( cifra % 2 == 1 )
			y *= 10;

		return y;
	}

	return 0;
}

int main()
{
	printf("%lld", odd10(3326789));
	return 0;
}
