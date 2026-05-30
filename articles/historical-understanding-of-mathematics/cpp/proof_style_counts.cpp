#include <iostream>
#include <map>
#include <string>
#include <vector>

struct ProofStyle {
    std::string name;
    std::string authority_basis;
};

int main() {
    std::vector<ProofStyle> styles = {
        {"diagrammatic demonstration", "construction and relation"},
        {"procedural verification", "repeatable method"},
        {"algebraic transformation", "equivalence preservation"},
        {"induction", "base case and general step"},
        {"limit proof", "quantified control"},
        {"formal derivation", "machine-checkable rules"}
    };

    std::map<std::string, int> counts;
    for (const auto& style : styles) {
        counts[style.authority_basis]++;
    }

    std::cout << "authority_basis,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",proof authority should be interpreted in historical context\n";
    }

    return 0;
}
