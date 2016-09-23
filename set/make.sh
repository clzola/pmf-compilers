#!/bin/bash

bison -vd set.y --debug
flex -l set.l
gcc -o set0 *.c -lfl -lm
