package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Warning struct {
	ID            string
	StructureType string
	StructureID   string
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
	path := filepath.Join("..", "data", "raw", "structure_warnings.csv")
	warnings, err := loadWarnings(path)
	if err != nil {
		panic(err)
	}

	counts := map[string]int{}
	for _, warning := range warnings {
		counts[warning.StructureType]++
	}

	fmt.Println("Discrete-structure warnings by type")
	for kind, count := range counts {
		fmt.Printf("%s: %d\n", kind, count)
	}

	fmt.Println("\nWarnings")
	for _, warning := range warnings {
		fmt.Printf("%s/%s: %s Mitigation: %s\n", warning.StructureType, warning.StructureID, warning.Warning, warning.Mitigation)
	}

	fmt.Println("\nInterpretation: discrete structures preserve selected structure while omitting other context.")
}
