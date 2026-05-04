#include <stdio.h>

unsigned long triangular_number(unsigned long n) {
    return n * (n + 1) / 2;
}

unsigned long sum_first_n(unsigned long n) {
    unsigned long total = 0;

    for (unsigned long i = 1; i <= n; i++) {
        total += i;
    }

    return total;
}

int main(void) {
    printf("Triangular number checks\n");

    for (unsigned long n = 1; n <= 20; n++) {
        unsigned long direct_sum = sum_first_n(n);
        unsigned long formula = triangular_number(n);

        printf("n=%lu sum=%lu formula=%lu matches=%s\n",
               n,
               direct_sum,
               formula,
               direct_sum == formula ? "true" : "false");
    }

    return 0;
}
