#include <iostream>
#include <map>
#include <queue>
#include <stdexcept>
#include <string>
#include <vector>

using Graph = std::map<std::string, std::vector<std::string>>;

std::vector<std::string> topological_sort(const Graph& graph) {
    std::map<std::string, int> indegree;

    for (const auto& [node, targets] : graph) {
        indegree[node] += 0;
        for (const auto& target : targets) {
            indegree[target] += 1;
        }
    }

    std::queue<std::string> queue;
    for (const auto& [node, degree] : indegree) {
        if (degree == 0) queue.push(node);
    }

    std::vector<std::string> order;

    while (!queue.empty()) {
        auto node = queue.front();
        queue.pop();
        order.push_back(node);

        auto it = graph.find(node);
        if (it == graph.end()) continue;

        for (const auto& target : it->second) {
            indegree[target] -= 1;
            if (indegree[target] == 0) queue.push(target);
        }
    }

    if (order.size() != indegree.size()) {
        throw std::runtime_error("proof dependency graph contains a cycle");
    }

    return order;
}

long long sum_first_n(int n) {
    return static_cast<long long>(n) * (n + 1) / 2;
}

int main() {
    Graph proof_graph{
        {"def_even", {"lemma_even_square"}},
        {"rule_induction", {"thm_sum_first_n"}},
        {"rule_modus_ponens", {"lemma_even_square", "thm_sum_first_n"}},
        {"lemma_even_square", {}},
        {"thm_sum_first_n", {}}
    };

    std::cout << "Proof dependency topological order:\n";
    for (const auto& node : topological_sort(proof_graph)) {
        std::cout << node << "\n";
    }

    std::cout << "\nFinite audit for sum formula:\n";
    for (int n = 1; n <= 10; ++n) {
        long long computed = 0;
        for (int k = 1; k <= n; ++k) computed += k;
        std::cout << n << ": computed=" << computed << " formula=" << sum_first_n(n)
                  << " agrees=" << (computed == sum_first_n(n)) << "\n";
    }

    std::cout << "Finite checks illustrate; induction proves generality.\n";
    return 0;
}
