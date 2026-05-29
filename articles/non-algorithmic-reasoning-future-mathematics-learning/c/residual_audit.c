#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

double quadratic_residual(double x) {
    return x * x - 5.0 * x + 6.0;
}

const char* quality(bool assumptions_checked, bool interpretation_given, bool justification_given) {
    if (assumptions_checked && interpretation_given && justification_given) {
        return "strong reasoning";
    }
    if (justification_given) {
        return "partially justified";
    }
    return "procedural or incomplete";
}

int main(void) {
    double candidates[] = {2.0, 3.0, 4.0};

    printf("candidate,residual,passes_residual_check\n");
    for (int i = 0; i < 3; ++i) {
        double x = candidates[i];
        double residual = quadratic_residual(x);
        printf("%.6f,%.12f,%d\n", x, residual, fabs(residual) < 1e-10);
    }

    printf("\nquality_case,result\n");
    printf("formula_only,%s\n", quality(false, false, false));
    printf("verified_not_interpreted,%s\n", quality(true, false, true));
    printf("verified_and_interpreted,%s\n", quality(true, true, true));

    return EXIT_SUCCESS;
}
