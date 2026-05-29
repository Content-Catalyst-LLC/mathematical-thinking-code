use std::collections::BTreeMap;
use std::env;
use std::fs;

fn gcd(mut a: i64, mut b: i64) -> i64 {
    a = a.abs();
    b = b.abs();
    while b != 0 {
        let r = a % b;
        a = b;
        b = r;
    }
    a
}

fn normalize(numerator: i64, denominator: i64) -> (i64, i64) {
    if denominator == 0 {
        panic!("denominator cannot be zero");
    }
    let sign = if denominator < 0 { -1 } else { 1 };
    let n = numerator * sign;
    let d = denominator * sign;
    let g = gcd(n, d);
    (n / g, d / g)
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = args
        .get(1)
        .map(String::as_str)
        .unwrap_or("../data/raw/fractions.csv");

    let text = fs::read_to_string(path).expect("Could not read fractions CSV");
    let mut classes: BTreeMap<(i64, i64), Vec<String>> = BTreeMap::new();

    for line in text.lines().skip(1) {
        let parts: Vec<&str> = line.split(',').collect();
        if parts.len() < 3 {
            continue;
        }

        let id = parts[0].to_string();
        let numerator: i64 = parts[1].parse().expect("bad numerator");
        let denominator: i64 = parts[2].parse().expect("bad denominator");
        classes.entry(normalize(numerator, denominator)).or_default().push(id);
    }

    println!("Rational equivalence classes");
    for ((n, d), members) in classes {
        println!("{}/{} -> {:?}", n, d, members);
    }
}
