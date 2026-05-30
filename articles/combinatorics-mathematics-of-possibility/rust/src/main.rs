use std::env;
use std::fs;

fn factorial(n: u128) -> u128 {
    (1..=n).product::<u128>().max(1)
}

fn permutation(n: u128, k: u128) -> u128 {
    factorial(n) / factorial(n - k)
}

fn combination(n: u128, k: u128) -> u128 {
    if k > n {
        return 0;
    }
    let k = k.min(n - k);
    let mut result = 1_u128;
    for i in 1..=k {
        result = result * (n - k + i) / i;
    }
    result
}

fn fibonacci_tilings(n: usize) -> u128 {
    if n == 0 || n == 1 {
        return 1;
    }
    let mut previous = 1_u128;
    let mut current = 1_u128;
    for _ in 2..=n {
        let next = previous + current;
        previous = current;
        current = next;
    }
    current
}

fn simple_graph_count(n: u128) -> u128 {
    2_u128.pow(combination(n, 2) as u32)
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/combinatorial_problems.csv");

    println!("Combinatorics audit");
    println!("P(10,3) ranked finalists: {}", permutation(10, 3));
    println!("C(10,3) committee: {}", combination(10, 3));
    println!("36^6 password space: {}", 36_u128.pow(6));
    println!("multiples of 2 or 3 through 100: {}", 100 / 2 + 100 / 3 - 100 / 6);

    println!("\nSearch-space growth");
    for n in 1..=10_u128 {
        println!(
            "n={} subsets={} permutations={} simple_graphs={}",
            n,
            2_u128.pow(n as u32),
            factorial(n),
            simple_graph_count(n)
        );
    }

    println!("\nFibonacci tilings");
    for n in 0..=12 {
        println!("n={} tilings={}", n, fibonacci_tilings(n));
    }

    println!("\nProblem metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
