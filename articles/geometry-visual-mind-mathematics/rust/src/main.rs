use std::env;
use std::fs;

#[derive(Debug, Clone, Copy)]
struct Point {
    x: f64,
    y: f64,
}

fn distance(a: Point, b: Point) -> f64 {
    ((b.x - a.x).powi(2) + (b.y - a.y).powi(2)).sqrt()
}

fn orientation(a: Point, b: Point, c: Point) -> f64 {
    (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
}

fn area(a: Point, b: Point, c: Point) -> f64 {
    orientation(a, b, c).abs() / 2.0
}

fn rotate90(p: Point) -> Point {
    Point { x: -p.y, y: p.x }
}

fn squared_norm(p: Point) -> f64 {
    p.x * p.x + p.y * p.y
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/geometric_objects.csv");

    let a = Point { x: 0.0, y: 0.0 };
    let b = Point { x: 4.0, y: 0.0 };
    let c = Point { x: 0.0, y: 3.0 };

    println!("Geometry audit");
    println!("AB distance: {}", distance(a, b));
    println!("BC distance: {}", distance(b, c));
    println!("CA distance: {}", distance(c, a));
    println!("triangle area: {}", area(a, b, c));
    println!("orientation: {}", orientation(a, b, c));

    let rotated_b = rotate90(b);
    println!("rotated B: {:?}", rotated_b);
    println!("distance from origin preserved by rotate90: {}", (squared_norm(b) - squared_norm(rotated_b)).abs() < 1e-10);

    println!("\nGeometric object metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(6) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
