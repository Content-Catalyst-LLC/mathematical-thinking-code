#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double expanded_linear(double x) {
    return 2.0 * x + 6.0;
}

double factored_linear(double x) {
    return 2.0 * (x + 3.0);
}

double residual_linear(double x) {
    return 3.0 * x + 2.0 - 17.0;
}

int main(void) {
    printf("audit_type,input,left_or_candidate,right_or_residual,passes\n");

    for (int x = -10; x <= 10; ++x) {
        double left = expanded_linear((double)x);
        double right = factored_linear((double)x);
        printf("equivalence,%d,%.6f,%.6f,%d\n", x, left, right, fabs(left - right) < 1e-10);
    }

    double candidates[] = {4.0, 5.0, 6.0};
    for (int i = 0; i < 3; ++i) {
        double candidate = candidates[i];
        double residual = residual_linear(candidate);
        printf("equation_residual,%.6f,%.6f,%.12f,%d\n", candidate, candidate, residual, fabs(residual) < 1e-10);
    }

    return EXIT_SUCCESS;
}
