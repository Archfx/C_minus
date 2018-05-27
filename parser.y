%{
    #include <stdarg.h>
    #include "shared_values.h"
    #define YYSTYPE char *
    void yyerror(const char *s);
    int yylex();
    int yydebug = 1;
    int indent = 0;
    char *iden_dum;
%}

// Tokens Definition
%token IF
%token ELSE
%token INT
%token RETURN
%token VOID
%token WHILE
%token PLUS
%token MINUS
%token MUL
%token DIV
%token LESS_THAN
%token LESS_OR_EQUAL
%token GREATER_THAN
%token GREATER_OR_EQUAL
%token EQUALS
%token ASSIGNMENT
%token NOT_EQUALS
%token END_LINE
%token SEPERATE
%token LEFT_DOUBLE_BRACKET
%token RIGHT_DOUBLE_BRACKET
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token LEFT_SQUAR_BRACKET
%token RIGHT_SQUAR_BRACKET
%token ID
%token NUM

// Grammar Rules for CFG
%%
program: declaration-list;
declaration-list: declaration-list declaration | declaration;
declaration: var-declaration | fun-declaration;
var-declaration: type-specifier ID END_LINE | type-specifier ID LEFT_SQUAR_BRACKET NUM RIGHT_SQUAR_BRACKET END_LINE;
type-specifier: INT | VOID;
fun-declaration: type-specifier ID LEFT_BRACKET params RIGHT_BRACKET compound-stmt;
params: param-list | VOID;
param-list: param-list SEPERATE param | param;
param: type-specifier ID | type-specifier ID LEFT_SQUAR_BRACKET RIGHT_SQUAR_BRACKET;
compound-stmt: LEFT_DOUBLE_BRACKET local-declarations statement-list RIGHT_DOUBLE_BRACKET;
local-declarations: local-declarations var-declaration | %empty;
statement-list: statement-list statement | %empty;
statement: expression-stmt | compound-stmt | selection-stmt | iteration-stmt |
return-stmt;
expression-stmt: expression END_LINE | END_LINE;
selection-stmt: IF LEFT_BRACKET expression RIGHT_BRACKET statement | IF LEFT_BRACKET expression RIGHT_BRACKET statement ELSE
statement;
iteration-stmt: WHILE LEFT_BRACKET expression RIGHT_BRACKET statement;
return-stmt: RETURN END_LINE | RETURN expression END_LINE;
expression: var ASSIGNMENT expression | simple-expression;
var: ID | ID LEFT_SQUAR_BRACKET expression RIGHT_SQUAR_BRACKET;
simple-expression: additive-expression relop additive-expression | additive-expression;
relop: LESS_THAN | LESS_OR_EQUAL | GREATER_THAN | GREATER_OR_EQUAL | EQUALS | NOT_EQUALS;
additive-expression: additive-expression addop term | term;
addop: PLUS | MINUS;
term: term mulop factor | factor;
mulop: MUL | DIV;
factor: LEFT_BRACKET expression RIGHT_BRACKET | var | call | NUM;
call: ID LEFT_BRACKET args RIGHT_BRACKET;
args: arg-list | %empty;
arg-list: arg-list SEPERATE expression | expression;

%%

#include <stdio.h>
#include <ctype.h>

int main () {     
  yyparse ();
}
