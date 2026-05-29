#include <algorithm>
#include <iostream>
#include <map>
#include <numeric>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

struct Fraction {
    long long numerator;
    long long denominator;

    std::pair<long long, long long> normalized() const {
        if (denominator == 0) {
            throw std::runtime_error("denominator cannot be zero");
        }

        long long sign = denominator < 0 ? -1 : 1;
        long long n = numerator * sign;
        long long d = denominator * sign;
        long long g = std::gcd(std::llabs(n), std::llabs(d));
        return {n / g, d / g};
    }
};

using Edge = std::pair<std::string, std::string>;

std::vector<int> degree_sequence(const std::vector<Edge>& edges) {
    std::map<std::string, int> degree;
    for (const auto& [a, b] : edges) {
        degree[a] += 1;
        degree[b] += 1;
    }

    std::vector<int> sequence;
    for (const auto& [node, value] : degree) {
        sequence.push_back(value);
    }

    std::sort(sequence.begin(), sequence.end(), std::greater<int>());
    return sequence;
}

int main() {
    std::vector<Fraction> fractions{{1,2}, {2,4}, {3,6}, {2,3}, {-2,-4}};
    std::map<std::pair<long long, long long>, int> classes;

    for (const auto& fraction : fractions) {
        classes[fraction.normalized()] += 1;
    }

    std::cout << "Fraction equivalence classes\n";
    for (const auto& [representative, count] : classes) {
        std::cout << representative.first << "/" << representative.second << ": " << count << "\n";
    }

    std::vector<Edge> cycle{{"a","b"}, {"b","c"}, {"c","d"}, {"d","a"}};
    std::cout << "\nCycle degree sequence:";
    for (int degree : degree_sequence(cycle)) {
        std::cout << " " << degree;
    }
    std::cout << "\n";

    return 0;
}
