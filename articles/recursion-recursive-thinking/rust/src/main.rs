use std::collections::HashMap;
use std::env;
use std::fs;

#[derive(Debug)]
enum Tree {
    Leaf(String),
    Node(String, Vec<Tree>),
}

fn factorial(n: u128) -> u128 {
    if n == 0 {
        1
    } else {
        n * factorial(n - 1)
    }
}

fn fibonacci_memo(n: u64, memo: &mut HashMap<u64, u128>) -> u128 {
    if n == 0 {
        return 0;
    }
    if n == 1 {
        return 1;
    }
    if let Some(value) = memo.get(&n) {
        return *value;
    }
    let value = fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo);
    memo.insert(n, value);
    value
}

fn tree_size(tree: &Tree) -> usize {
    match tree {
        Tree::Leaf(_) => 1,
        Tree::Node(_, children) => 1 + children.iter().map(tree_size).sum::<usize>(),
    }
}

fn tree_depth(tree: &Tree) -> usize {
    match tree {
        Tree::Leaf(_) => 1,
        Tree::Node(_, children) if children.is_empty() => 1,
        Tree::Node(_, children) => 1 + children.iter().map(tree_depth).max().unwrap_or(0),
    }
}

fn tree_label_length_sum(tree: &Tree) -> usize {
    match tree {
        Tree::Leaf(label) => label.len(),
        Tree::Node(label, children) => label.len() + children.iter().map(tree_label_length_sum).sum::<usize>(),
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/recursive_definitions.csv");

    let proof_tree = Tree::Node(
        "theorem".to_string(),
        vec![
            Tree::Node("lemma".to_string(), vec![Tree::Leaf("definition".to_string()), Tree::Leaf("case".to_string())]),
            Tree::Leaf("corollary".to_string()),
        ],
    );

    println!("Recursion audit");
    for n in 0..=12_u128 {
        let mut memo = HashMap::new();
        println!("n={} factorial={} fibonacci={}", n, factorial(n), fibonacci_memo(n as u64, &mut memo));
    }

    println!("\nTree audit");
    println!("tree_size={}", tree_size(&proof_tree));
    println!("tree_depth={}", tree_depth(&proof_tree));
    println!("tree_label_length_sum={}", tree_label_length_sum(&proof_tree));

    println!("\nDefinition metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
