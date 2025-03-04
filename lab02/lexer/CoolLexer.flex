%{
#include <iostream>
#include <fstream>
#include <cstdio>
#include <string>

#include "Parser.h"
#include "CoolLexer.h"

#undef YY_DECL
#define YY_DECL int CoolLexer::yylex()

%}

white_space       [ \t\f\r\v]+
newline           \n
digit             [0-9]
alpha             [A-Za-z_]
alpha_num         ({alpha}|{digit})
hex_digit         [0-9a-fA-F]
identifier        {alpha}{alpha_num}*
unsigned_integer  {digit}+
hex_integer       ${hex_digit}{hex_digit}*
exponent          e[+-]?{digit}+
i                 {unsigned_integer}
real              ({i}\.{i}?|{i}?\.{i}){exponent}?
string            \"([^\"\n]|\\\")*\"
bad_string        \'([^'\n]|\'\')*

%x COMMENT
%x STRING

%option warn nodefault batch noyywrap c++
%option yylineno
%option yyclass="CoolLexer"

%%

"(*"                {BEGIN(COMMENT); MultiLineCommentStart();}
<COMMENT>{
    "(*"            {MultiLineCommentStart();}
    "*)"            {if (MultiLineCommentEnd()) BEGIN(INITIAL);}
    \n              {++lineno;}
    <<EOF>>         {Error("EOF in multi line comment");}
    .               /*skip*/
}
"*)"                {Error("Comment end without start");}

\"                  {BEGIN(STRING);}
<STRING>{
    \\b             {string_buf += "\b";}
    \\t             {string_buf += "\t";}
    \\n             {string_buf += "\n";}
    \\f             {string_buf += "\f";}
    \\\n            {/* Игнорируем экранированный \n*/}
    \\[^\n]         {string_buf += yytext[1];}
    \n              {Error("Unescaped newline");}
    \0              {Error("Null character");}
    <<EOF>>         {Error("EOF in string");}
    [^\\\n\"]+      {string_buf += yytext;}
    \"              {BEGIN(INITIAL); return TOKEN_STRING;}
}

"--".*              { /* skip single-line comments */ }

"class"             return TOKEN_CLASS;
"inherits"          return TOKEN_INHERITS;
"if"                return TOKEN_IF;
"then"              return TOKEN_THEN;
"else"              return TOKEN_ELSE;
"fi"                return TOKEN_FI;
"while"             return TOKEN_WHILE;
"loop"              return TOKEN_LOOP;
"pool"              return TOKEN_POOL;
"let"               return TOKEN_LET;
"in"                return TOKEN_IN;
"case"              return TOKEN_CASE;
"of"                return TOKEN_OF;
"esac"              return TOKEN_ESAC;
"new"               return TOKEN_NEW;
"isvoid"            return TOKEN_ISVOID;

{unsigned_integer}  return TOKEN_INTEGER;
{string}            return TOKEN_STRING;
{identifier}        return TOKEN_IDENTIFIER;

"+"                 return TOKEN_PLUS;
"-"                 return TOKEN_MINUS;
"*"                 return TOKEN_MULTIPLY;
"/"                 return TOKEN_DIVIDE;
"<-"                return TOKEN_ASSIGN;
"<"                 return TOKEN_LESS;
"<="                return TOKEN_LESS_EQ;
"="                 return TOKEN_EQUAL;
"{"                 return TOKEN_LEFT_BRACE;
"}"                 return TOKEN_RIGHT_BRACE;
"("                 return TOKEN_LEFT_PAREN;
")"                 return TOKEN_RIGHT_PAREN;
";"                 return TOKEN_SEMICOLON;
":"                 return TOKEN_COLON;
"."                 return TOKEN_DOT;
","                 return TOKEN_COMMA;
"=>"                return TOKEN_ARROW;
"@"                 return TOKEN_AT;

{white_space}       { /* skip spaces and tabs */ }
\n                  { lineno++; }
.                   return TOKEN_ERROR; // unrecognized character

%%

void CoolLexer::Error(const char* msg) const
{
    std::cerr << "Lexer error (line " << lineno << "): " << msg << ": lexeme '" << YYText() << "'\n";
    std::exit(YY_EXIT_FAILURE);
}