#include <cmath>
#include <iostream>
#include <string>
#include <vector>

struct Point {
    double x;
    double y;
};

double distance(Point a, Point b) {
    return std::sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y));
}

double orientation(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

double triangle_area(Point a, Point b, Point c) {
    return std::abs(orientation(a, b, c)) / 2.0;
}

Point rotate90(Point p) {
    return Point{-p.y, p.x};
}

double squared_norm(Point p) {
    return p.x * p.x + p.y * p.y;
}

int main() {
    Point a{0.0, 0.0};
    Point b{4.0, 0.0};
    Point c{0.0, 3.0};

    std::cout << "Geometry primitives\n";
    std::cout << "AB=" << distance(a, b) << "\n";
    std::cout << "BC=" << distance(b, c) << "\n";
    std::cout << "CA=" << distance(c, a) << "\n";
    std::cout << "Area=" << triangle_area(a, b, c) << "\n";
    std::cout << "Orientation=" << orientation(a, b, c) << "\n";

    Point rb = rotate90(b);
    std::cout << "Rotate90(B)=(" << rb.x << "," << rb.y << ")\n";
    std::cout << "Squared norm preserved=" << (std::abs(squared_norm(b) - squared_norm(rb)) < 1e-10) << "\n";

    return 0;
}
