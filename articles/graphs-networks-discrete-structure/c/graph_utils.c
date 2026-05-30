#include <stdio.h>
#include <stdlib.h>

#define N 5

void add_edge(int adjacency[N][N], int a, int b) {
    adjacency[a][b] = 1;
    adjacency[b][a] = 1;
}

int degree(int adjacency[N][N], int node) {
    int total = 0;
    for (int j = 0; j < N; ++j) {
        total += adjacency[node][j];
    }
    return total;
}

int main(void) {
    int adjacency[N][N] = {0};
    const char *labels[N] = {"A", "B", "C", "D", "E"};

    add_edge(adjacency, 0, 1);
    add_edge(adjacency, 0, 2);
    add_edge(adjacency, 1, 3);

    printf("vertex,degree,interpretation\n");
    int degree_sum = 0;
    for (int i = 0; i < N; ++i) {
        int d = degree(adjacency, i);
        degree_sum += d;
        printf("%s,%d,degree counts local adjacency\n", labels[i], d);
    }

    printf("degree_sum,%d,handshaking audit\n", degree_sum);
    printf("twice_edge_count,%d,handshaking audit\n", 2 * 3);

    return EXIT_SUCCESS;
}
