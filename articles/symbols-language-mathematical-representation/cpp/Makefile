CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: expression_representation

expression_representation: expression_representation.cpp
	$(CXX) $(CXXFLAGS) expression_representation.cpp -o expression_representation

run: expression_representation
	./expression_representation

clean:
	rm -f expression_representation
