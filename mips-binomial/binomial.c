// binomni koeficijent
//  / n \   / n-1 \   / n-1 \
//  |   | = |     | + |     | ; for all integers n, k > 0
//  \ k /   \ k-1 /   \  k  /

#include <stdio.h>

int binomial(int n, int k)
{
	if ( k == 0 || n == k )
		return 1;

	return binomial(n-1, k-1) + binomial(n-1, k);
}

int main()
{
	printf("%d\n", binomial(5,3));
	return 0;
}
