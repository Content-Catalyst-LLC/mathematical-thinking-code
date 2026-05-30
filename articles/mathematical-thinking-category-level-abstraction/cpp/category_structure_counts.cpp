#include <iostream>
#include <map>
#include <string>
#include <vector>

struct CategoryRecord {
    std::string category;
    std::string morphism;
    std::string preserved_structure;
};

int main() {
    std::vector<CategoryRecord> records = {
        {"Set", "functions", "element assignment"},
        {"Grp", "group homomorphisms", "group operation"},
        {"Top", "continuous maps", "topological continuity"},
        {"Vect", "linear maps", "linear structure"},
        {"Poset", "monotone maps", "order relation"},
        {"Type", "typed functions", "computational typing"}
    };

    std::map<std::string, int> morphism_counts;
    std::map<std::string, int> structure_counts;

    for (const auto& item : records) {
        morphism_counts[item.morphism]++;
        structure_counts[item.preserved_structure]++;
    }

    std::cout << "summary_type,name,count,interpretation\n";
    for (const auto& item : morphism_counts) {
        std::cout << "morphism," << item.first << "," << item.second
                  << ",chosen morphisms determine visible structure\n";
    }
    for (const auto& item : structure_counts) {
        std::cout << "preserved_structure," << item.first << "," << item.second
                  << ",preserved structure defines categorical attention\n";
    }

    return 0;
}
