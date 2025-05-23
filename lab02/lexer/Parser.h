#ifndef PARSER_H
#define PARSER_H

/* Token types */
enum TokenType {
    TOKEN_CLASS = 1,
    TOKEN_INHERITS,
    TOKEN_IF,
    TOKEN_THEN,
    TOKEN_ELSE,
    TOKEN_FI,
    TOKEN_WHILE,
    TOKEN_LOOP,
    TOKEN_POOL,
    TOKEN_LET,
    TOKEN_IN,
    TOKEN_CASE,
    TOKEN_OF,
    TOKEN_ESAC,
    TOKEN_NEW,
    TOKEN_ISVOID,
    TOKEN_INTEGER,
    TOKEN_STRING,
    TOKEN_IDENTIFIER,
    TOKEN_TRUE,
    TOKEN_FALSE,
    TOKEN_PLUS,
    TOKEN_MINUS,
    TOKEN_MULTIPLY,
    TOKEN_DIVIDE,
    TOKEN_ASSIGN,
    TOKEN_LESS,
    TOKEN_LESS_EQ,
    TOKEN_EQUAL,
    TOKEN_NOT,
    TOKEN_LEFT_BRACE,
    TOKEN_RIGHT_BRACE,
    TOKEN_LEFT_PAREN,
    TOKEN_RIGHT_PAREN,
    TOKEN_SEMICOLON,
    TOKEN_COLON,
    TOKEN_DOT,
    TOKEN_COMMA,
    TOKEN_ARROW,
    TOKEN_AT,
    TOKEN_ERROR
};

#endif