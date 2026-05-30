#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *period;
    const char *tradition;
    const char *mode;
} Milestone;

int main(void) {
    Milestone milestones[] = {
        {"Antiquity", "Mesopotamian", "Procedural"},
        {"Antiquity", "Egyptian", "Procedural"},
        {"Classical", "Greek", "Deductive"},
        {"Classical", "Greek", "Analytic"},
        {"Classical-medieval", "Indian", "Algebraic"},
        {"Classical-medieval", "Chinese", "Procedural"},
        {"Medieval", "Islamic", "Algebraic"},
        {"Modern", "European", "Structural"},
        {"Contemporary", "International", "FormalVerified"}
    };

    size_t count = sizeof(milestones) / sizeof(milestones[0]);

    printf("index,period,tradition,mode,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,synthetic milestone for historical mathematical-thinking audit\n",
               i + 1,
               milestones[i].period,
               milestones[i].tradition,
               milestones[i].mode);
    }

    return EXIT_SUCCESS;
}
