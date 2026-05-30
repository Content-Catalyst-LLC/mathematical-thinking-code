CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: category_structure_counts

category_structure_counts: category_structure_counts.cpp
	$(CXX) $(CXXFLAGS) category_structure_counts.cpp -o category_structure_counts

run: category_structure_counts
	./category_structure_counts

clean:
	rm -f category_structure_counts
