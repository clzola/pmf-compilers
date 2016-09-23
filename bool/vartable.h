#ifndef __bool_h__
	#define __bool_h__
	
	struct variable_t {
		int value;
		char* name;
	};

	struct variable_table_t {
		int cap;
		int size;
		struct variable_t** variables;
	};
	
	struct variable_table_t* variable_table_create(int);
	struct variable_t* variable_create(struct variable_table_t*, int, char*);
	struct variable_t* variable_find(struct variable_table_t*, char*);
	
	void variable_table_free(struct variable_table_t*);
	void variable_free(struct variable_t*);
	
#endif