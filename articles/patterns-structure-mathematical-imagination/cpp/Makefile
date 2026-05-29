CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: graph_invariants

graph_invariants: graph_invariants.cpp
	$(CXX) $(CXXFLAGS) graph_invariants.cpp -o graph_invariants

run: graph_invariants
	./graph_invariants

clean:
	rm -f graph_invariants
