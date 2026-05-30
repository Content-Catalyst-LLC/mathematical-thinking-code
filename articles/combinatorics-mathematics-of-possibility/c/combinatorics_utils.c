#include <stdio.h>
#include <stdlib.h>

unsigned long long factorial(unsigned int n) {
    unsigned long long result = 1;
    for (unsigned int i = 2; i <= n; ++i) {
        result *= i;
    }
    return result;
}

unsigned long long permutation(unsigned int n, unsigned int k) {
    return factorial(n) / factorial(n - k);
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

unsigned long long fibonacci_tilings(unsigned int n) {
    if (n == 0 || n == 1) return 1;

    unsigned long long previous = 1;
    unsigned long long current = 1;

    for (unsigned int i = 2; i <= n; ++i) {
        unsigned long long next = previous + current;
        previous = current;
        current = next;
    }

    return current;
}

int main(void) {
    printf("audit_type,n,k,value\n");

    for (unsigned int k = 0; k <= 10; ++k) {
        printf("binomial_10_k,10,%u,%llu\n", k, binomial(10, k));
    }

    for (unsigned int n = 0; n <= 20; ++n) {
        printf("fibonacci_tilings,%u,NA,%llu\n", n, fibonacci_tilings(n));
    }

    printf("permutation_10_3,10,3,%llu\n", permutation(10, 3));
    printf("combination_10_3,10,3,%llu\n", binomial(10, 3));
    printf("inclusion_exclusion_2_or_3_to_100,100,NA,%u\n", 100 / 2 + 100 / 3 - 100 / 6);

    return EXIT_SUCCESS;
}
