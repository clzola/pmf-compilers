// Decimal to hexadecimal

#include <stdio.h>

void print_hexa_digit(int x)
{
	if( x < 10 )
		printf("%d", x);
	else printf("%c", 'a' + (x - 10));
}

void print_hexa(int x)
{
	if( x > 0 )
	{
		int cifra = x % 16;
		print_hexa( x / 16 );
		print_hexa_digit(cifra);
	}
}

int main()
{
	printf("0x");
	print_hexa(568412);
	return 0;
}
