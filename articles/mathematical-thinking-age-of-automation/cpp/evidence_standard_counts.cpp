#include <iostream>
#include <map>
#include <string>
#include <vector>

struct VerificationRecord {
    std::string task;
    std::string evidence_standard;
};

int main() {
    std::vector<VerificationRecord> records = {
        {"calculation", "arithmetic correctness plus dimensional sense"},
        {"symbolic simplification", "algebraic validity under stated domain"},
        {"simulation", "model-based numerical adequacy"},
        {"AI explanation", "valid inference or formal derivation"},
        {"formal proof", "machine-checked derivation"}
    };

    std::map<std::string, int> counts;
    for (const auto& record : records) {
        counts[record.evidence_standard]++;
    }

    std::cout << "evidence_standard,count,interpretation\n";
    for (const auto& item : counts) {
        std::cout << item.first << "," << item.second
                  << ",different automated outputs require different evidence standards\n";
    }

    return 0;
}
