#include "vartable.h"
#include <stdlib.h>
#include <string.h>

#include "set.h"

struct variable_table_t* variable_table_create(int cap)
{
	struct variable_table_t* table =
		(struct variable_table_t*) malloc( sizeof( struct variable_table_t )  );
	
	table->cap = cap;
	table->size = 0;
	table->variables = 
	    (struct variable_t** ) malloc ( sizeof(struct variable_t) * cap );
	return table;
}

struct variable_t* variable_create(struct variable_table_t* table, struct set_t* value, char* name)
{
	struct variable_t* variable = 
		(struct variable_t*) malloc( sizeof(struct variable_t) );
		
	variable->value = value;
	variable->name = strdup(name);
	
	table->variables[table->size] = variable;
	table->size++;
	
	return variable;
}

struct variable_t* variable_find(struct variable_table_t* table, char* name)
{
	int i;
	for(i=0; i<table->size; i++)
		if( strcmp(name, table->variables[i]->name) == 0 )
			return table->variables[i];
	return NULL;
}

void variable_table_free(struct variable_table_t* table)
{
	int i;
	for(i=0; i<table->size; i++)
		variable_free(table->variables[i]);
	
	free(table->variables);
	free(table);
}

void variable_free(struct variable_t* variable)
{
	free(variable->name);
	set_free(variable->value);
	free(variable);
}