#ifndef __set_h__
#define __set_h__

struct set_t {
    int capacity;
    int size;
    int* elements;
};

struct set_t* set_create(int capacity);
struct set_t* set_range(int a, int b);
void set_free(struct set_t* set);

void set_print(struct set_t* set);
int set_find_element(struct set_t* set, int element);
void set_insert_element(struct set_t* set, int element);

struct set_t* set_union(struct set_t* lhs, struct set_t* rhs);
struct set_t* set_intersection(struct set_t* lhs, struct set_t* rhs);
struct set_t* set_difference(struct set_t* lhs, struct set_t* rhs);

#endif // __set_h__
