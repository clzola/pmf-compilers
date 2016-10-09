// Suma svih brojeva od 0 do n

#include <stdio.h>

int suma(int n)
{
	if( n > 0 )
		return n + suma( n - 1 );
}

int main()
{
	printf("%d\n", suma(10));
	return 0;
}
