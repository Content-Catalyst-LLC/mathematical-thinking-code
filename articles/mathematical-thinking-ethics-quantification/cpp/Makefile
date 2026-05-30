CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: metric_type_counts

metric_type_counts: metric_type_counts.cpp
	$(CXX) $(CXXFLAGS) metric_type_counts.cpp -o metric_type_counts

run: metric_type_counts
	./metric_type_counts

clean:
	rm -f metric_type_counts
