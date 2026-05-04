fn triangular_number(n: u64) -> u64 {
    n * (n + 1) / 2
}

fn sum_first_n(n: u64) -> u64 {
    (1..=n).sum()
}

fn main() {
    println!("Mathematical Thinking CLI: induction-style checks");

    for n in 1..=20 {
        let direct_sum = sum_first_n(n);
        let formula = triangular_number(n);
        let matches = direct_sum == formula;

        println!(
            "n = {:2}, sum = {:4}, formula = {:4}, matches = {}",
            n, direct_sum, formula, matches
        );
    }

    println!("\nThis is computational evidence, not a proof.");
}
