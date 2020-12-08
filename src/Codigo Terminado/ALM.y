%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

struct Arreglo
{
	char nombre[64];
	int numeros[8];
	struct Arreglo *next;
};

struct Arreglo *arreglos = NULL;

// Indica si el arreglo está lleno
int arregloEstaLleno( int *arr )
{
	for(int i = 0; i < 8; i++)
		if(arr[i] == 0)
			return 0;
	return 1;
}

// Busca y retorna arreglo por su nombre
struct Arreglo *buscaArreglo(char*nombre)
{
	struct Arreglo *p = arreglos;

	while(p!=NULL)
	{
		if(strcmp(p->nombre,nombre) == 0)
			return p;
		p = p->next;
	}

	// Si no existe
	return NULL;
}

void dato(char *nombre, int pos)
{
	struct Arreglo *p = buscaArreglo(nombre);
	if(p == NULL)
	{
		printf("\nError: El arreglo no existe.\n");
		exit(1);
	}
	pos = pos - 1;
	printf("\n%i\n",p->numeros[pos]);
}

void imprimirArreglo(char *nombre)
{
	struct Arreglo *p = buscaArreglo(nombre);
	if(p == NULL)
	{
		printf("\nError: El arreglo no existe.\n");
		exit(1);
	}
	printf("\n");
	for(int i = 0; i < 8; i++)
		printf("%i ",p->numeros[i]);
	printf("\n");
}

// Deja los 0 a la derecha
void comprimeArreglo(int *arr)
{
	if(arregloEstaLleno(arr)) return;
	int primerCero;
	for(int i = 0; i < 8; i++)
	{
		// Busca el primer 0
		for(int j = 0; j < 8; j++)
		{
			if(j == 7) return;
			if(arr[j] == 0)
			{
				primerCero = j;
				break;
			}
		}

		for(int j = primerCero+1; j < 8; j++)
		{
			if(arr[j] != 0)
			{
				arr[primerCero] = arr[j];
				arr[j] = 0;
				break;
			}
		}
	}
}

void sacarElemento(char *nombre,int pos)
{
	struct Arreglo *p = buscaArreglo(nombre);

	if(p == NULL)
	{
		printf("\nError: El arreglo no existe.\n");
		exit(1);
	}

	pos = pos - 1;

	p->numeros[pos] = 0;
	comprimeArreglo(p->numeros);
}

void meterElemento(char*nombre,int valor,int pos)
{
	pos = pos - 1;

	struct Arreglo *p = buscaArreglo(nombre);

	if(p == NULL)
	{
		printf("\nError: El arreglo no existe.\n");
		exit(1);
	}
	if(arregloEstaLleno( p->numeros ))
	{
		printf("\nError: El arreglo está lleno.\n");
		exit(1);
	}

	// Si el espacio está vacio, añadimos directamente
	if(p->numeros[pos] == 0)
	{
		p->numeros[pos] = valor;
		comprimeArreglo(p->numeros);
		return;
	}

	// Movemos números a la derecha
	for(int i = 7; i > pos; i--)
	{
		p->numeros[i] = p->numeros[i-1];
	}
	p->numeros[pos] = valor;


}



void iniciarArreglo(char *nombre,int n1,int n2,int n3,int n4,int n5,int n6,int n7,int n8)
{
	//printf("Arreglo creado:\n%s = (%i,%i,%i,%i,%i,%i,%i,%i)\n",nombre,n1,n2,n3,n4,n5,n6,n7,n8);

	if(buscaArreglo(nombre) != NULL)
	{
		printf("\nError: El arreglo ya existe.\n ");
		exit(1);
	}

	// Si es el primer arreglo inicializado
	if(arreglos == NULL)
	{
		// Reserva memoria en el heap
		arreglos = malloc(sizeof(struct Arreglo));

		// Copia el nombre
		strcpy(arreglos->nombre,nombre);

		// Asigna los valores
		arreglos->numeros[0] = n1;
		arreglos->numeros[1] = n2;
		arreglos->numeros[2] = n3;
		arreglos->numeros[3] = n4;
		arreglos->numeros[4] = n5;
		arreglos->numeros[5] = n6;
		arreglos->numeros[6] = n7;
		arreglos->numeros[7] = n8;

		comprimeArreglo(arreglos->numeros);

		// Asigna next como NULL
		arreglos->next = NULL;
	}
	else
	{
		// Busca el último
		struct Arreglo *p = arreglos;
		while(p->next != NULL)
			p = p->next;

		// Crea el nuevo
		p->next = malloc(sizeof(struct Arreglo));

		// Copia el nombre
		strcpy(p->next->nombre,nombre);

		// Asigna los valores
		p->next->numeros[0] = n1;
		p->next->numeros[1] = n2;
		p->next->numeros[2] = n3;
		p->next->numeros[3] = n4;
		p->next->numeros[4] = n5;
		p->next->numeros[5] = n6;
		p->next->numeros[6] = n7;
		p->next->numeros[7] = n8;

		comprimeArreglo(p->next->numeros);

		// Asigna next como NULL
		p->next->next = NULL;

	}
}
%}

%union {
	int ival;
	char cval[64];
}

%token<ival> T_INDICE
%token<ival> T_INT
%token<cval> T_VAR
%token T_COMA T_L T_R T_SALTO
%token T_PARTIR T_INICIAR T_METER T_SACAR T_MIRAR T_DATO T_FINALIZAR

%type<ival> entero

%start programa

%%

programa:
		| T_PARTIR T_SALTO instrucciones T_FINALIZAR T_SALTO { printf("\nPrograma Finalizado.\n"); exit(1); }
;

instrucciones:
    | instruccion instrucciones

instruccion: T_INICIAR T_L T_VAR
								T_COMA entero
								T_COMA entero
								T_COMA entero
								T_COMA entero
								T_COMA entero
								T_COMA entero
								T_COMA entero
								T_COMA entero
								T_R T_SALTO  { iniciarArreglo($3,$5,$7,$9,$11,$13,$15,$17,$19); }

					 | T_METER T_L T_VAR T_COMA entero T_COMA T_INDICE T_R T_SALTO { meterElemento($3,$5,$7); }

					 | T_MIRAR T_L T_VAR T_R T_SALTO { imprimirArreglo($3); }

					 | T_SACAR T_L T_VAR T_COMA T_INDICE T_R T_SALTO  { sacarElemento($3,$5);}

					 | T_DATO T_L T_VAR T_COMA T_INDICE T_R T_SALTO  { dato($3,$5);}


;



entero: T_INT { $$ = $1}
				| T_INDICE { $$ = $1}


%%

int main() {

	printf("\nIngrese instrucciones por linea:\n");
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
