CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: candidate_status_counts

candidate_status_counts: candidate_status_counts.cpp
	$(CXX) $(CXXFLAGS) candidate_status_counts.cpp -o candidate_status_counts

run: candidate_status_counts
	./candidate_status_counts

clean:
	rm -f candidate_status_counts
