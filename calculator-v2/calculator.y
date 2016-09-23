%{
/**
 *  @author Lazar Radinovic
 *  @index 6/12
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
      
void yyerror(const char* message);
float divide(float a, float b);
%}

// I do not like unions :D
// So this code is required for parser to accept yylval to be 
// DOUBLE instead of default INT.
%code requires
{
    #define YYSTYPE float
    #define YYSTYPE_IS_DECLARED
}

%token ADD SUB MUL DIV POW
%token F_SIN F_COS F_LOG F_EXP F_SQRT
%token L_PARAN R_PARAN
%token NUMBER
%token EOL

%left ADD SUB
%left MUL DIV
%left POW

%nonassoc UMINUS

%%

input: /* empty rule */
  | input line
  ;
  
line : expr EOL                                             { printf("%.10lf\n>> ", $1); }
  | EOL                                                     /* Ignore empty lines. */
  ;
  
expr: F_SIN L_PARAN expr R_PARAN                            { $$ = sin($3); }
  | F_COS L_PARAN expr R_PARAN                              { $$ = cos($3); }
  | F_LOG L_PARAN expr R_PARAN                              { $$ = log($3); }
  | F_EXP L_PARAN expr R_PARAN                              { $$ = exp($3); }
  | F_SQRT L_PARAN expr R_PARAN                             { $$ = sqrt($3); }
  | expr ADD expr                                           { $$ = $1 + $3; }
  | expr SUB expr                                           { $$ = $1 - $3; }
  | expr MUL expr                                           { $$ = $1 * $3; }
  | expr DIV expr                                           { $$ = divide($1, $3); }
  | expr POW expr                                           { $$ = pow($1, $3); }
  | L_PARAN expr R_PARAN                                    { $$ = $2; }
  | SUB expr %prec UMINUS                                   { $$ = -$2; }
  | NUMBER                                                  { $$ = $1; }
  ;
  
%%

int main() 
{
    printf(">> ");
    yyparse();
    return 0;
}

void yyerror(const char* message)
{
    printf("%s\n", message);
}

float divide(float a, float b)
{
    if( b == 0 ) {
        printf("You cannot divide by zero!");
        exit(1);
    }
    
    return a / b;
}
