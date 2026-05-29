#include <iostream>
#include <map>
#include <set>
#include <string>
#include <utility>
#include <vector>

using Relation = std::set<std::pair<int, int>>;

bool is_reflexive(const std::vector<int>& domain, const Relation& relation) {
    for (int x : domain) {
        if (!relation.count({x, x})) return false;
    }
    return true;
}

bool is_symmetric(const Relation& relation) {
    for (auto [x, y] : relation) {
        if (!relation.count({y, x})) return false;
    }
    return true;
}

bool is_transitive(const Relation& relation) {
    for (auto [x, y] : relation) {
        for (auto [y2, z] : relation) {
            if (y == y2 && !relation.count({x, z})) return false;
        }
    }
    return true;
}

std::pair<bool, std::string> validate_function(
    const std::vector<int>& domain,
    const std::set<int>& codomain,
    const std::vector<std::pair<int, int>>& pairs
) {
    std::map<int, std::vector<int>> outputs;

    for (auto [x, y] : pairs) {
        outputs[x].push_back(y);
        if (!codomain.count(y)) {
            return {false, "output outside codomain"};
        }
    }

    for (int x : domain) {
        if (!outputs.count(x)) return {false, "domain input has no output"};
        if (outputs[x].size() != 1) return {false, "domain input has multiple outputs"};
    }

    return {true, "valid total function"};
}

int main() {
    std::vector<int> domain{1, 2, 3, 4};
    Relation mod2;

    for (int x : domain) {
        for (int y : domain) {
            if (x % 2 == y % 2) {
                mod2.insert({x, y});
            }
        }
    }

    std::cout << "Relation property audit\n";
    std::cout << "mod2 reflexive=" << is_reflexive(domain, mod2) << "\n";
    std::cout << "mod2 symmetric=" << is_symmetric(mod2) << "\n";
    std::cout << "mod2 transitive=" << is_transitive(mod2) << "\n";

    auto good = validate_function(domain, {2,4,6,8}, {{1,2},{2,4},{3,6},{4,8}});
    auto bad = validate_function(domain, {1,2,3,4,6,12}, {{1,1},{2,4},{3,9},{4,16}});

    std::cout << "double valid=" << good.first << " message=" << good.second << "\n";
    std::cout << "restricted square valid=" << bad.first << " message=" << bad.second << "\n";

    return 0;
}
