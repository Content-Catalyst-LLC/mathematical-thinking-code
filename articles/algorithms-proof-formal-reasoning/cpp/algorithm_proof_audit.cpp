#include <algorithm>
#include <iostream>
#include <map>
#include <queue>
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

bool same_multiset(std::vector<int> left, std::vector<int> right) {
    std::sort(left.begin(), left.end());
    std::sort(right.begin(), right.end());
    return left == right;
}

using Graph = std::map<std::string, std::set<std::string>>;

void add_edge(Graph& graph, const std::string& a, const std::string& b) {
    graph[a].insert(b);
    graph[b].insert(a);
}

std::map<std::string, int> bfs_distances(const Graph& graph, const std::string& start) {
    std::map<std::string, int> distances;
    std::queue<std::string> queue;
    distances[start] = 0;
    queue.push(start);

    while (!queue.empty()) {
        std::string node = queue.front();
        queue.pop();

        auto it = graph.find(node);
        if (it == graph.end()) {
            continue;
        }

        for (const auto& neighbor : it->second) {
            if (!distances.count(neighbor)) {
                distances[neighbor] = distances[node] + 1;
                queue.push(neighbor);
            }
        }
    }

    return distances;
}

int main() {
    std::vector<int> input{5, 2, 8, 1, 3, 2};
    auto output = insertion_sort(input);

    std::cout << "Sorting postcondition audit\n";
    std::cout << "is_sorted=" << std::is_sorted(output.begin(), output.end()) << "\n";
    std::cout << "same_multiset=" << same_multiset(input, output) << "\n";

    Graph graph;
    add_edge(graph, "A", "B");
    add_edge(graph, "A", "C");
    add_edge(graph, "B", "D");
    add_edge(graph, "D", "E");

    std::cout << "\nBFS distance audit\n";
    for (const auto& item : bfs_distances(graph, "A")) {
        std::cout << item.first << " distance=" << item.second << "\n";
    }

    return 0;
}
