#include <iostream>
#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

struct Tree {
    std::string label;
    std::vector<std::shared_ptr<Tree>> children;
};

unsigned long long factorial(unsigned int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1);
}

unsigned long long fibonacci_memo(unsigned int n, std::unordered_map<unsigned int, unsigned long long>& memo) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    auto it = memo.find(n);
    if (it != memo.end()) return it->second;

    unsigned long long value = fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo);
    memo[n] = value;
    return value;
}

std::size_t tree_size(const std::shared_ptr<Tree>& tree) {
    std::size_t result = 1;
    for (const auto& child : tree->children) {
        result += tree_size(child);
    }
    return result;
}

std::size_t tree_depth(const std::shared_ptr<Tree>& tree) {
    std::size_t max_child = 0;
    for (const auto& child : tree->children) {
        max_child = std::max(max_child, tree_depth(child));
    }
    return 1 + max_child;
}

int main() {
    auto proof_tree = std::make_shared<Tree>(Tree{
        "theorem",
        {
            std::make_shared<Tree>(Tree{"lemma", {std::make_shared<Tree>(Tree{"definition", {}}), std::make_shared<Tree>(Tree{"case", {}})}}),
            std::make_shared<Tree>(Tree{"corollary", {}})
        }
    });

    std::cout << "Recurrence audit\n";
    for (unsigned int n = 0; n <= 12; ++n) {
        std::unordered_map<unsigned int, unsigned long long> memo;
        std::cout << "n=" << n
                  << " factorial=" << factorial(n)
                  << " fibonacci=" << fibonacci_memo(n, memo)
                  << "\n";
    }

    std::cout << "\nTree audit\n";
    std::cout << "tree_size=" << tree_size(proof_tree) << "\n";
    std::cout << "tree_depth=" << tree_depth(proof_tree) << "\n";

    return 0;
}
