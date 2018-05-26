%{
    #include "parser.tab.h"

    void yyerror (char const *s) {
        fprintf (stderr, "%s\n", s);
    }
    // extern int line_number
%}
%option noyywrap    

%%

"else"                      return ELSE;
"if"                        return IF;
"int"                       return INT;
"return"                    return RETURN;
"void"                      return VOID;
"while"                     return WHILE;
"+"                         return PLUS;
"-"                         return MINUS;
"*"                         return MUL;
"/"                         return DIV;
"<"                         return LESS_THAN;
"<="                        return LESS_OR_EQUAL;                     
">"                         return GREATER_THAN;
">="                        return GREATER_OR_EQUAL;
"=="                        return EQUALS;
"!="                        return NOT_EQUALS;
"="                         return ASSIGNMENT;
";"                         return END_LINE;
","                         return SEPERATE;
"{"                         return LEFT_DOUBLE_BRACKET;
"}"                         return RIGHT_DOUBLE_BRACKET;
"("                         return LEFT_BRACKET;
")"                         return RIGHT_BRACKET;
"["                         return LEFT_SQUAR_BRACKET;
"]"                         return RIGHT_SQUAR_BRACKET;
"/*"(.|\n)*"*/"             ;
[a-zA-Z][a-zA-Z]*           return ID;
[0-9][0-9]*                 return NUM;
[ \t\r]+                    ;
[\n]                        ;
.                           yyerror("Error in Syntax! in line "+yylineno);


