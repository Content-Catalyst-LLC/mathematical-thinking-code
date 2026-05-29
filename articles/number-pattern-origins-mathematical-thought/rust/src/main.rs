use std::env;
use std::fs;

fn differences(values: &[i64]) -> Vec<i64> {
    values.windows(2).map(|pair| pair[1] - pair[0]).collect()
}

fn is_arithmetic(values: &[i64]) -> bool {
    let d = differences(values);
    !d.is_empty() && d.iter().all(|x| *x == d[0])
}

fn is_quadratic_by_differences(values: &[i64]) -> bool {
    let d2 = differences(&differences(values));
    !d2.is_empty() && d2.iter().all(|x| *x == d2[0])
}

fn triangular(n: i64) -> i64 {
    n * (n + 1) / 2
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/sequences.csv");

    let examples: Vec<(&str, Vec<i64>)> = vec![
        ("even", vec![2, 4, 6, 8, 10, 12]),
        ("triangular", vec![1, 3, 6, 10, 15, 21]),
        ("squares", vec![1, 4, 9, 16, 25, 36]),
    ];

    println!("Sequence finite-difference audit");
    for (name, values) in examples {
        println!(
            "{} values={:?} d1={:?} d2={:?} arithmetic={} quadratic={}",
            name,
            values,
            differences(&values),
            differences(&differences(&values)),
            is_arithmetic(&values),
            is_quadratic_by_differences(&values)
        );
    }

    println!("\nTriangular number audit");
    for n in 1..=10 {
        let computed: i64 = (1..=n).sum();
        let formula = triangular(n);
        println!("n={} computed={} formula={} agrees={}", n, computed, formula, computed == formula);
    }

    println!("\nSequence metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(6) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
