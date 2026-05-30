#include <iostream>
#include <map>
#include <string>
#include <vector>

struct Milestone {
    std::string id;
    std::string tradition;
    std::string style;
};

int main() {
    std::vector<Milestone> milestones = {
        {"ms_babylonian", "Mesopotamian", "Procedural"},
        {"ms_rhind", "Egyptian", "Procedural"},
        {"ms_euclid", "Greek", "Deductive"},
        {"ms_archimedes", "Greek", "Diagrammatic"},
        {"ms_liu_hui", "Chinese", "Procedural"},
        {"ms_al_khwarizmi", "Islamic", "Algebraic"},
        {"ms_cauchy_weierstrass", "Analysis", "Analytic"},
        {"ms_godel", "Foundations", "FormalLogical"},
        {"ms_proof_assistants", "Computer", "MachineChecked"}
    };

    std::map<std::string, int> counts;
    for (const auto& item : milestones) {
        counts[item.style]++;
    }

    std::cout << "proof_style,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",synthetic classification supports comparison not ranking\n";
    }

    return 0;
}
