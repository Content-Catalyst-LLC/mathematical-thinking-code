use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/proof_milestones.csv");

    println!("Proof-history metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut counts: HashMap<String, usize> = HashMap::new();

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 4 {
                    *counts.entry(cells[4].to_string()).or_insert(0) += 1;
                }
            }

            println!("Milestone counts by style id:");
            let mut items: Vec<_> = counts.iter().collect();
            items.sort_by_key(|item| item.0.clone());
            for (style, count) in items {
                println!("{}: {}", style, count);
            }

            println!("\nPreview:");
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: classification supports analysis but should not rank traditions.");
}
