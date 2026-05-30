#include <iostream>
#include <map>
#include <string>
#include <vector>

struct Milestone {
    std::string period;
    std::string tradition;
    std::string mode;
};

int main() {
    std::vector<Milestone> milestones = {
        {"Antiquity", "Mesopotamian", "Procedural"},
        {"Antiquity", "Egyptian", "Procedural"},
        {"Classical", "Greek", "Deductive"},
        {"Classical", "Greek", "Analytic"},
        {"Classical-medieval", "Indian", "Algebraic"},
        {"Classical-medieval", "Chinese", "Procedural"},
        {"Medieval", "Islamic", "Algebraic"},
        {"Early modern", "European", "Analytic"},
        {"Nineteenth", "European", "Structural"},
        {"Twentieth", "International", "Computational"},
        {"Contemporary", "International", "FormalVerified"}
    };

    std::map<std::string, int> counts;
    for (const auto& item : milestones) {
        counts[item.mode]++;
    }

    std::cout << "thinking_mode,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",synthetic count supports coverage audit not ranking\n";
    }

    return 0;
}
