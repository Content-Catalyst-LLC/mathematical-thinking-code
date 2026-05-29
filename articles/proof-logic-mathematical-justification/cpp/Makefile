CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: proof_graph_induction

proof_graph_induction: proof_graph_induction.cpp
	$(CXX) $(CXXFLAGS) proof_graph_induction.cpp -o proof_graph_induction

run: proof_graph_induction
	./proof_graph_induction

clean:
	rm -f proof_graph_induction
