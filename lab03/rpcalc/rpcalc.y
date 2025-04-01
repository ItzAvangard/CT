/*
 * Infix Notation Calculator
 * (1 + 2) * 3 = 9
 */

%{
#include <stdio.h>
#include <math.h>

int yylex();
void yyerror(const char *);
%}

/* Type for semantic values */
%define api.value.type {double}
%token NUM

/* Define operator precedence */
%left '+' '-'
%left '*' '/'
%right '^'  /* Exponentiation has highest precedence */
%precedence UMINUS  /* Unary minus */

%%

input:
    %empty
  | input line
;

line:
    '\n'
  | exp '\n'   { printf("%.10g\n", $1); }
;

exp:
    NUM
  | exp '+' exp  { $$ = $1 + $3; }
  | exp '-' exp  { $$ = $1 - $3; }
  | exp '*' exp  { $$ = $1 * $3; }
  | exp '/' exp  { $$ = $1 / $3; }
  | exp '^' exp  { $$ = pow($1, $3); }  /* Exponentiation */
  | '(' exp ')'  { $$ = $2; }           /* Parentheses */
  | '-' exp %prec UMINUS { $$ = -$2; }  /* Unary minus */
;
%%

#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>

int yylex()
{
    int c = getchar();
    while (c == ' ' || c == '\t') {
        c = getchar();
    }

    /* Process floating point numbers */
    if (c == '.' || isdigit(c)) {
        ungetc(c, stdin);
        if (scanf("%lf", &yylval) != 1)
            abort();
        return NUM;
    } else if (c == EOF) {
        return YYEOF;
    }
    /* Single char token */
    return c;
}

/* Called by yyparse on error */
void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main()
{
    return yyparse();
}
