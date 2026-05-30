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

int binary_search(const int *values, size_t length, int target) {
    size_t low = 0;
    size_t high = length;

    while (low < high) {
        size_t mid = low + (high - low) / 2;
        if (values[mid] == target) return (int) mid;
        if (values[mid] < target) low = mid + 1;
        else high = mid;
    }

    return -1;
}

int main(void) {
    int values[] = {5, 2, 8, 1, 3, 2};
    size_t length = sizeof(values) / sizeof(values[0]);

    insertion_sort(values, length);

    printf("audit_type,value,interpretation\n");
    printf("is_sorted,%d,postcondition requires sorted output\n", is_sorted(values, length));
    printf("binary_search_8,%d,binary search requires sorted input precondition\n", binary_search(values, length, 8));

    for (int n = 1; n <= 20; ++n) {
        printf("quadratic_%d,%d,complexity growth preview\n", n, n * n);
    }

    return EXIT_SUCCESS;
}
