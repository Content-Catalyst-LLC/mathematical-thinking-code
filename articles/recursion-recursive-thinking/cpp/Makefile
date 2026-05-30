CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: recursion_audit

recursion_audit: recursion_audit.cpp
	$(CXX) $(CXXFLAGS) recursion_audit.cpp -o recursion_audit

run: recursion_audit
	./recursion_audit

clean:
	rm -f recursion_audit
