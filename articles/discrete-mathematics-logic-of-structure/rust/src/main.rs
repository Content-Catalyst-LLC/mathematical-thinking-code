use std::collections::{HashMap, HashSet, VecDeque};
use std::env;
use std::fs;

type Graph = HashMap<String, HashSet<String>>;

fn add_undirected_edge(graph: &mut Graph, a: &str, b: &str) {
    graph.entry(a.to_string()).or_default().insert(b.to_string());
    graph.entry(b.to_string()).or_default().insert(a.to_string());
}

fn connected_component(graph: &Graph, start: &str) -> HashSet<String> {
    let mut visited = HashSet::new();
    let mut queue = VecDeque::new();
    queue.push_back(start.to_string());

    while let Some(node) = queue.pop_front() {
        if !visited.insert(node.clone()) {
            continue;
        }
        if let Some(neighbors) = graph.get(&node) {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    queue.push_back(neighbor.clone());
                }
            }
        }
    }

    visited
}

fn fibonacci(n: usize) -> u64 {
    if n == 0 {
        return 0;
    }
    let mut previous = 0_u64;
    let mut current = 1_u64;
    for _ in 2..=n {
        let next = previous + current;
        previous = current;
        current = next;
    }
    current
}

fn binomial(n: u64, k: u64) -> u64 {
    if k > n {
        return 0;
    }
    let k = k.min(n - k);
    let mut result = 1_u64;
    for i in 1..=k {
        result = result * (n - k + i) / i;
    }
    result
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/graph_edges.csv");

    let mut graph = Graph::new();
    add_undirected_edge(&mut graph, "A", "B");
    add_undirected_edge(&mut graph, "A", "C");
    add_undirected_edge(&mut graph, "B", "D");
    graph.entry("E".to_string()).or_default();

    println!("Graph audit");
    for node in ["A", "B", "C", "D", "E"] {
        let degree = graph.get(node).map(|neighbors| neighbors.len()).unwrap_or(0);
        let component = connected_component(&graph, node);
        println!("{} degree={} component_size={}", node, degree, component.len());
    }

    println!("\nRecurrence and modular audit");
    for n in 0..=10 {
        println!("n={} fib={} mod7={} C(10,n)={}", n, fibonacci(n), n % 7, binomial(10, n as u64));
    }

    println!("\nGraph metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
