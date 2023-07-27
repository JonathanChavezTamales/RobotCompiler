%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
FILE *out_file;
%}

%union {
    int integer;
}

%token <integer> NUMBER ANGLE
%token ROBOT PLEASE MOVE BLOCKS AHEAD TURN DEGREES COMMA THEN AND

%start COMMAND

%%

COMMAND : POLITE_COMMAND
        ;

POLITE_COMMAND : ROBOT PLEASE ACTION_LIST
               ;

ACTION_LIST : ACTION
            | ACTION COMMA THEN ACTION_LIST 
            | ACTION AND THEN ACTION_LIST
            ;

ACTION : MOVE_ACTION 
       | TURN_ACTION 
       ;

MOVE_ACTION : MOVE NUMBER BLOCKS AHEAD { fprintf(out_file, "MOV,%d\n", $2); } ;
            | MOVE NUMBER BLOCKS { fprintf(out_file, "MOV,%d\n", $2); } ;

TURN_ACTION : TURN ANGLE DEGREES { fprintf(out_file, "TURN,%d\n", $2); } ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error: Unable to open the input file.\n");
        return 1;
    }

    out_file = fopen("instructions.asm", "w");
    if (!out_file) {
        fprintf(stderr, "I can't open instructions.asm for writing.\n");
        exit(1);
    }

    yyin = file; 
    yyparse();

    fclose(file);
    fclose(out_file);

    return 0;
}
