#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *category;
    const char *objects;
    const char *morphisms;
    const char *preserved;
} CategoryRecord;

int main(void) {
    CategoryRecord records[] = {
        {"Set", "sets", "functions", "element assignment"},
        {"Grp", "groups", "group homomorphisms", "group operation"},
        {"Top", "topological spaces", "continuous maps", "topological continuity"},
        {"Vect", "vector spaces", "linear maps", "linear structure"},
        {"Poset", "partially ordered sets", "monotone maps", "order relation"}
    };

    size_t count = sizeof(records) / sizeof(records[0]);

    printf("index,category,objects,morphisms,preserved_structure,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,%s,category-level abstraction tracks objects arrows and preserved structure\n",
               i + 1,
               records[i].category,
               records[i].objects,
               records[i].morphisms,
               records[i].preserved);
    }

    return EXIT_SUCCESS;
}
