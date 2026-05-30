#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *practice;
    const char *medium;
    const char *method;
} HistoricalPractice;

int main(void) {
    HistoricalPractice practices[] = {
        {"scribal calculation", "tablet/table", "procedure"},
        {"Euclidean geometry", "diagram/proposition", "demonstration"},
        {"symbolic algebra", "notation/equation", "symbolic transformation"},
        {"mathematical modeling", "equation/graph/data", "validation"},
        {"proof assistant formalization", "proof script/library", "machine check"}
    };

    size_t count = sizeof(practices) / sizeof(practices[0]);

    printf("index,practice,medium,method,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,historical understanding links medium method and meaning\n",
               i + 1,
               practices[i].practice,
               practices[i].medium,
               practices[i].method);
    }

    return EXIT_SUCCESS;
}
