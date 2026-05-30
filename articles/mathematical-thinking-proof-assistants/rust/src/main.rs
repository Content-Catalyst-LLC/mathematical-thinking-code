use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/formalization_projects.csv");

    println!("Proof-assistant formalization metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut system_counts: HashMap<String, usize> = HashMap::new();
            let mut domain_counts: HashMap<String, usize> = HashMap::new();
            let mut count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 4 {
                    count += 1;
                    *system_counts.entry(cells[2].to_string()).or_insert(0) += 1;
                    *domain_counts.entry(cells[4].to_string()).or_insert(0) += 1;
                }
            }

            println!("\nproject_count={}", count);
            println!("system counts:");
            let mut systems: Vec<_> = system_counts.iter().collect();
            systems.sort_by_key(|item| item.0.clone());
            for (system, total) in systems {
                println!("{}: {}", system, total);
            }

            println!("\ndomain counts:");
            let mut domains: Vec<_> = domain_counts.iter().collect();
            domains.sort_by_key(|item| item.0.clone());
            for (domain, total) in domains {
                println!("{}: {}", domain, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: metadata counts support coverage review, not proof-assistant ranking.");
}
