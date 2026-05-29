#include <algorithm>
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

std::set<std::string> connected_component(const Graph& graph, const std::string& start) {
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

unsigned long long fibonacci(unsigned int n) {
    if (n == 0) return 0;
    unsigned long long previous = 0;
    unsigned long long current = 1;

    for (unsigned int i = 2; i <= n; ++i) {
        unsigned long long next = previous + current;
        previous = current;
        current = next;
    }

    return current;
}

unsigned long long binomial(unsigned int n, unsigned int k) {
    if (k > n) return 0;
    k = std::min(k, n - k);
    unsigned long long result = 1;

    for (unsigned int i = 1; i <= k; ++i) {
        result = result * (n - k + i) / i;
    }

    return result;
}

int main() {
    Graph graph;
    add_edge(graph, "A", "B");
    add_edge(graph, "A", "C");
    add_edge(graph, "B", "D");
    graph["E"];

    std::cout << "Graph audit\n";
    for (const auto& item : graph) {
        auto component = connected_component(graph, item.first);
        std::cout << item.first << " degree=" << item.second.size()
                  << " component_size=" << component.size() << "\n";
    }

    std::cout << "\nRecurrence and counting audit\n";
    for (unsigned int n = 0; n <= 10; ++n) {
        std::cout << "n=" << n
                  << " fib=" << fibonacci(n)
                  << " mod7=" << (n % 7)
                  << " C(10,n)=" << binomial(10, n) << "\n";
    }

    return 0;
}
