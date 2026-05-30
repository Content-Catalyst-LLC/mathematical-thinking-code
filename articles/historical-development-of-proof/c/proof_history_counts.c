#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *tradition;
    const char *style;
} Milestone;

int main(void) {
    Milestone milestones[] = {
        {"Mesopotamian", "Procedural"},
        {"Egyptian", "Procedural"},
        {"Greek", "Deductive"},
        {"Greek", "Diagrammatic"},
        {"Chinese", "Procedural"},
        {"Islamic", "Algebraic"},
        {"Analysis", "Analytic"},
        {"Foundations", "FormalLogical"},
        {"Computer", "MachineChecked"}
    };

    size_t count = sizeof(milestones) / sizeof(milestones[0]);

    printf("index,tradition,style,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,synthetic milestone for proof-history audit\n", i + 1, milestones[i].tradition, milestones[i].style);
    }

    return EXIT_SUCCESS;
}
