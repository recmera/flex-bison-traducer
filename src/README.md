# Traductor sintáctico LMA

El siguiente documento es un pequeño ejemplo de un traductor capaz de ejecutar programas escritos en LMA (Lenguaje Manejador de Arreglos). El traductor acepta una secuencia de instrucciones del lenguaje LMA y efectúa algunas acciones a medida que se realiza en análisis sintáctico.    
       

Para su implementación se utilizaron las herramientas FLEX-BISON.

#### Acciones del traductor

- partir: Primera instrucción. Inicia el programa.
- iniciar(A, e1,...,e8): Crea un arreglo de nombre A con los elementos e1,...,e8 (números enteros positivos). En caso de agregar menos de ocho números, los restantes serán completados con ceros.
- meter(A, x, y): Inserta el elemento x en la posición y del arreglo A.
- sacar(A, y): Elimina el elemento en la posición y del arreglo A.
- mirar(A): Despliega los elementos del arreglo A.
- dato(A, y): despliega el elemento que se encuentra en la posición y del arreglo A.
- finalizar:  Última instrucción. Finaliza el programa.

#### Compilación

Para compilar el programa usando `Makefile`

```sh
    $ make
```
O manualmente en Linux, siguiendo los siguientes pasos:

```sh

    $ bison -d LMA.y
    $ flex LMA.l
    $ gcc LMA.tab.c lex.yy.c -o LMA -lm
    $ ./LMA
    
```