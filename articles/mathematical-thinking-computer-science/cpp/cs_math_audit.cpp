#include <algorithm>
#include <iostream>
#include <queue>
#include <map>
#include <set>
#include <string>
#include <vector>

std::vector<int> insertion_sort(std::vector<int> values) {
    for (std::size_t i = 1; i < values.size(); ++i) {
        int key = values[i];
        std::size_t j = i;
        while (j > 0 && values[j - 1] > key) {
            values[j] = values[j - 1];
            --j;
        }
        values[j] = key;
    }
    return values;
}

bool is_sorted_vector(const std::vector<int>& values) {
    return std::is_sorted(values.begin(), values.end());
}

using Graph = std::map<std::string, std::set<std::string>>;

void add_edge(Graph& graph, const std::string& a, const std::string& b) {
    graph[a].insert(b);
    graph[b].insert(a);
}

std::set<std::string> reachable(const Graph& graph, const std::string& start) {
    std::set<std::string> visited;
    std::queue<std::string> queue;
    queue.push(start);

    while (!queue.empty()) {
        auto node = queue.front();
        queue.pop();
        if (visited.count(node)) continue;
        visited.insert(node);

        auto it = graph.find(node);
        if (it != graph.end()) {
            for (const auto& neighbor : it->second) {
                if (!visited.count(neighbor)) queue.push(neighbor);
            }
        }
    }

    return visited;
}

int main() {
    std::vector<int> values{5, 2, 8, 1, 3};
    auto sorted = insertion_sort(values);

    std::cout << "Sorting audit\n";
    std::cout << "is_sorted=" << is_sorted_vector(sorted) << "\n";

    Graph graph;
    add_edge(graph, "A", "B");
    add_edge(graph, "A", "C");
    add_edge(graph, "B", "D");

    std::cout << "\nGraph reachability from A\n";
    for (const auto& node : reachable(graph, "A")) {
        std::cout << node << "\n";
    }

    std::cout << "\nComplexity growth preview\n";
    for (int n = 1; n <= 12; ++n) {
        std::cout << "n=" << n << " n2=" << n*n << "\n";
    }

    return 0;
}
