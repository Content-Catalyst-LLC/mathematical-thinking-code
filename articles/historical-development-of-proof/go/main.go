package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Warning struct {
	ID         string
	Topic      string
	Warning    string
	Mitigation string
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
		if len(row) < 4 {
			continue
		}
		items = append(items, Warning{row[0], row[1], row[2], row[3]})
	}
	return items, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "historiographic_warnings.csv")
	warnings, err := loadWarnings(path)
	if err != nil {
		panic(err)
	}

	fmt.Println("Historiographic warnings")
	for _, warning := range warnings {
		fmt.Printf("%s / %s: %s Mitigation: %s\n", warning.ID, warning.Topic, warning.Warning, warning.Mitigation)
	}

	fmt.Println("\nInterpretation: responsible proof history documents canon risk, presentism, translation, and technological triumphalism.")
}
