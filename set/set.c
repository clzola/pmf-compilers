#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "set.h"

struct set_t* set_create(int capacity)
{
    struct set_t* set = (struct set_t*) malloc( sizeof(struct set_t) );
    set->capacity = capacity;
    set->size = 0;
    set->elements = (int*) malloc( sizeof(int) * capacity );
    return set;
}

struct set_t* set_range(int a, int b)
{	
    int i;
    struct set_t* set = set_create(b - a + 5);
    for(i=a; i<=b; i++)
        set_insert_element(set, i);
    return set;
}

void set_free(struct set_t* set)
{
    free(set->elements);
    free(set);
}

void set_print(struct set_t* set)
{
    printf("{");

    int i;
    for(i=0; i<set->size-1; i++)
        printf("%d, ", set->elements[i]);

    printf("%d", set->elements[i]);
    printf("}");
}

int set_find_element(struct set_t* set, int element)
{
    int i;
    for(i=0; i<set->size; i++)
        if( set->elements[i] == element )
            return 1;
    return 0;
}

void set_insert_element(struct set_t* set, int element)
{
    if( set_find_element(set, element) )
        return;

    if( set->capacity == set->size ) {
        set->elements = (int*) realloc(set->elements, set->capacity * 2);
        set->capacity *= 2;
    }

    set->elements[set->size] = element;
    set->size++;
}

struct set_t* set_union(struct set_t* lhs, struct set_t* rhs)
{
    int i;
    struct set_t* set = set_create(lhs->size + rhs->size + 20);

    for(i=0; i<lhs->size; i++)
        set_insert_element(set, lhs->elements[i]);

    for(i=0; i<rhs->size; i++)
        set_insert_element(set, rhs->elements[i]);

    return set;
}

struct set_t* set_intersection(struct set_t* lhs, struct set_t* rhs)
{
    int i, j;
    struct set_t* set = set_create((lhs->capacity > rhs->capacity ? lhs->capacity : rhs->capacity) + 1);

    for(i=0; i<lhs->size; i++)
        for(j=0; j<rhs->size; j++)
            if( lhs->elements[i] == rhs->elements[j] )
                set_insert_element(set, lhs->elements[i]);

    return set;
}

struct set_t* set_difference(struct set_t* lhs, struct set_t* rhs)
{
    int i, j, e;
    struct set_t* set = set_create(lhs->size + rhs->size + 20);

    for(i=0; i<lhs->size; i++) {
        e = 0;
        for(j=0; j<rhs->size; j++)
            if( lhs->elements[i] == rhs->elements[j] ) {
                e = 1;
                break;
            }

        if (!e) set_insert_element(set, lhs->elements[i]);
    }

    for(i=0; i<rhs->size; i++) {
        e = 0;
        for(j=0; j<lhs->size; j++)
            if( rhs->elements[i] == lhs->elements[j] ) {
                e = 1;
                break;
            }

        if (!e) set_insert_element(set, rhs->elements[i]);
    }

    return set;
}
