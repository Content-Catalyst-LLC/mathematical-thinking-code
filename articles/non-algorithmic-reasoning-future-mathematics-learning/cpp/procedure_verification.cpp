#include <cmath>
#include <iostream>
#include <string>
#include <vector>

double quadratic_residual(double x) {
    return x * x - 5.0 * x + 6.0;
}

std::string quality(bool assumptions_checked, bool interpretation_given, bool justification_given) {
    if (assumptions_checked && interpretation_given && justification_given) {
        return "strong reasoning";
    }
    if (justification_given) {
        return "partially justified";
    }
    return "procedural or incomplete";
}

int main() {
    std::vector<double> candidates{2.0, 3.0, 4.0};

    std::cout << "Quadratic root residual checks\n";
    for (double x : candidates) {
        double residual = quadratic_residual(x);
        std::cout << "x=" << x
                  << " residual=" << residual
                  << " passes=" << (std::abs(residual) < 1e-10)
                  << "\n";
    }

    std::cout << "\nReasoning quality examples\n";
    std::cout << quality(false, false, false) << "\n";
    std::cout << quality(true, false, true) << "\n";
    std::cout << quality(true, true, true) << "\n";

    return 0;
}
