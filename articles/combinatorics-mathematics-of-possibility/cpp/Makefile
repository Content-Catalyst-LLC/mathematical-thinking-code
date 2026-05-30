CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: combinatorics_audit

combinatorics_audit: combinatorics_audit.cpp
	$(CXX) $(CXXFLAGS) combinatorics_audit.cpp -o combinatorics_audit

run: combinatorics_audit
	./combinatorics_audit

clean:
	rm -f combinatorics_audit
