package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Transformation struct {
	ID     string
	Name   string
	Type   string
	Changes string
	Preserves string
	Risk   string
}

func loadTransformations(path string) ([]Transformation, error) {
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

	items := []Transformation{}
	for _, row := range records[1:] {
		if len(row) < 6 {
			continue
		}
		items = append(items, Transformation{row[0], row[1], row[2], row[3], row[4], row[5]})
	}
	return items, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "transformations.csv")
	transformations, err := loadTransformations(path)
	if err != nil {
		panic(err)
	}

	counts := map[string]int{}
	for _, t := range transformations {
		counts[t.Type]++
	}

	fmt.Println("Transformation types")
	for kind, count := range counts {
		fmt.Printf("%s: %d\n", kind, count)
	}

	fmt.Println("\nTransformation audit")
	for _, t := range transformations {
		fmt.Printf("%s changes %s and preserves %s. Risk: %s\n", t.Name, t.Changes, t.Preserves, t.Risk)
	}

	fmt.Println("\nInterpretation: geometry studies what changes and what remains invariant under transformation.")
}
