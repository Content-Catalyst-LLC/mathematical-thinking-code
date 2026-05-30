GHC ?= ghc

.PHONY: all run clean

all: combinatorics_possibility_demo

combinatorics_possibility_demo: Main.hs
	$(GHC) -O2 Main.hs -o combinatorics_possibility_demo

run: combinatorics_possibility_demo
	mkdir -p ../outputs/tables
	./combinatorics_possibility_demo

clean:
	rm -f combinatorics_possibility_demo Main.hi Main.o
