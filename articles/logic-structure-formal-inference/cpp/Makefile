CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: formal_inference

formal_inference: formal_inference.cpp
	$(CXX) $(CXXFLAGS) formal_inference.cpp -o formal_inference

run: formal_inference
	./formal_inference

clean:
	rm -f formal_inference
