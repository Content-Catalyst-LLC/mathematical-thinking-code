CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: geometry_primitives

geometry_primitives: geometry_primitives.cpp
	$(CXX) $(CXXFLAGS) geometry_primitives.cpp -o geometry_primitives

run: geometry_primitives
	./geometry_primitives

clean:
	rm -f geometry_primitives
