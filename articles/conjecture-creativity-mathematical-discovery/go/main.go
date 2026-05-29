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

	fmt.Println("Graph discovery invariant preview")
	for graphID, graphEdges := range graphs {
		degrees := map[string]int{}
		for _, edge := range graphEdges {
			degrees[edge.Source]++
			degrees[edge.Target]++
		}

		sequence := []int{}
		for _, degree := range degrees {
			sequence = append(sequence, degree)
		}
		sort.Sort(sort.Reverse(sort.IntSlice(sequence)))

		fmt.Printf("%s: edge_count=%d degree_sequence=%v\n", graphID, len(graphEdges), sequence)
	}

	fmt.Println("Interpretation: graph invariants can suggest conjectures but may be incomplete.")
}
