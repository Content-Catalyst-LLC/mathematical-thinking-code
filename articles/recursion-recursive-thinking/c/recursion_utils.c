#include <stdio.h>
#include <stdlib.h>

unsigned long long factorial(unsigned int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1);
}

unsigned long long fibonacci_iter(unsigned int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    unsigned long long previous = 0;
    unsigned long long current = 1;

    for (unsigned int i = 2; i <= n; ++i) {
        unsigned long long next = previous + current;
        previous = current;
        current = next;
    }

    return current;
}

unsigned long long merge_sort_cost(unsigned int n) {
    if (n <= 1) return 1;
    return 2 * merge_sort_cost(n / 2) + n;
}

int main(void) {
    printf("audit_type,n,value,interpretation\n");

    for (unsigned int n = 0; n <= 20; ++n) {
        printf("factorial,%u,%llu,recursive product from base case\n", n, factorial(n));
        printf("fibonacci,%u,%llu,iterative dynamic-programming equivalent of recurrence\n", n, fibonacci_iter(n));
    }

    for (unsigned int n = 1; n <= 1024; n *= 2) {
        printf("merge_sort_cost,%u,%llu,divide-and-conquer recurrence cost\n", n, merge_sort_cost(n));
    }

    return EXIT_SUCCESS;
}
