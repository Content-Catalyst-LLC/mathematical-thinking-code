CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: discrete_structure

discrete_structure: discrete_structure.cpp
	$(CXX) $(CXXFLAGS) discrete_structure.cpp -o discrete_structure

run: discrete_structure
	./discrete_structure

clean:
	rm -f discrete_structure
