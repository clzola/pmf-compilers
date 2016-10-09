// F1 = 1
// F2 = 1
// Fn = Fn-1 + Fn-2

#include <stdio.h>

int fibonacci(int x) 
{
	if ( x <= 2 )
		return 1;
	return fibonacci(x-1) + fibonacci(x-2);
}

int main()
{
	printf("%d\n", fibonacci(8));
	return 0;
}
