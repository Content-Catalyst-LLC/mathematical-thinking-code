use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/discovery_candidates.csv");

    println!("AI-assisted mathematical discovery metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut type_counts: HashMap<String, usize> = HashMap::new();
            let mut status_counts: HashMap<String, usize> = HashMap::new();
            let mut count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 5 {
                    count += 1;
                    *type_counts.entry(cells[2].to_string()).or_insert(0) += 1;
                    *status_counts.entry(cells[5].to_string()).or_insert(0) += 1;
                }
            }

            println!("\ncandidate_count={}", count);
            println!("candidate type counts:");
            let mut types: Vec<_> = type_counts.iter().collect();
            types.sort_by_key(|item| item.0.clone());
            for (kind, total) in types {
                println!("{}: {}", kind, total);
            }

            println!("\nstatus counts:");
            let mut statuses: Vec<_> = status_counts.iter().collect();
            statuses.sort_by_key(|item| item.0.clone());
            for (status, total) in statuses {
                println!("{}: {}", status, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: generated candidates require evidence classification before mathematical promotion.");
}
