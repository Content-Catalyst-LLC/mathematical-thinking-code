package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
	"sort"
)

type Edge struct {
	GraphID string
	Source  string
	Target  string
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
		if len(row) < 3 {
			continue
		}
		edges = append(edges, Edge{row[0], row[1], row[2]})
	}
	return edges, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "graph_edges.csv")
	edges, err := loadEdges(path)
	if err != nil {
		panic(err)
	}

	graphs := map[string][]Edge{}
	for _, edge := range edges {
		graphs[edge.GraphID] = append(graphs[edge.GraphID], edge)
	}

	fmt.Println("Graph representation audit")
	for graphID, graphEdges := range graphs {
		vertexSet := map[string]bool{}
		for _, edge := range graphEdges {
			vertexSet[edge.Source] = true
			vertexSet[edge.Target] = true
		}

		vertices := []string{}
		for vertex := range vertexSet {
			vertices = append(vertices, vertex)
		}
		sort.Strings(vertices)

		fmt.Printf("%s: vertices=%v edge_count=%d representation=edge_list\n", graphID, vertices, len(graphEdges))
	}

	fmt.Println("Interpretation: edge lists preserve adjacency relations while omitting layout geometry.")
}
