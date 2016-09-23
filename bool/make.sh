#!/bin/bash

bison -vd bool.y --debug
flex -l bool.l
gcc -o bool *.c -lfl -lm
