#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *task;
    const char *tool;
    const char *verification;
} AutomationTask;

int main(void) {
    AutomationTask tasks[] = {
        {"calculate physical quantity", "calculator", "unit and estimate review"},
        {"simplify symbolic expression", "computer algebra system", "domain and equivalence check"},
        {"simulate dynamical model", "numerical simulator", "sensitivity and validation"},
        {"generate proof outline", "AI assistant", "independent proof review"},
        {"check theorem", "proof assistant", "statement audit and machine check"}
    };

    size_t count = sizeof(tasks) / sizeof(tasks[0]);

    printf("index,task,tool,verification,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,automation requires verification and interpretation\n",
               i + 1,
               tasks[i].task,
               tasks[i].tool,
               tasks[i].verification);
    }

    return EXIT_SUCCESS;
}
