GHC ?= ghc

.PHONY: all run clean

all: mathematical_thinking_computer_science_demo

mathematical_thinking_computer_science_demo: Main.hs
	$(GHC) -O2 Main.hs -o mathematical_thinking_computer_science_demo

run: mathematical_thinking_computer_science_demo
	mkdir -p ../outputs/tables
	./mathematical_thinking_computer_science_demo

clean:
	rm -f mathematical_thinking_computer_science_demo Main.hi Main.o
