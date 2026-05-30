#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *model;
    const char *model_type;
    const char *purpose;
} ScientificModelRecord;

int main(void) {
    ScientificModelRecord records[] = {
        {"predator-prey model", "mechanistic", "understanding"},
        {"epidemic transmission model", "simulation", "decision_support"},
        {"climate scenario model", "hybrid", "scenario_analysis"},
        {"infrastructure resilience model", "systems", "decision_support"},
        {"AI surrogate simulation model", "machine_learning_hybrid", "prediction"}
    };

    size_t count = sizeof(records) / sizeof(records[0]);

    printf("index,model,model_type,purpose,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,scientific models should be interpreted by purpose scope uncertainty and validation status\n",
               i + 1,
               records[i].model,
               records[i].model_type,
               records[i].purpose);
    }

    return EXIT_SUCCESS;
}
