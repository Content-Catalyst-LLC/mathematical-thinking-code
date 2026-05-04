package main

import "fmt"

type Edge struct {
	From string
	To   string
}

func main() {
	edges := []Edge{
		{"Definition", "Lemma"},
		{"Lemma", "Theorem"},
		{"Base Case", "Induction Principle"},
		{"Inductive Step", "Induction Principle"},
		{"Induction Principle", "Theorem"},
	}

	outDegree := map[string]int{}

	for _, edge := range edges {
		outDegree[edge.From]++
		if _, exists := outDegree[edge.To]; !exists {
			outDegree[edge.To] = 0
		}
	}

	fmt.Println("Proof dependency out-degree:")
	for node, degree := range outDegree {
		fmt.Printf("%s: %d\n", node, degree)
	}
}
