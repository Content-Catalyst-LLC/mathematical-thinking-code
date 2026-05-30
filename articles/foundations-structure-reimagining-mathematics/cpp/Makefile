CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: structure_counts

structure_counts: structure_counts.cpp
	$(CXX) $(CXXFLAGS) structure_counts.cpp -o structure_counts

run: structure_counts
	./structure_counts

clean:
	rm -f structure_counts
