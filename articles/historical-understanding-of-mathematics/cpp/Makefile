CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: proof_style_counts

proof_style_counts: proof_style_counts.cpp
	$(CXX) $(CXXFLAGS) proof_style_counts.cpp -o proof_style_counts

run: proof_style_counts
	./proof_style_counts

clean:
	rm -f proof_style_counts
