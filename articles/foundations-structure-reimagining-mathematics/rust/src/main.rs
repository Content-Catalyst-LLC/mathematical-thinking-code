use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/mathematical_structures.csv");

    println!("Foundations and structure metadata audit");

    match fs::read_to_string(csv_path) {
        Ok(text) => {
            let mut count = 0usize;
            for (index, line) in text.lines().enumerate() {
                if index == 0 {
                    println!("header: {}", line);
                    continue;
                }
                count += 1;
                println!("{}", line);
            }
            println!("\nstructure_count={}", count);
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }

    println!("\nInterpretation: structures should be reviewed through objects, operations, laws, preservation maps, and examples.");
}
