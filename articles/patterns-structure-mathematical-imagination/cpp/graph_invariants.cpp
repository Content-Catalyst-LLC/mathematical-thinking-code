#include <algorithm>
#include <iostream>
#include <map>
#include <string>
#include <utility>
#include <vector>

using Edge = std::pair<std::string, std::string>;

std::vector<int> degree_sequence(const std::vector<Edge>& edges) {
    std::map<std::string, int> degree;

    for (const auto& [a, b] : edges) {
        degree[a] += 1;
        degree[b] += 1;
    }

    std::vector<int> sequence;
    for (const auto& [node, d] : degree) {
        sequence.push_back(d);
    }

    std::sort(sequence.begin(), sequence.end(), std::greater<int>());
    return sequence;
}

void print_sequence(const std::vector<int>& values) {
    for (std::size_t i = 0; i < values.size(); ++i) {
        if (i > 0) std::cout << " ";
        std::cout << values[i];
    }
    std::cout << "\n";
}

int main() {
    std::map<std::string, std::vector<Edge>> graphs{
        {"cycle4", {{"a","b"}, {"b","c"}, {"c","d"}, {"d","a"}}},
        {"path4", {{"a","b"}, {"b","c"}, {"c","d"}}},
        {"star4", {{"o","a"}, {"o","b"}, {"o","c"}, {"o","d"}}},
        {"triangle", {{"a","b"}, {"b","c"}, {"c","a"}}}
    };

    for (const auto& [name, edges] : graphs) {
        std::cout << name << " degree sequence: ";
        print_sequence(degree_sequence(edges));
    }

    return 0;
}
