%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	#include "set.tab.h"
%}

%%

[\n\t ]				;
"print"|"PRINT" 	{ return K_PRINT; }
"check"|"CHECK" 	{ return K_CHECK; }
"card"|"CARD"		{ return K_CARDINAL; }
";"					{ return SEMI_COLON; }
","					{ return COLON; }
"/"					{ return O_DIFFERENCE; }
"~"					{ return O_TILDA; }
"\\/"				{  return O_UNION; }
"/\\"				{ return O_INTERSECTION; }
"="					{ return O_ASSIGN; }
"<"					{ return O_COMPARE; }
":"					{ return O_IN; }
".."				{ return O_RANGE; }
"{"					{ return L_PARAN; }
"}"					{ return R_PARAN; }
[0-9]+				{ yylval.number = atoi(yytext); return NUMBER; }
[A-Za-z]+			{ yylval.identifier = strdup(yytext); return IDENTIFIER; }

%%
