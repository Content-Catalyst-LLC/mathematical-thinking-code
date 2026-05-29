use std::env;
use std::fs;

fn parse_terms(text: &str) -> Vec<i64> {
    text.split_whitespace()
        .filter_map(|part| part.parse::<i64>().ok())
        .collect()
}

fn differences(values: &[i64]) -> Vec<i64> {
    values.windows(2).map(|w| w[1] - w[0]).collect()
}

fn all_equal(values: &[i64]) -> bool {
    values
        .first()
        .map(|first| values.iter().all(|v| v == first))
        .unwrap_or(false)
}

fn classify(values: &[i64]) -> &'static str {
    if values.len() < 3 {
        return "insufficient finite evidence";
    }

    let d1 = differences(values);
    let d2 = differences(&d1);

    if all_equal(&d1) {
        "arithmetic"
    } else if !d2.is_empty() && all_equal(&d2) {
        "quadratic"
    } else {
        "undetermined finite pattern"
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = args
        .get(1)
        .map(String::as_str)
        .unwrap_or("../data/raw/sequence_patterns.csv");

    let text = fs::read_to_string(path).expect("Could not read sequence pattern CSV");

    println!("Sequence pattern classifier");
    for line in text.lines().skip(1) {
        let parts: Vec<&str> = line.split(',').collect();
        if parts.len() < 4 {
            continue;
        }

        let sequence_id = parts[0];
        let name = parts[1];
        let terms = parse_terms(parts[2].trim_matches('"'));
        let classification = classify(&terms);

        println!("{} ({}) -> {}", sequence_id, name, classification);
    }

    println!("Interpretation: finite pattern classification is heuristic unless supported by proof.");
}
