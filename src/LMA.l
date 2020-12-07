%option noyywrap

%{

#include<stdio.h>
#include<stdlib.h> 

#include "LMA.tab.h"

%}



%%

[ \t]   ; // ignore whitespaces
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
"PARTIR"    {return T_START;}
"INICIAR"   {return T_CREATE;}
"METER"     {return T_INSERT;}
"SACAR"     {return T_EXTRACT;}
"MIRAR"     {return T_PRINTALL;}
"DATO"      {return T_PRINTELEM;}
"FINALIZAR" {return T_QUIT;}

%%