user-sh: execute.c global.h bison.y flex.l
	flex -o lex.yy.c flex.l
	bison bison.y
	cc -c execute.c
	cc -o user-sh bison.tab.c lex.yy.c execute.o -lfl
clean:
	rm user-sh bison.tab.o execute.o bison.tab.c
