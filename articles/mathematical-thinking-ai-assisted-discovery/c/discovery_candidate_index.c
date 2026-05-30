#include <stdio.h>
#include <stdlib.h>

typedef struct {
    const char *candidate;
    const char *output_type;
    const char *status;
} DiscoveryCandidate;

int main(void) {
    DiscoveryCandidate candidates[] = {
        {"possible graph invariant bound", "conjecture", "tested_on_examples"},
        {"candidate combinatorial construction", "program", "tested_on_examples"},
        {"AI-generated proof outline", "proof_sketch", "untested"},
        {"formalized lemma candidate", "formal_statement", "untested"},
        {"generated formal proof script", "formal_proof_script", "machine_check_required"}
    };

    size_t count = sizeof(candidates) / sizeof(candidates[0]);

    printf("index,candidate,output_type,status,interpretation\n");
    for (size_t i = 0; i < count; ++i) {
        printf("%zu,%s,%s,%s,AI output remains candidate material until tested proved and interpreted\n",
               i + 1,
               candidates[i].candidate,
               candidates[i].output_type,
               candidates[i].status);
    }

    return EXIT_SUCCESS;
}
