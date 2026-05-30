use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/metric_records.csv");

    println!("Quantification ethics metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut type_counts: HashMap<String, usize> = HashMap::new();
            let mut consequence_counts: HashMap<String, usize> = HashMap::new();
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
                    *consequence_counts.entry(cells[5].to_string()).or_insert(0) += 1;
                }
            }

            println!("\nmetric_count={}", count);
            println!("metric type counts:");
            let mut metric_types: Vec<_> = type_counts.iter().collect();
            metric_types.sort_by_key(|item| item.0.clone());
            for (metric_type, total) in metric_types {
                println!("{}: {}", metric_type, total);
            }

            println!("\nconsequence counts:");
            let mut consequences: Vec<_> = consequence_counts.iter().collect();
            consequences.sort_by_key(|item| item.0.clone());
            for (consequence, total) in consequences {
                println!("{}: {}", consequence, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: metric metadata supports review of type, target concept, consequence level, and invalid uses.");
}
