%{

#include <stdio.h>
#include <stdlib.h>

int oct_counter = 0;
int dec_counter = 0;
int hex_counter = 0;

enum yytokentype
{
	DEC = 258,
	HEX,
	OCT,
	COMMENT_START,
	COMMENT_END,
	COMMENT_LINE,
	LITERALS_START,
	LITERALS_END
};

%}

%x LITERALS
%x COMMENT_MULTI_LINE
%x COMMENT_SINGLE_LINE

%%
[\t\n ]						;
[A-Za-z_][A-Za-z_0-9]+		;
"0"[LUlu]?					{ dec_counter++; return DEC; }
"0"[1-7]+[LUlu]?			{ oct_counter++; return OCT; }
"0"[xX][0-9A-Fa-f]+[LUlu]?	{ hex_counter++; return HEX; }
[1-9][0-9]*[LUlu]? 	        { dec_counter++; return DEC; }
"//"						{ BEGIN(COMMENT_SINGLE_LINE); return COMMENT_LINE;}
<COMMENT_SINGLE_LINE>\n		{ BEGIN(INITIAL);}
"/**"|"/*" 					{ BEGIN(COMMENT_MULTI_LINE); return COMMENT_START;}
<COMMENT_MULTI_LINE>"*/" 	{ BEGIN(INITIAL); return COMMENT_END; }
"\""						{ BEGIN(LITERALS); return LITERALS_START; }
<LITERALS>"\\\""			;
<LITERALS>"\""				{ BEGIN(INITIAL); }
<LITERALS,COMMENT_MULTI_LINE,COMMENT_SINGLE_LINE>.	;
.							;
%%

int main(int argc, char** args)
{
	int token;
	if( argc > 1 ) {
		yyin = fopen(args[1], "r");
		while(token=yylex());
		fclose(yyin);
	}

	printf("oct: %d\n", oct_counter);
	printf("dec: %d\n", dec_counter);
	printf("hex: %d\n", hex_counter);
	return 0;
}
