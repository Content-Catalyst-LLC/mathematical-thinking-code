#include <stdio.h>
#include <stdlib.h>

long long gcd_ll(long long a, long long b) {
    if (a < 0) a = -a;
    if (b < 0) b = -b;
    while (b != 0) {
        long long r = a % b;
        a = b;
        b = r;
    }
    return a;
}

void normalize_fraction(long long numerator, long long denominator, long long *out_n, long long *out_d) {
    if (denominator == 0) {
        fprintf(stderr, "denominator cannot be zero\n");
        exit(EXIT_FAILURE);
    }

    long long sign = denominator < 0 ? -1 : 1;
    long long n = numerator * sign;
    long long d = denominator * sign;
    long long g = gcd_ll(n, d);

    *out_n = n / g;
    *out_d = d / g;
}

int main(void) {
    long long fractions[][2] = {
        {1, 2}, {2, 4}, {3, 6}, {2, 3}, {-2, -4}, {6, 9}, {10, 15}
    };

    int count = sizeof(fractions) / sizeof(fractions[0]);

    printf("raw_n,raw_d,normalized_n,normalized_d\n");
    for (int i = 0; i < count; ++i) {
        long long n;
        long long d;
        normalize_fraction(fractions[i][0], fractions[i][1], &n, &d);
        printf("%lld,%lld,%lld,%lld\n", fractions[i][0], fractions[i][1], n, d);
    }

    return EXIT_SUCCESS;
}
