CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: expression_tree_demo

expression_tree_demo: expression_tree_demo.cpp
	$(CXX) $(CXXFLAGS) expression_tree_demo.cpp -o expression_tree_demo

run: expression_tree_demo
	./expression_tree_demo

clean:
	rm -f expression_tree_demo
