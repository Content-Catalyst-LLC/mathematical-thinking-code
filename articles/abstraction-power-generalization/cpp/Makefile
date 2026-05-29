CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: abstraction_invariants

abstraction_invariants: abstraction_invariants.cpp
	$(CXX) $(CXXFLAGS) abstraction_invariants.cpp -o abstraction_invariants

run: abstraction_invariants
	./abstraction_invariants

clean:
	rm -f abstraction_invariants
