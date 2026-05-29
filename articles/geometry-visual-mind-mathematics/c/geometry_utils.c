#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

typedef struct {
    double x;
    double y;
} Point;

double distance(Point a, Point b) {
    return sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y));
}

double orientation(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

double triangle_area(Point a, Point b, Point c) {
    return fabs(orientation(a, b, c)) / 2.0;
}

Point rotate90(Point p) {
    Point result = {-p.y, p.x};
    return result;
}

double squared_norm(Point p) {
    return p.x * p.x + p.y * p.y;
}

int main(void) {
    Point a = {0.0, 0.0};
    Point b = {4.0, 0.0};
    Point c = {0.0, 3.0};
    Point rb = rotate90(b);

    printf("measurement,value\n");
    printf("AB_distance,%.12f\n", distance(a, b));
    printf("BC_distance,%.12f\n", distance(b, c));
    printf("CA_distance,%.12f\n", distance(c, a));
    printf("orientation,%.12f\n", orientation(a, b, c));
    printf("triangle_area,%.12f\n", triangle_area(a, b, c));
    printf("rotate90_B_x,%.12f\n", rb.x);
    printf("rotate90_B_y,%.12f\n", rb.y);
    printf("rotation_preserves_squared_norm,%d\n", fabs(squared_norm(b) - squared_norm(rb)) < 1e-10);

    return EXIT_SUCCESS;
}
