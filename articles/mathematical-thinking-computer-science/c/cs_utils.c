#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void insertion_sort(int *values, size_t length) {
    for (size_t i = 1; i < length; ++i) {
        int key = values[i];
        size_t j = i;
        while (j > 0 && values[j - 1] > key) {
            values[j] = values[j - 1];
            --j;
        }
        values[j] = key;
    }
}

bool is_sorted(const int *values, size_t length) {
    for (size_t i = 1; i < length; ++i) {
        if (values[i - 1] > values[i]) return false;
    }
    return true;
}

int mod_positive(int value, int modulus) {
    int result = value % modulus;
    return result < 0 ? result + modulus : result;
}

int main(void) {
    int values[] = {5, 2, 8, 1, 3};
    size_t length = sizeof(values) / sizeof(values[0]);

    insertion_sort(values, length);

    printf("audit_type,value,interpretation\n");
    printf("is_sorted,%d,loop invariant should establish sorted output\n", is_sorted(values, length));

    for (int n = 0; n <= 30; ++n) {
        printf("mod_7_%d,%d,modular arithmetic maps values into finite residue classes\n", n, mod_positive(n, 7));
    }

    for (int n = 1; n <= 12; ++n) {
        printf("quadratic_%d,%d,complexity growth preview\n", n, n * n);
    }

    return EXIT_SUCCESS;
}
