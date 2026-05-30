#include <iostream>
#include <map>
#include <string>
#include <vector>

struct Connection {
    std::string source;
    std::string target;
    std::string type;
};

int main() {
    std::vector<Connection> connections = {
        {"proportion", "slope", "generalization"},
        {"curve", "equation", "representation"},
        {"derivative", "optimization", "method migration"},
        {"group", "symmetry", "structural identification"},
        {"graph", "network model", "model interpretation"},
        {"proof", "formal verification", "medium transformation"}
    };

    std::map<std::string, int> counts;
    for (const auto& item : connections) {
        counts[item.type]++;
    }

    std::cout << "connection_type,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",cross-field connections support concept mapping not contextual sameness\n";
    }

    return 0;
}
