#include <algorithm>
#include <iostream>
#include <map>
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
    return std::all_of(values.begin(), values.end(), [&](long long x) { return x == values[0]; });
}

std::string classify_sequence(const std::vector<long long>& values) {
    if (values.size() < 3) return "insufficient finite evidence";
    auto d1 = differences(values);
    auto d2 = differences(d1);
    if (all_equal(d1)) return "arithmetic";
    if (!d2.empty() && all_equal(d2)) return "quadratic";
    return "undetermined finite pattern";
}

long long sum_first_n(long long n) {
    return n * (n + 1) / 2;
}

int main() {
    std::map<std::string, std::vector<long long>> sequences{
        {"arithmetic", {2, 5, 8, 11, 14}},
        {"quadratic", {1, 4, 9, 16, 25}},
        {"false_prefix", {1, 2, 4, 8, 16, 31}}
    };

    std::cout << "Sequence discovery audit\n";
    for (const auto& [name, values] : sequences) {
        std::cout << name << ": " << classify_sequence(values) << "\n";
    }

    std::cout << "\nFinite sum formula audit\n";
    for (long long n = 1; n <= 10; ++n) {
        long long computed = 0;
        for (long long k = 1; k <= n; ++k) computed += k;
        std::cout << n << ": computed=" << computed << " formula=" << sum_first_n(n)
                  << " agrees=" << (computed == sum_first_n(n)) << "\n";
    }

    std::cout << "Finite audits suggest conjectures; proof establishes generality.\n";
    return 0;
}
