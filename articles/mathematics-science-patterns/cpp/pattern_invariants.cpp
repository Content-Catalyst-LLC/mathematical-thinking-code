#include <algorithm>
#include <iostream>
#include <map>
#include <string>
#include <utility>
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

using Edge = std::pair<std::string, std::string>;

std::vector<int> degree_sequence(const std::vector<Edge>& edges) {
    std::map<std::string, int> degree;
    for (const auto& [a, b] : edges) {
        degree[a] += 1;
        degree[b] += 1;
    }

    std::vector<int> result;
    for (const auto& [node, value] : degree) {
        result.push_back(value);
    }

    std::sort(result.begin(), result.end(), std::greater<int>());
    return result;
}

int main() {
    std::map<std::string, std::vector<long long>> sequences{
        {"arithmetic", {2, 5, 8, 11, 14}},
        {"quadratic", {1, 4, 9, 16, 25}},
        {"misleading", {1, 2, 4, 8, 16, 31}}
    };

    std::cout << "Sequence classifications\n";
    for (const auto& [name, values] : sequences) {
        std::cout << name << ": " << classify_sequence(values) << "\n";
    }

    std::vector<Edge> cycle{{"a","b"}, {"b","c"}, {"c","d"}, {"d","a"}};
    std::cout << "\nCycle degree sequence:";
    for (int d : degree_sequence(cycle)) {
        std::cout << " " << d;
    }
    std::cout << "\n";

    return 0;
}
