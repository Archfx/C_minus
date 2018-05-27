
%x BLOCK_COMMENT
%{
    #include "parser.tab.h"
    extern int yylineno;

    void yyerror (const char *str) {

        fprintf (stderr, "in Line %d :%s\n",yylineno,str);
    }
    extern char* yytext;

    

%}
%option noyywrap
%option yylineno    

%%
<INITIAL>"/*"         {BEGIN(BLOCK_COMMENT);}
<BLOCK_COMMENT>"*/"      {BEGIN(INITIAL);}
<BLOCK_COMMENT>[^*\n]+   ;
<BLOCK_COMMENT>"*"       ;
<BLOCK_COMMENT>\n        { yylineno++; }
<BLOCK_COMMENT><<EOF>>      {
                            yyerror("Unfinished Comment");
                            yyterminate();
                        }



"if"                        return IF;
"else"                      return ELSE;
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
[a-zA-Z][a-zA-Z]*           return ID;
[0-9][0-9]*                 return NUM;
[ \t\r]+                    ;
[\n]                        ;
.                           yyerror(" Syntax Error!");



