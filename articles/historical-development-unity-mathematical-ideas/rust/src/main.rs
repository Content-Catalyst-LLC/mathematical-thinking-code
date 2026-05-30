use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/mathematical_ideas.csv");

    println!("Historical development and unity of mathematical ideas audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut field_counts: HashMap<String, usize> = HashMap::new();
            let mut idea_count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 2 {
                    idea_count += 1;
                    *field_counts.entry(cells[2].to_string()).or_insert(0) += 1;
                }
            }

            println!("\nidea_count={}", idea_count);
            println!("idea counts by field:");
            let mut fields: Vec<_> = field_counts.iter().collect();
            fields.sort_by_key(|item| item.0.clone());
            for (field, count) in fields {
                println!("{}: {}", field, count);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: field counts support coverage review, not field importance ranking.");
}
