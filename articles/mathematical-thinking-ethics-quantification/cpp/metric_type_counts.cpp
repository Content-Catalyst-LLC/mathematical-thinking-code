#include <iostream>
#include <map>
#include <string>
#include <vector>

struct MetricRecord {
    std::string metric_type;
    std::string consequence_level;
};

int main() {
    std::vector<MetricRecord> records = {
        {"proxy", "high_stakes"},
        {"indicator", "moderate_stakes"},
        {"benchmark", "high_stakes"},
        {"score", "high_stakes"},
        {"risk_score", "high_stakes"},
        {"ranking", "moderate_stakes"},
        {"indicator", "high_stakes"}
    };

    std::map<std::string, int> type_counts;
    std::map<std::string, int> consequence_counts;

    for (const auto& item : records) {
        type_counts[item.metric_type]++;
        consequence_counts[item.consequence_level]++;
    }

    std::cout << "summary_type,name,count,interpretation\n";
    for (const auto& item : type_counts) {
        std::cout << "metric_type," << item.first << "," << item.second
                  << ",metric type clarifies how the number should be interpreted\n";
    }
    for (const auto& item : consequence_counts) {
        std::cout << "consequence_level," << item.first << "," << item.second
                  << ",consequence level determines governance and contestability requirements\n";
    }

    return 0;
}
