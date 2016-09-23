%{

#include <stdio.h>
extern FILE * yyin;

void yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}

%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token L_PARAN R_PARAN
%token EOL

%%

calculatorList:	/* nothing, matches at beginning of input */
  | calculatorList exp EOL      { printf("= %d\n", $2); }
  ;
	
exp: factor	
  | exp ADD factor				{ $$ = $1 + $3; }
  | exp SUB factor              { $$ = $1 - $3; }
  ;
  
factor: term
  | factor MUL term             { $$ = $1 * $3; }
  | factor DIV term             { $$ = $1 / $3; }
  ;
  
term: NUMBER
  | L_PARAN exp R_PARAN         { $$ = $2; }
  ;

%%

int main(int argc, char** args)
{
	yyparse();
	return 0;
}