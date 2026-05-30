CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: thinking_mode_counts

thinking_mode_counts: thinking_mode_counts.cpp
	$(CXX) $(CXXFLAGS) thinking_mode_counts.cpp -o thinking_mode_counts

run: thinking_mode_counts
	./thinking_mode_counts

clean:
	rm -f thinking_mode_counts
