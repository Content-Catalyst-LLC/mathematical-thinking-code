#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void differences(const long long *values, long long *out, int n) {
    for (int i = 1; i < n; ++i) {
        out[i - 1] = values[i] - values[i - 1];
    }
}

bool all_equal(const long long *values, int n) {
    if (n <= 0) return false;
    for (int i = 1; i < n; ++i) {
        if (values[i] != values[0]) return false;
    }
    return true;
}

const char *classify(const long long *values, int n) {
    if (n < 3) return "insufficient finite evidence";

    long long d1[64];
    long long d2[64];

    differences(values, d1, n);
    differences(d1, d2, n - 1);

    if (all_equal(d1, n - 1)) return "arithmetic";
    if (all_equal(d2, n - 2)) return "quadratic";
    return "undetermined finite pattern";
}

int main(void) {
    long long arithmetic[] = {2, 5, 8, 11, 14, 17};
    long long quadratic[] = {1, 4, 9, 16, 25, 36};
    long long misleading[] = {1, 2, 4, 8, 16, 31};

    printf("sequence,classification\n");
    printf("arithmetic,%s\n", classify(arithmetic, 6));
    printf("quadratic,%s\n", classify(quadratic, 6));
    printf("misleading,%s\n", classify(misleading, 6));

    return EXIT_SUCCESS;
}
