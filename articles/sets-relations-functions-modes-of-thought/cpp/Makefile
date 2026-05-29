CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: relation_function_audit

relation_function_audit: relation_function_audit.cpp
	$(CXX) $(CXXFLAGS) relation_function_audit.cpp -o relation_function_audit

run: relation_function_audit
	./relation_function_audit

clean:
	rm -f relation_function_audit
