CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: cs_math_audit

cs_math_audit: cs_math_audit.cpp
	$(CXX) $(CXXFLAGS) cs_math_audit.cpp -o cs_math_audit

run: cs_math_audit
	./cs_math_audit

clean:
	rm -f cs_math_audit
