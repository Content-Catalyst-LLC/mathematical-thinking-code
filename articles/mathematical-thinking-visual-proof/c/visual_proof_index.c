#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *title;
    const char *role;
    const char *status;
} VisualProofRecord;

int main(void) {
    VisualProofRecord records[] = {
        {"odd sums as square layers", "diagrammatic_argument", "informally_justified"},
        {"binomial square area model", "diagrammatic_argument", "informally_justified"},
        {"dynamic geometry invariant", "heuristic", "needs_generalization"},
        {"graph drawing connectivity", "evidence", "needs_generalization"},
        {"derivative as limiting secants", "heuristic", "needs_formal_limit"}
    };

    size_t count = sizeof(records) / sizeof(records[0]);

    printf("index,title,visual_role,proof_status,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,visual insight becomes proof through abstraction and justification\n",
               i + 1,
               records[i].title,
               records[i].role,
               records[i].status);
    }

    return EXIT_SUCCESS;
}
