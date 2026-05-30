#include <iostream>
#include <map>
#include <string>
#include <vector>

struct VisualRecord {
    std::string role;
    std::string status;
};

int main() {
    std::vector<VisualRecord> records = {
        {"diagrammatic_argument", "informally_justified"},
        {"diagrammatic_argument", "informally_justified"},
        {"heuristic", "needs_generalization"},
        {"evidence", "needs_generalization"},
        {"heuristic", "needs_formal_limit"},
        {"formal_diagrammatic_proof", "formally_expressible"}
    };

    std::map<std::string, int> role_counts;
    std::map<std::string, int> status_counts;

    for (const auto& item : records) {
        role_counts[item.role]++;
        status_counts[item.status]++;
    }

    std::cout << "summary_type,name,count,interpretation\n";
    for (const auto& item : role_counts) {
        std::cout << "visual_role," << item.first << "," << item.second
                  << ",visual role clarifies what kind of reasoning the diagram supports\n";
    }
    for (const auto& item : status_counts) {
        std::cout << "proof_status," << item.first << "," << item.second
                  << ",proof status clarifies what remains to be justified\n";
    }

    return 0;
}
