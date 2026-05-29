use std::env;
use std::fs;

#[derive(Debug, Clone)]
enum Expr {
    Var(String),
    Const(f64),
    Add(Box<Expr>, Box<Expr>),
    Mul(Box<Expr>, Box<Expr>),
}

fn eval(expr: &Expr, x: f64) -> f64 {
    match expr {
        Expr::Var(name) if name == "x" => x,
        Expr::Var(name) => panic!("unbound variable: {}", name),
        Expr::Const(value) => *value,
        Expr::Add(left, right) => eval(left, x) + eval(right, x),
        Expr::Mul(left, right) => eval(left, x) * eval(right, x),
    }
}

fn render(expr: &Expr) -> String {
    match expr {
        Expr::Var(name) => name.clone(),
        Expr::Const(value) => value.to_string(),
        Expr::Add(left, right) => format!("({} + {})", render(left), render(right)),
        Expr::Mul(left, right) => format!("({} * {})", render(left), render(right)),
    }
}

fn residual_linear(x: f64) -> f64 {
    3.0 * x + 2.0 - 17.0
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/expression_examples.csv");

    let x = Expr::Var("x".to_string());
    let factored = Expr::Mul(
        Box::new(Expr::Const(2.0)),
        Box::new(Expr::Add(Box::new(x.clone()), Box::new(Expr::Const(3.0)))),
    );
    let expanded = Expr::Add(
        Box::new(Expr::Mul(Box::new(Expr::Const(2.0)), Box::new(x))),
        Box::new(Expr::Const(6.0)),
    );

    println!("Expression equivalence audit");
    println!("left: {}", render(&factored));
    println!("right: {}", render(&expanded));
    for value in -3..=3 {
        let xf = value as f64;
        println!("x={} left={} right={} agrees={}", value, eval(&factored, xf), eval(&expanded, xf), eval(&factored, xf) == eval(&expanded, xf));
    }

    println!("\nEquation residual checks for 3x+2=17");
    for candidate in [4.0, 5.0, 6.0] {
        println!("x={} residual={}", candidate, residual_linear(candidate));
    }

    println!("\nExpression metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(6) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
