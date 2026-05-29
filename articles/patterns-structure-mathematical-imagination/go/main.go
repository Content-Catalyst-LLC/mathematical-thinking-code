package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
	"sort"
)

type Edge struct {
	ObjectID string
	Source   string
	Target   string
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

	degrees := map[string]map[string]int{}
	edgeCounts := map[string]int{}

	for _, edge := range edges {
		if degrees[edge.ObjectID] == nil {
			degrees[edge.ObjectID] = map[string]int{}
		}
		degrees[edge.ObjectID][edge.Source]++
		degrees[edge.ObjectID][edge.Target]++
		edgeCounts[edge.ObjectID]++
	}

	fmt.Println("Graph structural features")
	for objectID, degreeMap := range degrees {
		sequence := []int{}
		for _, degree := range degreeMap {
			sequence = append(sequence, degree)
		}
		sort.Sort(sort.Reverse(sort.IntSlice(sequence)))
		fmt.Printf("%s: edges=%d degree_sequence=%v\n", objectID, edgeCounts[objectID], sequence)
	}
}
