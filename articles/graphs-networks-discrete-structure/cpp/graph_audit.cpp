#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <string>
#include <vector>

using Graph = std::map<std::string, std::set<std::string>>;

void add_edge(Graph& graph, const std::string& a, const std::string& b) {
    graph[a].insert(b);
    graph[b].insert(a);
}

std::set<std::string> component(const Graph& graph, const std::string& start) {
    std::set<std::string> visited;
    std::queue<std::string> queue;
    queue.push(start);

    while (!queue.empty()) {
        std::string node = queue.front();
        queue.pop();

        if (visited.count(node)) {
            continue;
        }
        visited.insert(node);

        auto it = graph.find(node);
        if (it != graph.end()) {
            for (const auto& neighbor : it->second) {
                if (!visited.count(neighbor)) {
                    queue.push(neighbor);
                }
            }
        }
    }

    return visited;
}

int main() {
    Graph graph;
    add_edge(graph, "A", "B");
    add_edge(graph, "A", "C");
    add_edge(graph, "B", "D");
    graph["E"];

    std::cout << "Graph audit\n";
    std::size_t degree_sum = 0;

    for (const auto& item : graph) {
        auto comp = component(graph, item.first);
        degree_sum += item.second.size();
        std::cout << item.first
                  << " degree=" << item.second.size()
                  << " component_size=" << comp.size()
                  << "\n";
    }

    std::cout << "degree_sum=" << degree_sum << "\n";
    std::cout << "twice_edge_count=" << 2 * 3 << "\n";
    std::cout << "handshaking_agrees=" << (degree_sum == 2 * 3) << "\n";

    return 0;
}
