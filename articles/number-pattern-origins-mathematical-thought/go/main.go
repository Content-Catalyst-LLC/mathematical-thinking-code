package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type Origin struct {
	ID          string
	Name        string
	Type        string
	Description string
}

func loadOrigins(path string) ([]Origin, error) {
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

	origins := []Origin{}
	for _, row := range records[1:] {
		if len(row) < 4 {
			continue
		}
		origins = append(origins, Origin{row[0], row[1], row[2], row[3]})
	}
	return origins, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "mathematical_origins.csv")
	origins, err := loadOrigins(path)
	if err != nil {
		panic(err)
	}

	counts := map[string]int{}
	for _, origin := range origins {
		counts[origin.Type]++
	}

	fmt.Println("Mathematical origins by type")
	for kind, count := range counts {
		fmt.Printf("%s: %d\n", kind, count)
	}

	fmt.Println("\nOrigins")
	for _, origin := range origins {
		fmt.Printf("%s (%s): %s\n", origin.Name, origin.Type, origin.Description)
	}

	fmt.Println("\nInterpretation: mathematical thought grows from cognition, culture, representation, and formalization.")
}
