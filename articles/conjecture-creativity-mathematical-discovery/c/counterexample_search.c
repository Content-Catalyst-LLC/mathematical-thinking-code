#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool is_even(int n) {
    return n % 2 == 0;
}

bool even_square_claim(int n) {
    return !is_even(n) || is_even(n * n);
}

long long sum_first_n(int n) {
    long long total = 0;
    for (int k = 1; k <= n; ++k) {
        total += k;
    }
    return total;
}

long long sum_formula(int n) {
    return (long long)n * (n + 1) / 2;
}

int main(void) {
    printf("audit_type,input,computed,expected_or_property,agrees\n");

    for (int n = -50; n <= 50; ++n) {
        printf("even_square,%d,%d,if_even_then_square_even,%d\n", n, n * n, even_square_claim(n));
    }

    for (int n = 1; n <= 50; ++n) {
        long long computed = sum_first_n(n);
        long long formula = sum_formula(n);
        printf("sum_first_n,%d,%lld,%lld,%d\n", n, computed, formula, computed == formula);
    }

    return EXIT_SUCCESS;
}
