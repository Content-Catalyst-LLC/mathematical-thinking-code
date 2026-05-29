#include <cmath>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>

struct Expr {
    virtual ~Expr() = default;
    virtual double eval(double x) const = 0;
    virtual std::string render() const = 0;
};

struct Var : Expr {
    double eval(double x) const override {
        return x;
    }

    std::string render() const override {
        return "x";
    }
};

struct Const : Expr {
    double value;
    explicit Const(double v) : value(v) {}

    double eval(double) const override {
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

    double eval(double x) const override {
        return left->eval(x) + right->eval(x);
    }

    std::string render() const override {
        return "(" + left->render() + " + " + right->render() + ")";
    }
};

struct Mul : Expr {
    std::unique_ptr<Expr> left;
    std::unique_ptr<Expr> right;

    Mul(std::unique_ptr<Expr> l, std::unique_ptr<Expr> r) : left(std::move(l)), right(std::move(r)) {}

    double eval(double x) const override {
        return left->eval(x) * right->eval(x);
    }

    std::string render() const override {
        return "(" + left->render() + " * " + right->render() + ")";
    }
};

double residual_linear(double x) {
    return 3.0 * x + 2.0 - 17.0;
}

int main() {
    auto factored = std::make_unique<Mul>(
        std::make_unique<Const>(2.0),
        std::make_unique<Add>(
            std::make_unique<Var>(),
            std::make_unique<Const>(3.0)
        )
    );

    auto expanded = std::make_unique<Add>(
        std::make_unique<Mul>(
            std::make_unique<Const>(2.0),
            std::make_unique<Var>()
        ),
        std::make_unique<Const>(6.0)
    );

    std::cout << "Factored: " << factored->render() << "\n";
    std::cout << "Expanded: " << expanded->render() << "\n";

    for (int x = -3; x <= 3; ++x) {
        double left = factored->eval(x);
        double right = expanded->eval(x);
        std::cout << "x=" << x << " left=" << left << " right=" << right << " agrees=" << (std::abs(left - right) < 1e-10) << "\n";
    }

    std::cout << "\nResidual checks for 3x+2=17\n";
    for (double candidate : {4.0, 5.0, 6.0}) {
        std::cout << "x=" << candidate << " residual=" << residual_linear(candidate) << "\n";
    }

    return 0;
}
