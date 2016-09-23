#!/bin/bash

bison -d calculator.y
flex calculator.l
gcc -o main lex.yy.c parser.tab.c -lfl -lm
