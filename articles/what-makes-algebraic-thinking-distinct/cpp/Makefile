CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: algebraic_expression

algebraic_expression: algebraic_expression.cpp
	$(CXX) $(CXXFLAGS) algebraic_expression.cpp -o algebraic_expression

run: algebraic_expression
	./algebraic_expression

clean:
	rm -f algebraic_expression
