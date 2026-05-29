#include <stdio.h>
#include <stdlib.h>

void fibonacci(int n, long long *out) {
    if (n <= 0) return;
    out[0] = 0;
    if (n == 1) return;
    out[1] = 1;
    for (int i = 2; i < n; ++i) {
        out[i] = out[i - 1] + out[i - 2];
    }
}

int main(void) {
    const int n = 25;
    long long values[n];

    fibonacci(n, values);

    printf("index,value,mod_2,mod_3,mod_5\n");
    for (int i = 0; i < n; ++i) {
        printf("%d,%lld,%lld,%lld,%lld\n", i, values[i], values[i] % 2, values[i] % 3, values[i] % 5);
    }

    return EXIT_SUCCESS;
}
