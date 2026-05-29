use std::env;
use std::fs;

fn implies(p: bool, q: bool) -> bool {
    !p || q
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = args
        .get(1)
        .map(String::as_str)
        .unwrap_or("../data/raw/inference_rules.csv");

    println!("Implication and contrapositive truth table");
    for p in [false, true] {
        for q in [false, true] {
            let original = implies(p, q);
            let contrapositive = implies(!q, !p);
            println!(
                "P={} Q={} P->Q={} notQ->notP={} equivalent={}",
                p,
                q,
                original,
                contrapositive,
                original == contrapositive
            );
        }
    }

    println!("\nInference-rule catalog");
    let text = fs::read_to_string(path).expect("Could not read inference rule CSV");
    for line in text.lines().skip(1) {
        let parts: Vec<&str> = line.split(',').collect();
        if parts.len() < 2 {
            continue;
        }
        println!("{}: {}", parts[0], parts[1]);
    }

    println!("\nInterpretation: truth tables inspect propositional form; mathematical domains still require theorem-specific proof.");
}
