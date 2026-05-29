use std::env;
use std::fs;

#[derive(Debug, Clone)]
enum Expr {
    Var(String),
    Const(f64),
    Add(Box<Expr>, Box<Expr>),
    Mul(Box<Expr>, Box<Expr>),
}

fn render(expr: &Expr) -> String {
    match expr {
        Expr::Var(name) => name.clone(),
        Expr::Const(value) => value.to_string(),
        Expr::Add(left, right) => format!("({} + {})", render(left), render(right)),
        Expr::Mul(left, right) => format!("({} * {})", render(left), render(right)),
    }
}

fn eval(expr: &Expr, x: f64, y: f64) -> f64 {
    match expr {
        Expr::Var(name) if name == "x" => x,
        Expr::Var(name) if name == "y" => y,
        Expr::Var(name) => panic!("unbound variable: {}", name),
        Expr::Const(value) => *value,
        Expr::Add(left, right) => eval(left, x, y) + eval(right, x, y),
        Expr::Mul(left, right) => eval(left, x, y) * eval(right, x, y),
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/expressions.csv");

    let expr = Expr::Mul(
        Box::new(Expr::Add(Box::new(Expr::Var("x".to_string())), Box::new(Expr::Const(2.0)))),
        Box::new(Expr::Var("y".to_string())),
    );

    println!("Symbolic expression demo");
    println!("rendered: {}", render(&expr));
    println!("evaluated at x=3, y=4: {}", eval(&expr, 3.0, 4.0));

    println!("\nExpression metadata file:");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(6) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: expression trees preserve symbolic structure for rendering and evaluation.");
}
