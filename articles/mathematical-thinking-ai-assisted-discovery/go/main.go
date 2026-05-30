package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Risk struct {
	ID         string
	Name       string
	Problem    string
	Mitigation string
}

func loadRisks(path string) ([]Risk, error) {
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

	items := []Risk{}
	for _, row := range records[1:] {
		if len(row) < 4 {
			continue
		}
		items = append(items, Risk{row[0], row[1], row[2], row[3]})
	}
	return items, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "discovery_risks.csv")
	risks, err := loadRisks(path)
	if err != nil {
		panic(err)
	}

	fmt.Println("AI-assisted discovery risks")
	for _, risk := range risks {
		fmt.Printf("%s / %s: %s Mitigation: %s\n", risk.ID, risk.Name, risk.Problem, risk.Mitigation)
	}

	fmt.Println("\nInterpretation: AI-assisted discovery requires verification, documentation, and human interpretation.")
}
