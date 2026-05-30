use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/category_records.csv");

    println!("Category-level abstraction metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut structure_counts: HashMap<String, usize> = HashMap::new();
            let mut morphism_counts: HashMap<String, usize> = HashMap::new();
            let mut count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 4 {
                    count += 1;
                    *morphism_counts.entry(cells[3].to_string()).or_insert(0) += 1;
                    *structure_counts.entry(cells[4].to_string()).or_insert(0) += 1;
                }
            }

            println!("\ncategory_count={}", count);
            println!("morphism counts:");
            let mut morphisms: Vec<_> = morphism_counts.iter().collect();
            morphisms.sort_by_key(|item| item.0.clone());
            for (morphism, total) in morphisms {
                println!("{}: {}", morphism, total);
            }

            println!("\npreserved structure counts:");
            let mut structures: Vec<_> = structure_counts.iter().collect();
            structures.sort_by_key(|item| item.0.clone());
            for (structure, total) in structures {
                println!("{}: {}", structure, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: category metadata supports review of objects, arrows, and preserved structure.");
}
