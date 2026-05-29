#include <iostream>
#include <numeric>
#include <string>
#include <vector>

std::vector<long long> differences(const std::vector<long long>& values) {
    std::vector<long long> result;
    for (std::size_t i = 1; i < values.size(); ++i) {
        result.push_back(values[i] - values[i - 1]);
    }
    return result;
}

bool all_equal(const std::vector<long long>& values) {
    if (values.empty()) return false;
    for (long long value : values) {
        if (value != values[0]) return false;
    }
    return true;
}

bool is_arithmetic(const std::vector<long long>& values) {
    return all_equal(differences(values));
}

bool is_quadratic(const std::vector<long long>& values) {
    return all_equal(differences(differences(values)));
}

long long triangular(long long n) {
    return n * (n + 1) / 2;
}

int main() {
    std::vector<std::pair<std::string, std::vector<long long>>> sequences{
        {"even", {2, 4, 6, 8, 10, 12}},
        {"triangular", {1, 3, 6, 10, 15, 21}},
        {"squares", {1, 4, 9, 16, 25, 36}},
        {"false_prefix", {1, 2, 4, 8, 16, 31}}
    };

    std::cout << "Sequence pattern audit\n";
    for (const auto& item : sequences) {
        std::cout << item.first
                  << " arithmetic=" << is_arithmetic(item.second)
                  << " quadratic=" << is_quadratic(item.second)
                  << "\n";
    }

    std::cout << "\nTriangular finite evidence audit\n";
    for (long long n = 1; n <= 10; ++n) {
        long long computed = 0;
        for (long long k = 1; k <= n; ++k) computed += k;
        std::cout << "n=" << n << " computed=" << computed
                  << " formula=" << triangular(n)
                  << " agrees=" << (computed == triangular(n)) << "\n";
    }

    std::cout << "Finite evidence suggests; proof establishes generality.\n";
    return 0;
}
