CXX ?= c++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra

all: model_type_counts

model_type_counts: model_type_counts.cpp
	$(CXX) $(CXXFLAGS) model_type_counts.cpp -o model_type_counts

run: model_type_counts
	./model_type_counts

clean:
	rm -f model_type_counts
