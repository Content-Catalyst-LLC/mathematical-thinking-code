#include <iostream>
#include <map>
#include <string>
#include <vector>

int main() {
    std::vector<std::pair<std::string, std::string>> edges = {
        {"Definition", "Lemma"},
        {"Lemma", "Theorem"},
        {"Base Case", "Induction Principle"},
        {"Inductive Step", "Induction Principle"},
        {"Induction Principle", "Theorem"}
    };

    std::map<std::string, int> degree;

    for (const auto& edge : edges) {
        degree[edge.first] += 1;
        degree[edge.second] += 1;
    }

    std::cout << "Undirected proof graph degree counts:\n";

    for (const auto& item : degree) {
        std::cout << item.first << ": " << item.second << "\n";
    }

    return 0;
}
