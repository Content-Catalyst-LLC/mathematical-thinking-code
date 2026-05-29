#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

unsigned long long fibonacci(unsigned int n) {
    if (n == 0) return 0;
    unsigned long long previous = 0;
    unsigned long long current = 1;

    for (unsigned int i = 2; i <= n; ++i) {
        unsigned long long next = previous + current;
        previous = current;
        current = next;
    }

    return current;
}

unsigned long long binomial(unsigned int n, unsigned int k) {
    if (k > n) return 0;
    if (k > n - k) k = n - k;

    unsigned long long result = 1;
    for (unsigned int i = 1; i <= k; ++i) {
        result = result * (n - k + i) / i;
    }
    return result;
}

bool implies(bool p, bool q) {
    return (!p) || q;
}

int main(void) {
    printf("audit_type,index,value,secondary_value\n");

    for (unsigned int n = 0; n <= 20; ++n) {
        printf("fibonacci,%u,%llu,%u\n", n, fibonacci(n), n % 7);
    }

    for (unsigned int k = 0; k <= 10; ++k) {
        printf("binomial_10_choose_k,%u,%llu,0\n", k, binomial(10, k));
    }

    printf("\nP,Q,AND,OR,IMPLIES,XOR\n");
    for (int p = 0; p <= 1; ++p) {
        for (int q = 0; q <= 1; ++q) {
            printf("%d,%d,%d,%d,%d,%d\n", p, q, p && q, p || q, implies(p, q), (p != q));
        }
    }

    return EXIT_SUCCESS;
}
