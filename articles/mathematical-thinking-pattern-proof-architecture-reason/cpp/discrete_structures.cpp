#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <stdexcept>
#include <string>
#include <vector>

using Graph = std::map<std::string, std::vector<std::string>>;

std::vector<long long> fibonacci(int n) {
    std::vector<long long> values;
    if (n <= 0) return values;
    values.push_back(0);
    if (n == 1) return values;
    values.push_back(1);
    for (int i = 2; i < n; ++i) {
        values.push_back(values[i - 1] + values[i - 2]);
    }
    return values;
}

std::vector<std::string> topological_sort(const Graph& graph) {
    std::map<std::string, int> indegree;
    for (const auto& [node, targets] : graph) {
        indegree[node] += 0;
        for (const auto& target : targets) {
            indegree[target] += 1;
        }
    }

    std::queue<std::string> q;
    for (const auto& [node, degree] : indegree) {
        if (degree == 0) q.push(node);
    }

    std::vector<std::string> order;
    while (!q.empty()) {
        auto node = q.front();
        q.pop();
        order.push_back(node);

        auto it = graph.find(node);
        if (it == graph.end()) continue;

        for (const auto& target : it->second) {
            indegree[target] -= 1;
            if (indegree[target] == 0) q.push(target);
        }
    }

    if (order.size() != indegree.size()) {
        throw std::runtime_error("Graph contains a cycle.");
    }

    return order;
}

int main() {
    auto values = fibonacci(20);
    std::cout << "Fibonacci prefix:\n";
    for (std::size_t i = 0; i < values.size(); ++i) {
        std::cout << i << ": " << values[i] << "\n";
    }

    Graph g{
        {"concept_sequence", {"concept_recurrence"}},
        {"concept_recurrence", {"thm_recurrence_matrix_form", "thm_even_fibonacci_index"}},
        {"concept_induction", {"thm_even_fibonacci_index"}},
        {"thm_induction_schema", {"thm_even_fibonacci_index"}}
    };

    std::cout << "\nTopological order:\n";
    for (const auto& node : topological_sort(g)) {
        std::cout << node << "\n";
    }

    return 0;
}
