use std::env;
use std::fs;

fn insertion_sort(values: &[i32]) -> Vec<i32> {
    let mut result = values.to_vec();

    for i in 1..result.len() {
        let key = result[i];
        let mut j = i;

        while j > 0 && result[j - 1] > key {
            result[j] = result[j - 1];
            j -= 1;
        }

        result[j] = key;
    }

    result
}

fn is_sorted(values: &[i32]) -> bool {
    values.windows(2).all(|pair| pair[0] <= pair[1])
}

fn same_multiset(left: &[i32], right: &[i32]) -> bool {
    let mut a = left.to_vec();
    let mut b = right.to_vec();
    a.sort();
    b.sort();
    a == b
}

fn binary_search(values: &[i32], target: i32) -> Option<usize> {
    let mut low = 0usize;
    let mut high = values.len();

    while low < high {
        let mid = low + (high - low) / 2;
        if values[mid] == target {
            return Some(mid);
        } else if values[mid] < target {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    None
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/algorithm_specifications.csv");

    let input = vec![5, 2, 8, 1, 3, 2];
    let output = insertion_sort(&input);

    println!("Formal reasoning audit");
    println!("input={:?}", input);
    println!("output={:?}", output);
    println!("is_sorted={}", is_sorted(&output));
    println!("same_multiset={}", same_multiset(&input, &output));
    println!("binary_search_8={:?}", binary_search(&output, 8));

    println!("\nComplexity growth preview");
    for n in 1u32..=12u32 {
        println!("n={} log2={:.3} linear={} quadratic={} exponential={}", n, (n as f64).log2(), n, n * n, 2u32.pow(n));
    }

    println!("\nSpecification metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
