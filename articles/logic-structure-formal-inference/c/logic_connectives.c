#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool implies(bool p, bool q) {
    return (!p) || q;
}

int main(void) {
    bool values[2] = {false, true};

    printf("P,Q,P_and_Q,P_or_Q,not_P,P_implies_Q,contrapositive,equivalent\n");

    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 2; ++j) {
            bool p = values[i];
            bool q = values[j];
            bool original = implies(p, q);
            bool contrapositive = implies(!q, !p);

            printf(
                "%d,%d,%d,%d,%d,%d,%d,%d\n",
                p,
                q,
                p && q,
                p || q,
                !p,
                original,
                contrapositive,
                original == contrapositive
            );
        }
    }

    return EXIT_SUCCESS;
}
