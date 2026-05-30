CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: graph_audit

graph_audit: graph_audit.cpp
	$(CXX) $(CXXFLAGS) graph_audit.cpp -o graph_audit

run: graph_audit
	./graph_audit

clean:
	rm -f graph_audit
