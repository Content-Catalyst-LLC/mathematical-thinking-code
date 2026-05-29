CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: discrete_structures

discrete_structures: discrete_structures.cpp
	$(CXX) $(CXXFLAGS) discrete_structures.cpp -o discrete_structures

run: discrete_structures
	./discrete_structures

clean:
	rm -f discrete_structures
