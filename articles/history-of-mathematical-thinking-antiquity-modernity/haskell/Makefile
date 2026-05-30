GHC ?= ghc

.PHONY: all run clean

all: history_of_mathematical_thinking_demo

history_of_mathematical_thinking_demo: Main.hs
	$(GHC) -O2 Main.hs -o history_of_mathematical_thinking_demo

run: history_of_mathematical_thinking_demo
	mkdir -p ../outputs/tables
	./history_of_mathematical_thinking_demo

clean:
	rm -f history_of_mathematical_thinking_demo Main.hi Main.o
