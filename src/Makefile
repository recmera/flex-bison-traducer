all: ALM

ALM.tab.c ALM.tab.h:	ALM.y
	bison -t -v -d ALM.y

lex.yy.c: ALM.l ALM.tab.h
	flex ALM.l

ALM: lex.yy.c ALM.tab.c ALM.tab.h
	gcc -o ALM ALM.tab.c lex.yy.c

clean:
	rm ALM ALM.tab.c lex.yy.c ALM.tab.h ALM.output
