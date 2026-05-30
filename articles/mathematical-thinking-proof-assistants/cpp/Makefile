CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: proof_boundary_counts

proof_boundary_counts: proof_boundary_counts.cpp
	$(CXX) $(CXXFLAGS) proof_boundary_counts.cpp -o proof_boundary_counts

run: proof_boundary_counts
	./proof_boundary_counts

clean:
	rm -f proof_boundary_counts
