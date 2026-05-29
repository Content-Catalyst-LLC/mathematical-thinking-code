CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: conjecture_discovery

conjecture_discovery: conjecture_discovery.cpp
	$(CXX) $(CXXFLAGS) conjecture_discovery.cpp -o conjecture_discovery

run: conjecture_discovery
	./conjecture_discovery

clean:
	rm -f conjecture_discovery
