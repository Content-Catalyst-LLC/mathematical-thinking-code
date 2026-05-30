use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/visual_proof_records.csv");

    println!("Visual proof metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut role_counts: HashMap<String, usize> = HashMap::new();
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
                    *role_counts.entry(cells[3].to_string()).or_insert(0) += 1;
                    *status_counts.entry(cells[5].to_string()).or_insert(0) += 1;
                }
            }

            println!("\nrecord_count={}", count);
            println!("visual role counts:");
            let mut roles: Vec<_> = role_counts.iter().collect();
            roles.sort_by_key(|item| item.0.clone());
            for (role, total) in roles {
                println!("{}: {}", role, total);
            }

            println!("\nproof status counts:");
            let mut statuses: Vec<_> = status_counts.iter().collect();
            statuses.sort_by_key(|item| item.0.clone());
            for (status, total) in statuses {
                println!("{}: {}", status, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: visual proof metadata supports role, status, and generality review.");
}
