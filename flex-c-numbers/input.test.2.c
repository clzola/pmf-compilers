#include <stdio.h>
#include <stdlib.h>

int main()
{
	int x[] ={12, 012, 012,0x123, 0xA12, 0XAB,-12 };
	unsigned int y[] = {12U, 234U, 0xaaU, 0123U, 077U, 0XA1U, 45U};
	long int z[] = {12L, 234L, 0xaaL, 0123L, 077L, 0XA1L, 45L};
	int i = 0;
	long int d = 67L;
	/*
		Zadatak 1, 1U, 0123, 0x123
	*/
	char *ss = "1234";
	char *ss1 = "0XABCD";
	char *ss2 = "0123";
	for (i = 0; i<7;i++)
	{
		printf("%d %d %d\n", x[i], y[i], z[i]);
		x[i] += 12;
		y[i] -= 2U;
		z[i] = 22L+2L*z[i];
	}
	return 0;
}
