CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: sequence_pattern

sequence_pattern: sequence_pattern.cpp
	$(CXX) $(CXXFLAGS) sequence_pattern.cpp -o sequence_pattern

run: sequence_pattern
	./sequence_pattern

clean:
	rm -f sequence_pattern
