use std::collections::{BTreeMap, BTreeSet};
use std::env;
use std::fs;

#[derive(Debug)]
struct Edge {
    source: String,
    target: String,
    relation: String,
    weight: i32,
}

fn parse_edges(path: &str) -> Vec<Edge> {
    let text = fs::read_to_string(path).expect("Could not read dependency CSV");
    text.lines()
        .skip(1)
        .filter_map(|line| {
            let parts: Vec<&str> = line.split(',').collect();
            if parts.len() < 4 {
                return None;
            }
            Some(Edge {
                source: parts[0].to_string(),
                target: parts[1].to_string(),
                relation: parts[2].to_string(),
                weight: parts[3].parse().unwrap_or(1),
            })
        })
        .collect()
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = args
        .get(1)
        .map(String::as_str)
        .unwrap_or("../data/raw/proof_dependencies.csv");

    let edges = parse_edges(path);
    let mut graph: BTreeMap<String, Vec<String>> = BTreeMap::new();
    let mut vertices: BTreeSet<String> = BTreeSet::new();

    for edge in &edges {
        graph.entry(edge.source.clone()).or_default().push(edge.target.clone());
        vertices.insert(edge.source.clone());
        vertices.insert(edge.target.clone());
    }

    println!("Proof dependency graph");
    println!("Vertices: {}", vertices.len());
    println!("Edges: {}", edges.len());
    println!();

    for edge in &edges {
        println!(
            "{} --{}:{}--> {}",
            edge.source, edge.relation, edge.weight, edge.target
        );
    }
}
