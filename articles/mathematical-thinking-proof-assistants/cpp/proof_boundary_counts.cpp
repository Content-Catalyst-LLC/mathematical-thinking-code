#include <iostream>
#include <map>
#include <string>
#include <vector>

struct Boundary {
    std::string component;
    std::string question;
};

int main() {
    std::vector<Boundary> boundaries = {
        {"kernel or checker", "What core component validates the derivation?"},
        {"axioms and foundations", "Which axioms or logic principles are admitted?"},
        {"imported libraries", "Which definitions and prior theorems are imported?"},
        {"formal statement", "Does the checked statement match the intended informal claim?"},
        {"human interpretation", "What should not be inferred from the formal proof?"}
    };

    std::map<std::string, int> counts;
    for (const auto& item : boundaries) {
        counts[item.component]++;
    }

    std::cout << "trusted_component,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",trust is relocated into explicit proof-assistant boundaries\n";
    }

    return 0;
}
