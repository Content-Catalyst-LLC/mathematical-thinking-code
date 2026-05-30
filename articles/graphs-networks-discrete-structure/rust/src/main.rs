use std::collections::{HashMap, HashSet, VecDeque};
use std::env;
use std::fs;

type Graph = HashMap<String, HashSet<String>>;

fn add_edge(graph: &mut Graph, a: &str, b: &str) {
    graph.entry(a.to_string()).or_default().insert(b.to_string());
    graph.entry(b.to_string()).or_default().insert(a.to_string());
}

fn component(graph: &Graph, start: &str) -> HashSet<String> {
    let mut visited = HashSet::new();
    let mut queue = VecDeque::from([start.to_string()]);

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

fn main() {
    let args: Vec<String> = env::args().collect();
    let csv_path = args.get(1).map(String::as_str).unwrap_or("../data/raw/graph_edges.csv");

    let mut graph = Graph::new();
    add_edge(&mut graph, "A", "B");
    add_edge(&mut graph, "A", "C");
    add_edge(&mut graph, "B", "D");
    graph.entry("E".to_string()).or_default();

    println!("Graph audit");
    let mut nodes: Vec<_> = graph.keys().cloned().collect();
    nodes.sort();

    for node in nodes {
        let degree = graph.get(&node).map(|n| n.len()).unwrap_or(0);
        let comp = component(&graph, &node);
        println!("{} degree={} component_size={}", node, degree, comp.len());
    }

    let degree_sum: usize = graph.values().map(|neighbors| neighbors.len()).sum();
    println!("handshaking degree_sum={} twice_edges={}", degree_sum, 2 * 3);

    println!("\nEdge metadata preview");
    match fs::read_to_string(csv_path) {
        Ok(text) => {
            for line in text.lines().take(8) {
                println!("{}", line);
            }
        }
        Err(error) => println!("Could not read {}: {}", csv_path, error),
    }
}
