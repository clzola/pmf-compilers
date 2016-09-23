%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

%}

%%
[\t\n ]               ;
0[xX][0-9A-Fa-f]+     {
                          int dec_value = strtol(yytext, NULL, 16);
                          printf("found: %s => %d\n", yytext, dec_value); 
                      }
.                     ;
%%
