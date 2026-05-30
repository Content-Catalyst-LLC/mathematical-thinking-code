use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/scientific_model_records.csv");

    println!("Scientific modeling metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut type_counts: HashMap<String, usize> = HashMap::new();
            let mut purpose_counts: HashMap<String, usize> = HashMap::new();
            let mut count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 3 {
                    count += 1;
                    *type_counts.entry(cells[2].to_string()).or_insert(0) += 1;
                    *purpose_counts.entry(cells[3].to_string()).or_insert(0) += 1;
                }
            }

            println!("\nmodel_count={}", count);
            println!("model type counts:");
            let mut model_types: Vec<_> = type_counts.iter().collect();
            model_types.sort_by_key(|item| item.0.clone());
            for (model_type, total) in model_types {
                println!("{}: {}", model_type, total);
            }

            println!("\npurpose counts:");
            let mut purposes: Vec<_> = purpose_counts.iter().collect();
            purposes.sort_by_key(|item| item.0.clone());
            for (purpose, total) in purposes {
                println!("{}: {}", purpose, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: scientific model metadata supports review of type, purpose, scope, and validation needs.");
}
