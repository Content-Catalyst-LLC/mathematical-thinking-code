#include <iostream>
#include <map>
#include <queue>
#include <stdexcept>
#include <string>
#include <vector>

bool implies(bool p, bool q) {
    return (!p) || q;
}

using Graph = std::map<std::string, std::vector<std::string>>;

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
        throw std::runtime_error("derivation graph contains a cycle");
    }

    return order;
}

int main() {
    std::cout << "Truth table: implication and contrapositive\n";
    for (bool p : {false, true}) {
        for (bool q : {false, true}) {
            bool original = implies(p, q);
            bool contrapositive = implies(!q, !p);
            std::cout << "P=" << p
                      << " Q=" << q
                      << " P->Q=" << original
                      << " notQ->notP=" << contrapositive
                      << " equivalent=" << (original == contrapositive)
                      << "\n";
        }
    }

    Graph derivation{
        {"P->Q", {"Q"}},
        {"P", {"Q"}},
        {"rule_modus_ponens", {"Q"}},
        {"Q", {}}
    };

    std::cout << "\nSimple derivation order:\n";
    for (const auto& node : topological_sort(derivation)) {
        std::cout << node << "\n";
    }

    return 0;
}
