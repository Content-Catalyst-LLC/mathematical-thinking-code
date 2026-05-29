GHC ?= ghc

.PHONY: all run clean

all: formal_math_demo

formal_math_demo: Main.hs
	$(GHC) -O2 Main.hs -o formal_math_demo

run: formal_math_demo
	mkdir -p ../outputs/tables
	./formal_math_demo

clean:
	rm -f formal_math_demo Main.hi Main.o
