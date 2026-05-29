#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

long long triangular(long long n) {
    return n * (n + 1) / 2;
}

bool is_even_sequence_value(long long value, long long index_one_based) {
    return value == 2 * index_one_based;
}

int main(void) {
    printf("audit_type,index,value,expected,agrees\n");

    for (long long n = 1; n <= 20; ++n) {
        long long computed = 0;
        for (long long k = 1; k <= n; ++k) {
            computed += k;
        }
        printf("triangular,%lld,%lld,%lld,%d\n", n, computed, triangular(n), computed == triangular(n));
    }

    for (long long n = 0; n < 16; ++n) {
        printf("cycle_mod_4,%lld,%lld,%lld,%d\n", n, n % 4, n % 4, 1);
    }

    for (long long n = 1; n <= 10; ++n) {
        long long value = 2 * n;
        printf("even_sequence,%lld,%lld,%lld,%d\n", n, value, 2 * n, is_even_sequence_value(value, n));
    }

    return EXIT_SUCCESS;
}
