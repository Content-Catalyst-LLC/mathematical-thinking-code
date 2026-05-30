#include <iostream>
#include <map>
#include <string>
#include <vector>

struct Structure {
    std::string name;
    std::string preserved_by;
};

int main() {
    std::vector<Structure> structures = {
        {"Group", "homomorphism"},
        {"Vector space", "linear map"},
        {"Topological space", "continuous map"},
        {"Graph", "graph morphism"},
        {"Category", "functor"},
        {"Formal system", "formal translation"}
    };

    std::map<std::string, int> counts;
    for (const auto& item : structures) {
        counts[item.preserved_by]++;
    }

    std::cout << "preservation_map,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",preservation maps define structural comparison\n";
    }

    return 0;
}
