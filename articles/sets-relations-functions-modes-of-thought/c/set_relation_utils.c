#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define N 4

bool mod2_relation(int x, int y) {
    return x % 2 == y % 2;
}

bool is_reflexive(const int domain[], int n) {
    for (int i = 0; i < n; ++i) {
        if (!mod2_relation(domain[i], domain[i])) return false;
    }
    return true;
}

bool is_symmetric(const int domain[], int n) {
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (mod2_relation(domain[i], domain[j]) && !mod2_relation(domain[j], domain[i])) {
                return false;
            }
        }
    }
    return true;
}

bool is_transitive(const int domain[], int n) {
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            for (int k = 0; k < n; ++k) {
                if (mod2_relation(domain[i], domain[j]) &&
                    mod2_relation(domain[j], domain[k]) &&
                    !mod2_relation(domain[i], domain[k])) {
                    return false;
                }
            }
        }
    }
    return true;
}

int main(void) {
    int domain[N] = {1, 2, 3, 4};

    printf("property,value\n");
    printf("mod2_reflexive,%d\n", is_reflexive(domain, N));
    printf("mod2_symmetric,%d\n", is_symmetric(domain, N));
    printf("mod2_transitive,%d\n", is_transitive(domain, N));

    printf("\ninput,output,rule\n");
    for (int i = 0; i < N; ++i) {
        printf("%d,%d,double\n", domain[i], 2 * domain[i]);
    }

    return EXIT_SUCCESS;
}
