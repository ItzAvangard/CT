#ifndef COOLLEXER_H
#define COOLLEXER_H

#include <iostream>
#include <fstream>

#undef yyFlexLexer
#include <FlexLexer.h>

class CoolLexer : public yyFlexLexer {
public:
    CoolLexer(std::istream& arg_yyin, std::ostream& arg_yyout) :
        yyFlexLexer{arg_yyin, arg_yyout}, out{arg_yyout}, lineno{0}, comment_level{0} {}
    virtual int yylex();

    const std::string& get_string_buffer() const
    {
        return string_buf;
    }

    void clear_string_buffer()
    {
        string_buf.clear();
    }

    const char* YYText() const {
            return yytext;
        }

private:
    void Error(const char* msg) const;

    void MultiLineCommentStart()
    {
        ++comment_level;
    }

    bool MultiLineCommentEnd()
    {
        if (--comment_level == 0)
            return true;
        return false;
    }

    std::string string_buf;
    std::ostream& out;
    int lineno;
    int comment_level;
};

#endif
