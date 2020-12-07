%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE" yyin;

%}

%token<ival> T_INT

%token T_START T_XYZ T_QUIT
