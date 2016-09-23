%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void dec_to_bin(char* s)
{
  int slen = strlen(s);
  int number = 0;
  int i;

  for(i=0; i<slen; i++) {
    number = number * 10 + (s[i] - '0');
  }

  int bin[32];
  int j=0;

  while(number > 0)
  {
    bin[j] = number % 2;
    number= number/ 2;
    j++;
  }

  for(j=j-1; j>=0; j--)
    printf("%d", bin[j]);
  printf("\n");
}

%}

%%
[\n\t ]             ;
[1-9][0-9]*         { dec_to_bin(yytext); }
.                   ;
%%
