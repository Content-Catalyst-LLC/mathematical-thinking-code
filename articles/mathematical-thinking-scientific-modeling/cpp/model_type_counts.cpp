#include <iostream>
#include <map>
#include <string>
#include <vector>

struct ModelRecord {
    std::string model_type;
    std::string purpose;
};

int main() {
    std::vector<ModelRecord> records = {
        {"mechanistic", "understanding"},
        {"simulation", "decision_support"},
        {"hybrid", "scenario_analysis"},
        {"mechanistic_statistical", "prediction"},
        {"systems", "decision_support"},
        {"machine_learning_hybrid", "prediction"}
    };

    std::map<std::string, int> type_counts;
    std::map<std::string, int> purpose_counts;

    for (const auto& item : records) {
        type_counts[item.model_type]++;
        purpose_counts[item.purpose]++;
    }

    std::cout << "summary_type,name,count,interpretation\n";
    for (const auto& item : type_counts) {
        std::cout << "model_type," << item.first << "," << item.second
                  << ",model type clarifies what kind of scientific knowledge is represented\n";
    }
    for (const auto& item : purpose_counts) {
        std::cout << "purpose," << item.first << "," << item.second
                  << ",model purpose determines validation and interpretation standards\n";
    }

    return 0;
}
