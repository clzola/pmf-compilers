%{

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	#include "set.h"
	#include "vartable.h"

	extern char* yytext;

	void yyerror(const char* message) {
		fprintf(stderr, "%s\n", message);
	}

	struct variable_table_t* table = NULL;
	struct set_t* tmp_set = NULL;

%}

%define parse.error verbose

%token K_PRINT K_CHECK K_CARDINAL
%token SEMI_COLON COLON L_PARAN R_PARAN
%token NUMBER IDENTIFIER
%token O_DIFFERENCE O_TILDA O_UNION O_INTERSECTION O_ASSIGN O_COMPARE O_IN O_RANGE

%union {
	int number;
	char* identifier;
	struct set_t* set;
}

%type<number> NUMBER
%type<identifier> IDENTIFIER
%type<set> expr set

%left O_UNION O_DIFFERENCE O_INTERSECTION

%%

program: program command
  | command
  ;

command: IDENTIFIER O_ASSIGN expr SEMI_COLON		{ variable_create(table, $3, $1); }
  | K_PRINT expr SEMI_COLON							{ printf("=> "); set_print($2); printf("\n"); }
  | K_CHECK NUMBER O_IN expr SEMI_COLON             { printf("=> %s\n", set_find_element($4, $2) == 1 ? "true" : "false"); }
  | K_CARDINAL expr	SEMI_COLON						{ printf("=> %d\n", $2->size); }
  ;

set: L_PARAN array R_PARAN							{ $$ = tmp_set; tmp_set = NULL; }
  | L_PARAN R_PARAN									{ $$ = set_create(20); }
  | NUMBER O_RANGE NUMBER							{ $$ = set_range($1, $3); }
  ;

array: array COLON NUMBER							{
														if( tmp_set == NULL ) tmp_set = set_create(20);
														set_insert_element(tmp_set, $3);
													}
  | NUMBER											{
														if( tmp_set == NULL ) tmp_set = set_create(20);
														set_insert_element(tmp_set, $1);
													}
  ;

expr: expr O_UNION expr								{ $$ = set_union($1, $3); }
  | expr O_INTERSECTION expr						{ $$ = set_intersection($1, $3); }
  | expr O_DIFFERENCE expr							{ $$ = set_difference($1, $3); }
  | set												{ $$ = $1; }
  | IDENTIFIER										{ $$ = variable_find(table, $1)->value; }
  ;

%%

int main()
{
	table = variable_table_create(100);

	yyparse();

	variable_table_free(table);

	return 0;
}
