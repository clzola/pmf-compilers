%{

#include <stdio.h>
#include "bool.tab.h"

%}

%%
[\n\t ]					;
"true"					{ yylval.b = 1; return TRUE; }
"false"					{ yylval.b = 0;  return FALSE; }
"var"					{ return VAR; }
"and"					{ return AND; }
"or"					{ return OR; }
"not"					{ return NOT; }
"="						{ return ASSIGN; }
"("						{ return L_PARAN; }
")"						{ return R_PARAN; }
";"						{ return SEMI_COLON; }
[a-zA-z]+				{ yylval.id = strdup(yytext); return IDENTIFIER; }
%%