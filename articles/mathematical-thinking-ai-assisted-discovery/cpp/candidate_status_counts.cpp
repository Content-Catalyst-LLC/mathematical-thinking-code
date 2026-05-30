#include <iostream>
#include <map>
#include <string>
#include <vector>

struct Candidate {
    std::string output_type;
    std::string status;
};

int main() {
    std::vector<Candidate> candidates = {
        {"conjecture", "tested_on_examples"},
        {"program", "tested_on_examples"},
        {"proof_sketch", "untested"},
        {"formal_statement", "untested"},
        {"example", "tested_on_examples"},
        {"formal_proof_script", "machine_check_required"}
    };

    std::map<std::string, int> type_counts;
    std::map<std::string, int> status_counts;

    for (const auto& item : candidates) {
        type_counts[item.output_type]++;
        status_counts[item.status]++;
    }

    std::cout << "summary_type,name,count,interpretation\n";
    for (const auto& item : type_counts) {
        std::cout << "output_type," << item.first << "," << item.second
                  << ",different output types require different evidence standards\n";
    }
    for (const auto& item : status_counts) {
        std::cout << "status," << item.first << "," << item.second
                  << ",candidate status should be stated before mathematical promotion\n";
    }

    return 0;
}
