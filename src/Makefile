all: LMA

LMA.tab.c LMA.tab.h: LMA.y
	bison -t -v -d LMA.y

lex.yy.c: LMA.l LMA.tab.h
	flex LMA.l

LMA: lex.yy.c LMA.tab.c LMA.tab.h
	gcc -o LMA LMA.tab.c lex.yy.c

clean:
	rm LMA LMA.tab.c lex.yy.c LMA.tab.h LMA.output