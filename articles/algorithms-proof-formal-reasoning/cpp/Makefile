CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: algorithm_proof_audit

algorithm_proof_audit: algorithm_proof_audit.cpp
	$(CXX) $(CXXFLAGS) algorithm_proof_audit.cpp -o algorithm_proof_audit

run: algorithm_proof_audit
	./algorithm_proof_audit

clean:
	rm -f algorithm_proof_audit
