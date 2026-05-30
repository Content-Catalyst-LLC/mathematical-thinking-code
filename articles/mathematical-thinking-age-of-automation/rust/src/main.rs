use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/automation_tasks.csv");

    println!("Mathematical automation task metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut tool_counts: HashMap<String, usize> = HashMap::new();
            let mut count = 0usize;

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 2 {
                    count += 1;
                    *tool_counts.entry(cells[2].to_string()).or_insert(0) += 1;
                }
            }

            println!("\ntask_count={}", count);
            println!("tool counts:");
            let mut tools: Vec<_> = tool_counts.iter().collect();
            tools.sort_by_key(|item| item.0.clone());
            for (tool, total) in tools {
                println!("{}: {}", tool, total);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: automation metadata supports verification planning, not blind trust.");
}
