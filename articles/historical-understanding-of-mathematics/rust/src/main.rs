use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/historical_practices.csv");

    println!("Historical understanding of mathematics metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut method_counts: HashMap<String, usize> = HashMap::new();
            let mut count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 4 {
                    count += 1;
                    *method_counts.entry(cells[4].to_string()).or_insert(0) += 1;
                }
            }

            println!("\npractice_count={}", count);
            println!("method counts:");
            let mut methods: Vec<_> = method_counts.iter().collect();
            methods.sort_by_key(|item| item.0.clone());
            for (method, total) in methods {
                println!("{}: {}", method, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: metadata counts support coverage review, not historical ranking.");
}
