#include <iostream>
#include <memory>
#include <string>

struct Expr {
    std::string op;
    std::string value;
    std::shared_ptr<Expr> left;
    std::shared_ptr<Expr> right;

    Expr(std::string op_, std::string value_ = "") : op(std::move(op_)), value(std::move(value_)) {}
};

std::shared_ptr<Expr> var(const std::string& name) {
    return std::make_shared<Expr>("var", name);
}

std::shared_ptr<Expr> constant(const std::string& value) {
    return std::make_shared<Expr>("const", value);
}

std::shared_ptr<Expr> node(const std::string& op, std::shared_ptr<Expr> left, std::shared_ptr<Expr> right) {
    auto expr = std::make_shared<Expr>(op);
    expr->left = left;
    expr->right = right;
    return expr;
}

std::string pretty(const std::shared_ptr<Expr>& expr) {
    if (expr->op == "var" || expr->op == "const") {
        return expr->value;
    }
    if (expr->op == "pow") {
        return "(" + pretty(expr->left) + ")^" + pretty(expr->right);
    }
    return "(" + pretty(expr->left) + " " + expr->op + " " + pretty(expr->right) + ")";
}

int node_count(const std::shared_ptr<Expr>& expr) {
    if (!expr) return 0;
    return 1 + node_count(expr->left) + node_count(expr->right);
}

int main() {
    auto expanded = node("+",
        node("+",
            node("pow", var("x"), constant("2")),
            node("*", constant("2"), var("x"))
        ),
        constant("1")
    );

    auto factored = node("pow", node("+", var("x"), constant("1")), constant("2"));

    std::cout << "expression_id,pretty_expression,node_count,interpretation\n";
    std::cout << "expanded,\"" << pretty(expanded) << "\"," << node_count(expanded)
              << ",symbolic notation can be represented as an expression tree\n";
    std::cout << "factored,\"" << pretty(factored) << "\"," << node_count(factored)
              << ",factoring transforms expression-tree structure\n";

    return 0;
}
