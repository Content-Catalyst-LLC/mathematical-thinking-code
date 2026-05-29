CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: procedure_verification

procedure_verification: procedure_verification.cpp
	$(CXX) $(CXXFLAGS) procedure_verification.cpp -o procedure_verification

run: procedure_verification
	./procedure_verification

clean:
	rm -f procedure_verification
