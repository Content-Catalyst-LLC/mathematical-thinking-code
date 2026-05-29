package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Edge struct {
	Source   string
	Target   string
	Relation string
	Weight   string
}

func loadEdges(path string) ([]Edge, error) {
	handle, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer handle.Close()

	reader := csv.NewReader(handle)
	records, err := reader.ReadAll()
	if err != nil {
		return nil, err
	}

	edges := []Edge{}
	for _, row := range records[1:] {
		if len(row) < 4 {
			continue
		}
		edges = append(edges, Edge{row[0], row[1], row[2], row[3]})
	}
	return edges, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "proof_dependencies.csv")
	edges, err := loadEdges(path)
	if err != nil {
		panic(err)
	}

	graph := map[string][]string{}
	for _, edge := range edges {
		graph[edge.Source] = append(graph[edge.Source], edge.Target)
		if _, ok := graph[edge.Target]; !ok {
			graph[edge.Target] = []string{}
		}
	}

	fmt.Println("Proof graph adjacency list")
	for node, targets := range graph {
		fmt.Printf("%s -> %v\n", node, targets)
	}
}
