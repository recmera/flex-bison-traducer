%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "ALM.tab.h"

%}

entero ([0-9])+
letras ([a-zA-Z])*

%%

[ \t]	;              // Ignora los espacios en blanco
{entero}		         {yylval.ival = atoi(yytext); return T_INT;}
"L"{letras}{entero}  {strcpy(yylval.cval,yytext); return T_VAR;}
"\n"		             {return T_SALTO;}
","		               {return T_COMA;}
"("		               {return T_L;}
")"		               {return T_R;}
"partir"		         {return T_PARTIR;}
"iniciar"		         {return T_INICIAR;}
"meter"		           {return T_METER;}
"sacar"		           {return T_SACAR;}
"mirar"		           {return T_MIRAR;}
"dato"		           {return T_DATO;}
"finalizar"		       {return T_FINALIZAR;}

%%
