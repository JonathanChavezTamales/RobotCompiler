%{
#include "y.tab.h"
#include <stdio.h>

%}

%%

"Robot"        { return ROBOT; }
"please"       { return PLEASE; }
"move"         { return MOVE; }
"blocks"       { return BLOCKS; }
"ahead"        { return AHEAD; }
"turn"         { return TURN; }
"degrees"      { return DEGREES; }
","            { return COMMA; }
"then"         { return THEN; }
"and"          { return AND; }
"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|"10"    { yylval.integer = atoi(yytext); return NUMBER; }
"90"|"180"|"270"|"360"                       { yylval.integer = atoi(yytext); return ANGLE; }
[ \t\n]+  { /* skip whitespace */ }
.   { fprintf(stderr, "Unknown character: %s\n", yytext); exit(1); }

%%

int yywrap(void) {
    return 1;
}

