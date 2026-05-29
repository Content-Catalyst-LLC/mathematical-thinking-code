CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: pattern_invariants

pattern_invariants: pattern_invariants.cpp
	$(CXX) $(CXXFLAGS) pattern_invariants.cpp -o pattern_invariants

run: pattern_invariants
	./pattern_invariants

clean:
	rm -f pattern_invariants
