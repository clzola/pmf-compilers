%{
	#include "calculator.tab.h"
%}

%%
[\t ]			; 						// Ignore whitespace
"+"				{ return ADD; }
"-"				{ return SUB; }
"*"				{ return MUL; }
"/"				{ return DIV; }
"("				{ return L_PARAN; }
")"				{ return R_PARAN; }
[1-9][0-9]*		{ yylval = atoi(yytext); return NUMBER; }
\n				{ return EOL; }
.				{ printf("Unknown character: %c\n", yytext[0]); }
%%