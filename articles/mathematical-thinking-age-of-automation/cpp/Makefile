CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: evidence_standard_counts

evidence_standard_counts: evidence_standard_counts.cpp
	$(CXX) $(CXXFLAGS) evidence_standard_counts.cpp -o evidence_standard_counts

run: evidence_standard_counts
	./evidence_standard_counts

clean:
	rm -f evidence_standard_counts
