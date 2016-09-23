%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "vartable.h"
	#include "bool.tab.h"
	
	extern char* yytext;
		
	void yyerror(const char* message) {
		fprintf(stderr, "%s\n", message);
	}
	
	struct variable_table_t* table = NULL;
	
	void declare_variable(struct variable_table_t* table, char* name)
	{
		if( variable_find(table, name) == NULL )
			variable_create(table, 0, name);
		else {
			fprintf(stderr, "variable %s already defined!\n", name);
			exit(1);
		}
	}
	
	void assign(struct variable_table_t* table, char* name, int value)
	{
		struct variable_t* variable = variable_find(table, name);
		
		if( variable == NULL ) {
			fprintf(stderr, "variable %s does not exists!\n", name);
			exit(1);
		}
		
		variable->value = value;
	}
	
	int get_value(struct variable_table_t* table, char* name)
	{
		struct variable_t* variable = variable_find(table, name);
		
		if( variable == NULL ) {
			fprintf(stderr, "variable %s does not exists!\n", name);
			exit(1);
		}
		
		return variable->value;
	}
	
%}

%define parse.error verbose

%union {
	int b;
	char* id;
}

%token TRUE FALSE
%token IDENTIFIER
%token VAR AND OR NOT
%token ASSIGN
%token L_PARAN R_PARAN SEMI_COLON

%type<id> IDENTIFIER
%type<b> expr TRUE FALSE

%left AND OR
%left NOT

%%

program: declaration statement
  ;
  
declaration: /* nothing */
  | declaration VAR IDENTIFIER SEMI_COLON			{ declare_variable(table, $3); }
  ;
  
statement: /* nothing */
  | statement IDENTIFIER ASSIGN expr SEMI_COLON		{ assign(table, $2, $4); printf("=> %s\n", $4 == 1 ? "true" : "false"); }
  ;
  
expr: expr AND expr									{ $$ = $1 && $3; }
  | expr OR expr									{ $$ = $1 || $3; }
  | NOT expr										{ $$ = ! $2; }
  | L_PARAN expr R_PARAN							{ $$ = $2; }
  | TRUE
  | FALSE
  | IDENTIFIER										{ $$ = get_value(table, $1); }
  ;

%%

int main()
{
	table =  variable_table_create(100);
	yyparse();
	
	variable_table_free(table);
	return 0;
}