#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *metric;
    const char *metric_type;
    const char *target;
    const char *consequence;
} MetricRecord;

int main(void) {
    MetricRecord records[] = {
        {"student test score", "proxy", "learning", "high_stakes"},
        {"research citation count", "indicator", "research influence", "moderate_stakes"},
        {"AI benchmark score", "benchmark", "model capability", "high_stakes"},
        {"credit risk score", "risk_score", "loan repayment risk", "high_stakes"},
        {"composite sustainability score", "score", "sustainability performance", "high_stakes"}
    };

    size_t count = sizeof(records) / sizeof(records[0]);

    printf("index,metric,metric_type,target_concept,consequence_level,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,%s,metrics should be interpreted by purpose validity uncertainty context and governance\n",
               i + 1,
               records[i].metric,
               records[i].metric_type,
               records[i].target,
               records[i].consequence);
    }

    return EXIT_SUCCESS;
}
