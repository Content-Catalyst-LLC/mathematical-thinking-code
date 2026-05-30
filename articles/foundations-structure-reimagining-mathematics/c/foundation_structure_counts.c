#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *structure;
    const char *preserved_by;
} StructureRecord;

int main(void) {
    StructureRecord records[] = {
        {"Group", "homomorphism"},
        {"Vector space", "linear map"},
        {"Topological space", "continuous map"},
        {"Graph", "graph morphism"},
        {"Category", "functor"},
        {"Formal system", "formal translation"}
    };

    size_t count = sizeof(records) / sizeof(records[0]);

    printf("index,structure,preserved_by,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,structure should be interpreted by preservation maps and assumptions\n",
               i + 1,
               records[i].structure,
               records[i].preserved_by);
    }

    return EXIT_SUCCESS;
}
