package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Warning struct {
	ID            string
	GraphID       string
	StructureType string
	Warning       string
	Mitigation     string
}

func loadWarnings(path string) ([]Warning, error) {
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

	items := []Warning{}
	for _, row := range records[1:] {
		if len(row) < 5 {
			continue
		}
		items = append(items, Warning{row[0], row[1], row[2], row[3], row[4]})
	}
	return items, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "network_warnings.csv")
	warnings, err := loadWarnings(path)
	if err != nil {
		panic(err)
	}

	counts := map[string]int{}
	for _, warning := range warnings {
		counts[warning.StructureType]++
	}

	fmt.Println("Network warnings by structure type")
	for kind, count := range counts {
		fmt.Printf("%s: %d\n", kind, count)
	}

	fmt.Println("\nWarnings")
	for _, warning := range warnings {
		fmt.Printf("%s/%s: %s Mitigation: %s\n", warning.GraphID, warning.StructureType, warning.Warning, warning.Mitigation)
	}

	fmt.Println("\nInterpretation: graph analysis requires explicit node definitions, edge meanings, direction, weights, provenance, and consequences.")
}
