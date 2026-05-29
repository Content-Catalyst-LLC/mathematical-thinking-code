use std::env;
use std::fs;

fn quality(assumptions_checked: bool, interpretation_given: bool, justification_given: bool) -> &'static str {
    if assumptions_checked && interpretation_given && justification_given {
        "strong reasoning"
    } else if justification_given {
        "partially justified"
    } else {
        "procedural or incomplete"
    }
}

fn quadratic_residual(x: f64) -> f64 {
    x * x - 5.0 * x + 6.0
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/reasoning_moves.csv");

    println!("Reasoning quality examples");
    println!("formula only: {}", quality(false, false, false));
    println!("verified but not interpreted: {}", quality(true, false, true));
    println!("verified and interpreted: {}", quality(true, true, true));

    println!("\nQuadratic residual checks");
    for candidate in [2.0, 3.0, 4.0] {
        println!("root={} residual={}", candidate, quadratic_residual(candidate));
    }

    println!("\nReasoning moves preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(6) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
