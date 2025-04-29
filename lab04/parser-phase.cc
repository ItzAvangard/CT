#include <unistd.h>
#include <cstdio>
#include "cool-tree.h"
#include "utilities.h"
#include "cool-parse.h"

std::FILE *token_file = stdin;
extern Classes parse_results;
extern Program ast_root;

extern int curr_lineno;
const char *curr_filename = "<stdin>";
extern int parse_errors;

// Debug flags
extern int yy_flex_debug;
extern int cool_yydebug;
int lex_verbose = 0;

extern int cool_yyparse();

void print_usage() {
    std::cerr << "Usage: parser [-v] <input file>\n";
    std::cerr << "  -v: verbose output\n";
}

int main(int argc, char **argv)
{
    yy_flex_debug = 0;
    cool_yydebug = 0;
    lex_verbose  = 0;

    int opt;
    while ((opt = getopt(argc, argv, "v")) != -1) {
        switch (opt) {
            case 'v':
                yy_flex_debug = 1;
                cool_yydebug = 1;
                lex_verbose = 1;
                break;
            default:
                print_usage();
                return 1;
        }
    }

    if (optind >= argc) {
        print_usage();
        return 1;
    }

    for (int i = optind; i < argc; i++) {
        token_file = std::fopen(argv[i], "r");
        if (token_file == NULL) {
            std::cerr << "Error: can not open file " << argv[i] << std::endl;
            std::exit(1);
        }
        curr_lineno = 1;
        curr_filename = argv[i];

        cool_yyparse();
        if (parse_errors != 0) {
            std::cerr << "Error: parse errors\n";
            std::exit(1);
        }

        if (lex_verbose) {
            std::cerr << "\nSymbol Tables:\n";
            std::cerr << "String Table:\n";
            stringtable.print();
            std::cerr << "\nIdentifier Table:\n";
            idtable.print();
            std::cerr << "\nInteger Table:\n";
            inttable.print();
        }

        ast_root->dump_with_types(std::cerr, 0);

        std::fclose(token_file);
    }

    return 0;
}
