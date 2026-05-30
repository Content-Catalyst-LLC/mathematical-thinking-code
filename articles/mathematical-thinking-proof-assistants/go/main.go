package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Skill struct {
	ID       string
	Name     string
	Why      string
	Question string
}

func loadSkills(path string) ([]Skill, error) {
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

	items := []Skill{}
	for _, row := range records[1:] {
		if len(row) < 4 {
			continue
		}
		items = append(items, Skill{row[0], row[1], row[2], row[3]})
	}
	return items, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "proof_assistant_skills.csv")
	skills, err := loadSkills(path)
	if err != nil {
		panic(err)
	}

	fmt.Println("Proof-assistant literacy skills")
	for _, skill := range skills {
		fmt.Printf("%s / %s: %s Review: %s\n", skill.ID, skill.Name, skill.Why, skill.Question)
	}

	fmt.Println("\nInterpretation: proof-assistant literacy combines formal syntax, mathematical meaning, and verification habits.")
}
