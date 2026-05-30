GHC ?= ghc

.PHONY: all run clean

all: category_abstraction_demo

category_abstraction_demo: Main.hs
	$(GHC) -O2 Main.hs -o category_abstraction_demo

run: category_abstraction_demo
	mkdir -p ../outputs/tables
	./category_abstraction_demo

clean:
	rm -f category_abstraction_demo Main.hi Main.o
