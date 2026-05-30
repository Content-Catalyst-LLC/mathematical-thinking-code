use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/symbol_records.csv");

    println!("Algebraic notation symbol audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut symbol_count = 0usize;
            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                symbol_count += 1;
                println!("{}", line);
            }
            println!("\nsymbol_count={}", symbol_count);
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: symbols require context, domain assumptions, and pedagogy.");
}
