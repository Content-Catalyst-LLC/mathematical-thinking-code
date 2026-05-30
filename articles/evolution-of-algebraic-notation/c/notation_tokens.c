#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *symbol;
    const char *context;
    const char *role;
} SymbolRecord;

int main(void) {
    SymbolRecord records[] = {
        {"x", "unknown or variable", "quantity, input, coordinate, or element"},
        {"=", "equality relation", "equation, identity, definition, or sameness"},
        {"^", "power or exponent", "repeated multiplication or generalized exponentiation"},
        {"f(x)", "function application", "output of function f at input x"},
        {"(G,*)", "algebraic structure", "set with operation under specified laws"},
        {"Ax=b", "linear system", "compressed system of linear equations"}
    };

    size_t count = sizeof(records) / sizeof(records[0]);

    printf("index,symbol,context,role,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,notation requires context and assumptions\n",
               i + 1,
               records[i].symbol,
               records[i].context,
               records[i].role);
    }

    return EXIT_SUCCESS;
}
