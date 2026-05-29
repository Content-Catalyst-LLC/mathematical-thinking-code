use std::env;
use std::fs;

fn is_even(n: i64) -> bool {
    n % 2 == 0
}

fn even_square_claim(n: i64) -> bool {
    !is_even(n) || is_even(n * n)
}

fn sum_first_n(n: i64) -> i64 {
    (1..=n).sum()
}

fn sum_formula(n: i64) -> i64 {
    n * (n + 1) / 2
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/conjectures.csv");

    println!("Finite evidence audit");
    let even_counterexamples: Vec<i64> = (-100..=100).filter(|n| !even_square_claim(*n)).collect();
    println!("Even-square counterexamples in tested range: {:?}", even_counterexamples);

    let sum_failures: Vec<i64> = (1..=100).filter(|n| sum_first_n(*n) != sum_formula(*n)).collect();
    println!("Sum-formula failures in tested range: {:?}", sum_failures);

    println!("\nConjecture metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(6) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: finite evidence supports conjecture but does not replace proof.");
}
