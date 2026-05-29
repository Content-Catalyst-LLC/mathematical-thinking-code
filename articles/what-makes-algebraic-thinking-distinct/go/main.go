package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

type VariableRole struct {
	RoleID         string
	Symbol         string
	RoleType       string
	Example        string
	Interpretation string
}

func loadRoles(path string) ([]VariableRole, error) {
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

	roles := []VariableRole{}
	for _, row := range records[1:] {
		if len(row) < 5 {
			continue
		}
		roles = append(roles, VariableRole{row[0], row[1], row[2], row[3], row[4]})
	}
	return roles, nil
}

func main() {
	path := filepath.Join("..", "data", "raw", "variable_roles.csv")
	roles, err := loadRoles(path)
	if err != nil {
		panic(err)
	}

	counts := map[string]int{}
	for _, role := range roles {
		counts[role.RoleType]++
	}

	fmt.Println("Variable roles in algebraic thinking")
	for roleType, count := range counts {
		fmt.Printf("%s: %d\n", roleType, count)
	}

	fmt.Println("\nRole examples")
	for _, role := range roles {
		fmt.Printf("%s as %s: %s -- %s\n", role.Symbol, role.RoleType, role.Example, role.Interpretation)
	}

	fmt.Println("\nInterpretation: algebraic symbols require role awareness, not only symbol manipulation.")
}
