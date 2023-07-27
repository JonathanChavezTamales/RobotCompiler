all:
	yacc -d parser.y
	lex lexer.l
	gcc y.tab.c lex.yy.c -ly -ll -o compiler

clean:
	rm -rf lex.yy.c y.tab.c y.tab.h compiler