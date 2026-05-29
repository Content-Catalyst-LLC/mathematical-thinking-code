package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Move struct {
	ID       string
	Stage    string
	Question string
	Role     string
}

func loadMoves(path string) ([]Move, error) {
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

	moves := []Move{}
	for _, row := range records[1:] {
		if len(row) < 4 {
			continue
		}
		moves = append(moves, Move{row[0], row[1], row[2], row[3]})
	}
	return moves, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "reasoning_moves.csv")
	moves, err := loadMoves(path)
	if err != nil {
		panic(err)
	}

	counts := map[string]int{}
	for _, move := range moves {
		counts[move.Stage]++
	}

	fmt.Println("Reasoning moves by stage")
	for stage, count := range counts {
		fmt.Printf("%s: %d\n", stage, count)
	}

	fmt.Println("Interpretation: non-algorithmic reasoning can be documented as visible learning moves.")
}
