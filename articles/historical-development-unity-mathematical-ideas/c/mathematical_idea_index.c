#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *idea;
    const char *field;
    const char *invariant;
} MathematicalIdea;

int main(void) {
    MathematicalIdea ideas[] = {
        {"quantity", "arithmetic", "same numerical form"},
        {"proportion", "geometry", "same relative relation"},
        {"proof", "logic", "derivability under rules"},
        {"algorithm", "computation", "specified input-output behavior"},
        {"group", "algebra", "operation structure"},
        {"graph", "discrete mathematics", "adjacency pattern"}
    };

    size_t count = sizeof(ideas) / sizeof(ideas[0]);

    printf("index,idea,field,invariant,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,mathematical unity depends on preserved structure and context\n",
               i + 1,
               ideas[i].idea,
               ideas[i].field,
               ideas[i].invariant);
    }

    return EXIT_SUCCESS;
}
