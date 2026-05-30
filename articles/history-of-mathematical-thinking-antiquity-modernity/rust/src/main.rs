use std::collections::HashMap;
use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/mathematical_milestones.csv");

    println!("History of mathematical thinking metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut mode_counts: HashMap<String, usize> = HashMap::new();
            let mut period_counts: HashMap<String, usize> = HashMap::new();

            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    continue;
                }
                let cells: Vec<&str> = line.split(',').collect();
                if cells.len() > 3 {
                    *period_counts.entry(cells[1].to_string()).or_insert(0) += 1;
                    *mode_counts.entry(cells[3].to_string()).or_insert(0) += 1;
                }
            }

            println!("\nMilestone counts by mode id:");
            let mut modes: Vec<_> = mode_counts.iter().collect();
            modes.sort_by_key(|item| item.0.clone());
            for (mode, count) in modes {
                println!("{}: {}", mode, count);
            }

            println!("\nMilestone counts by period id:");
            let mut periods: Vec<_> = period_counts.iter().collect();
            periods.sort_by_key(|item| item.0.clone());
            for (period, count) in periods {
                println!("{}: {}", period, count);
            }

            println!("\nPreview:");
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: metadata counts support audit coverage, not historical ranking.");
}
