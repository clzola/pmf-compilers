%{
/**
 *  @author Lazar Radinovic
 *  @index 6/12
 */
 
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include "parser.tab.h"
%}

/* float exponent */
EXP		([Ee][-+]?[0-9]+)

%%
"+"															{ return ADD; }
"-"															{ return SUB; }
"*"															{ return MUL; }
"/"															{ return DIV; }
"^"															{ return POW; }
"sin"                                                       { return F_SIN; }
"cos"                                                       { return F_COS; }
"log"                                                       { return F_LOG; }
"exp"                                                       { return F_EXP; }
"sqrt"                                                      { return F_SQRT; }
"("															{ return L_PARAN; }
")"															{ return R_PARAN; }
[0-9]+"."[0-9]*{EXP}?|"."?[0-9]+{EXP}?						{ yylval = atof(yytext); return NUMBER; }
\n															{ return EOL; }
"//".*														{ /* ignore comments */ }
[ \t]														{ /* ignore whitespace */ }
.															{ printf("Mysterious character %c.\n", *yytext); }
%%
