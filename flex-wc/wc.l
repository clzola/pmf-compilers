%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int words = 0;
int characters = 0;
int lines = 0;

%}

%%
[A-Za-z]+               {
                          words++;
                          printf("%s\n", yytext);
                          characters += strlen(yytext);
                        }
\n                      { lines++; }
.                       { printf("unknown character\n"); }
%%

main(int argc, char **argv)
{
	yylex();
	printf("%8d%8d%8d\n", lines, words, characters);
}
