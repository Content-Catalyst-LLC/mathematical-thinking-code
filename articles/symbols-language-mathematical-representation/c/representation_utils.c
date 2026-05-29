#include <stdio.h>
#include <stdlib.h>

void print_adjacency_matrix(void) {
    const char *vertices[] = {"a", "b", "c", "d"};
    int matrix[4][4] = {
        {0, 1, 0, 1},
        {1, 0, 1, 0},
        {0, 1, 0, 1},
        {1, 0, 1, 0}
    };

    printf("vertex_order,a,b,c,d\n");
    for (int i = 0; i < 4; ++i) {
        printf("%s,%d,%d,%d,%d\n", vertices[i], matrix[i][0], matrix[i][1], matrix[i][2], matrix[i][3]);
    }
}

int main(void) {
    printf("Adjacency matrix representation for cycle graph C4\n");
    print_adjacency_matrix();
    printf("Interpretation: matrix representation preserves adjacency after vertex order is fixed.\n");
    return EXIT_SUCCESS;
}
