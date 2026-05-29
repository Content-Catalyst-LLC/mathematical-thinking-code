use std::collections::{BTreeMap, BTreeSet};
use std::env;
use std::fs;

#[derive(Debug)]
struct Edge {
    object_id: String,
    source: String,
    target: String,
}

fn read_edges(path: &str) -> Vec<Edge> {
    let text = fs::read_to_string(path).expect("Could not read graph edge CSV");
    text.lines()
        .skip(1)
        .filter_map(|line| {
            let parts: Vec<&str> = line.split(',').collect();
            if parts.len() < 3 {
                return None;
            }
            Some(Edge {
                object_id: parts[0].to_string(),
                source: parts[1].to_string(),
                target: parts[2].to_string(),
            })
        })
        .collect()
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let edge_path = args
        .get(2)
        .map(String::as_str)
        .unwrap_or("../data/raw/graph_edges.csv");

    let edges = read_edges(edge_path);
    let mut vertices_by_object: BTreeMap<String, BTreeSet<String>> = BTreeMap::new();
    let mut edge_count_by_object: BTreeMap<String, usize> = BTreeMap::new();
    let mut degree_by_object: BTreeMap<String, BTreeMap<String, usize>> = BTreeMap::new();

    for edge in edges {
        vertices_by_object
            .entry(edge.object_id.clone())
            .or_default()
            .insert(edge.source.clone());
        vertices_by_object
            .entry(edge.object_id.clone())
            .or_default()
            .insert(edge.target.clone());

        *edge_count_by_object.entry(edge.object_id.clone()).or_insert(0) += 1;

        *degree_by_object
            .entry(edge.object_id.clone())
            .or_default()
            .entry(edge.source.clone())
            .or_insert(0) += 1;

        *degree_by_object
            .entry(edge.object_id.clone())
            .or_default()
            .entry(edge.target.clone())
            .or_insert(0) += 1;
    }

    println!("Invariant inspector");
    for (object_id, vertices) in vertices_by_object {
        let edge_count = edge_count_by_object.get(&object_id).unwrap_or(&0);
        let mut degree_sequence: Vec<usize> = degree_by_object
            .get(&object_id)
            .unwrap()
            .values()
            .cloned()
            .collect();
        degree_sequence.sort_by(|a, b| b.cmp(a));

        println!(
            "{}: vertices={}, edges={}, degree_sequence={:?}",
            object_id,
            vertices.len(),
            edge_count,
            degree_sequence
        );
    }
}
