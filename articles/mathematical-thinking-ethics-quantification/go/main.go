package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Risk struct {
	ID         string
	MetricID   string
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
		if len(row) < 5 {
			continue
		}
		items = append(items, Risk{row[0], row[1], row[2], row[3], row[4]})
	}
	return items, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "metric_risks.csv")
	risks, err := loadRisks(path)
	if err != nil {
		panic(err)
	}

	fmt.Println("Quantification ethics risks")
	for _, risk := range risks {
		fmt.Printf("%s / %s / %s: %s Mitigation: %s\n", risk.ID, risk.MetricID, risk.Name, risk.Problem, risk.Mitigation)
	}

	fmt.Println("\nInterpretation: metrics require validity review, incentive review, uncertainty review, and contestable governance.")
}
