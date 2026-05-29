#include <stdio.h>
#include <stdlib.h>

void print_odd_square_identity(int n) {
    long long cumulative = 0;

    printf("n,cumulative_odd_sum,n_squared,identity_holds\n");
    for (int i = 1; i <= n; ++i) {
        cumulative += 2 * i - 1;
        printf("%d,%lld,%d,%d\n", i, cumulative, i * i, cumulative == (long long)i * i);
    }
}

void print_cycle4_degree_sequence(void) {
    int degrees[4] = {2, 2, 2, 2};
    printf("\ncycle4_degree_sequence\n");
    for (int i = 0; i < 4; ++i) {
        printf("%d\n", degrees[i]);
    }
}

int main(void) {
    print_odd_square_identity(20);
    print_cycle4_degree_sequence();
    return EXIT_SUCCESS;
}
