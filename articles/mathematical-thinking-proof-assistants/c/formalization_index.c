#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *stage;
    const char *human_role;
    const char *machine_role;
} FormalizationStage;

int main(void) {
    FormalizationStage stages[] = {
        {"Define", "choose objects and structures", "check syntax and types"},
        {"State", "state intended theorem", "represent proposition"},
        {"Prove", "guide strategy and lemmas", "track goals and accept valid steps"},
        {"Check", "understand trust boundary", "check derivation"},
        {"Interpret", "explain meaning and scope", "no contextual judgment"}
    };

    size_t count = sizeof(stages) / sizeof(stages[0]);

    printf("index,stage,human_role,machine_role,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,proof assistants check derivations while humans preserve meaning\n",
               i + 1,
               stages[i].stage,
               stages[i].human_role,
               stages[i].machine_role);
    }

    return EXIT_SUCCESS;
}
