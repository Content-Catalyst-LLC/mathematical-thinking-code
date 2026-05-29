use std::collections::{HashMap, HashSet};
use std::env;
use std::fs;

type Relation = HashSet<(i32, i32)>;

fn is_reflexive(domain: &[i32], relation: &Relation) -> bool {
    domain.iter().all(|x| relation.contains(&(*x, *x)))
}

fn is_symmetric(relation: &Relation) -> bool {
    relation.iter().all(|(x, y)| relation.contains(&(*y, *x)))
}

fn is_transitive(relation: &Relation) -> bool {
    relation.iter().all(|(x, y)| {
        relation.iter()
            .filter(|(y2, _)| y == y2)
            .all(|(_, z)| relation.contains(&(*x, *z)))
    })
}

fn validate_function(domain: &[i32], codomain: &[i32], pairs: &[(i32, i32)]) -> (bool, String) {
    let codomain_set: HashSet<i32> = codomain.iter().copied().collect();
    let mut outputs: HashMap<i32, Vec<i32>> = HashMap::new();

    for (x, y) in pairs {
        outputs.entry(*x).or_default().push(*y);
        if !codomain_set.contains(y) {
            return (false, format!("output {} outside codomain", y));
        }
    }

    for x in domain {
        match outputs.get(x) {
            None => return (false, format!("input {} has no output", x)),
            Some(values) if values.len() != 1 => return (false, format!("input {} has {} outputs", x, values.len())),
            _ => {}
        }
    }

    (true, "valid total function on stated domain and codomain".to_string())
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/relation_pairs.csv");

    let domain = vec![1, 2, 3, 4];
    let mod2: Relation = domain
        .iter()
        .flat_map(|x| domain.iter().map(move |y| (*x, *y)))
        .filter(|(x, y)| x % 2 == y % 2)
        .collect();

    println!("mod2 reflexive: {}", is_reflexive(&domain, &mod2));
    println!("mod2 symmetric: {}", is_symmetric(&mod2));
    println!("mod2 transitive: {}", is_transitive(&mod2));

    let good_pairs = vec![(1, 2), (2, 4), (3, 6), (4, 8)];
    let bad_pairs = vec![(1, 1), (2, 4), (3, 9), (4, 16)];
    println!("double validation: {:?}", validate_function(&domain, &[2, 4, 6, 8], &good_pairs));
    println!("restricted square validation: {:?}", validate_function(&domain, &[1, 2, 3, 4, 6, 12], &bad_pairs));

    println!("\nRelation metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
