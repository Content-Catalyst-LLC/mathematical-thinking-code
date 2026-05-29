#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

long long sum_first_n_computed(int n) {
    long long total = 0;
    for (int k = 1; k <= n; ++k) {
        total += k;
    }
    return total;
}

long long sum_first_n_formula(int n) {
    return (long long)n * (n + 1) / 2;
}

bool even_square_property(int n) {
    if (n % 2 != 0) return true;
    return (n * n) % 2 == 0;
}

int main(void) {
    printf("test_type,n_or_value,computed,expected_or_property,agrees\n");

    for (int n = 1; n <= 50; ++n) {
        long long computed = sum_first_n_computed(n);
        long long formula = sum_first_n_formula(n);
        printf("sum_first_n,%d,%lld,%lld,%d\n", n, computed, formula, computed == formula);
    }

    for (int n = -20; n <= 20; ++n) {
        printf("even_square,%d,%d,even_square_property,%d\n", n, n * n, even_square_property(n));
    }

    return EXIT_SUCCESS;
}
