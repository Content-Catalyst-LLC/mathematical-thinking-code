CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: cross_field_counts

cross_field_counts: cross_field_counts.cpp
	$(CXX) $(CXXFLAGS) cross_field_counts.cpp -o cross_field_counts

run: cross_field_counts
	./cross_field_counts

clean:
	rm -f cross_field_counts
