#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

using u128 = unsigned long long;

u128 factorial(unsigned int n) {
    u128 result = 1;
    for (unsigned int i = 2; i <= n; ++i) {
        result *= i;
    }
    return result;
}

u128 permutation(unsigned int n, unsigned int k) {
    return factorial(n) / factorial(n - k);
}

u128 combination(unsigned int n, unsigned int k) {
    if (k > n) return 0;
    k = std::min(k, n - k);
    u128 result = 1;
    for (unsigned int i = 1; i <= k; ++i) {
        result = result * (n - k + i) / i;
    }
    return result;
}

u128 fibonacci_tilings(unsigned int n) {
    if (n == 0 || n == 1) return 1;
    u128 previous = 1;
    u128 current = 1;

    for (unsigned int i = 2; i <= n; ++i) {
        u128 next = previous + current;
        previous = current;
        current = next;
    }

    return current;
}

int main() {
    std::cout << "Combinatorics audit\n";
    std::cout << "P(10,3)=" << permutation(10,3) << "\n";
    std::cout << "C(10,3)=" << combination(10,3) << "\n";
    std::cout << "multiples of 2 or 3 through 100=" << (100/2 + 100/3 - 100/6) << "\n";

    std::cout << "\nPascal row 10\n";
    for (unsigned int k = 0; k <= 10; ++k) {
        std::cout << "C(10," << k << ")=" << combination(10,k) << "\n";
    }

    std::cout << "\nFibonacci tiling counts\n";
    for (unsigned int n = 0; n <= 12; ++n) {
        std::cout << "n=" << n << " tilings=" << fibonacci_tilings(n) << "\n";
    }

    return 0;
}
