CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: visual_status_counts

visual_status_counts: visual_status_counts.cpp
	$(CXX) $(CXXFLAGS) visual_status_counts.cpp -o visual_status_counts

run: visual_status_counts
	./visual_status_counts

clean:
	rm -f visual_status_counts
