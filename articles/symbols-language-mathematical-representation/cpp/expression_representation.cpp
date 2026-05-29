#include <iostream>
#include <map>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>

struct Expr {
    virtual ~Expr() = default;
    virtual double eval(const std::map<std::string, double>& env) const = 0;
    virtual std::string render() const = 0;
};

struct Var : Expr {
    std::string name;
    explicit Var(std::string n) : name(std::move(n)) {}

    double eval(const std::map<std::string, double>& env) const override {
        auto it = env.find(name);
        if (it == env.end()) {
            throw std::runtime_error("unbound variable: " + name);
        }
        return it->second;
    }

    std::string render() const override {
        return name;
    }
};

struct Const : Expr {
    double value;
    explicit Const(double v) : value(v) {}

    double eval(const std::map<std::string, double>&) const override {
        return value;
    }

    std::string render() const override {
        return std::to_string(value);
    }
};

struct Add : Expr {
    std::unique_ptr<Expr> left;
    std::unique_ptr<Expr> right;

    Add(std::unique_ptr<Expr> l, std::unique_ptr<Expr> r) : left(std::move(l)), right(std::move(r)) {}

    double eval(const std::map<std::string, double>& env) const override {
        return left->eval(env) + right->eval(env);
    }

    std::string render() const override {
        return "(" + left->render() + " + " + right->render() + ")";
    }
};

struct Mul : Expr {
    std::unique_ptr<Expr> left;
    std::unique_ptr<Expr> right;

    Mul(std::unique_ptr<Expr> l, std::unique_ptr<Expr> r) : left(std::move(l)), right(std::move(r)) {}

    double eval(const std::map<std::string, double>& env) const override {
        return left->eval(env) * right->eval(env);
    }

    std::string render() const override {
        return "(" + left->render() + " * " + right->render() + ")";
    }
};

int main() {
    auto expr = std::make_unique<Mul>(
        std::make_unique<Add>(
            std::make_unique<Var>("x"),
            std::make_unique<Const>(2.0)
        ),
        std::make_unique<Var>("y")
    );

    std::map<std::string, double> env{{"x", 3.0}, {"y", 4.0}};

    std::cout << "Rendered expression: " << expr->render() << "\n";
    std::cout << "Evaluated value: " << expr->eval(env) << "\n";
    std::cout << "Interpretation: expression trees preserve symbolic structure for computation.\n";

    return 0;
}
