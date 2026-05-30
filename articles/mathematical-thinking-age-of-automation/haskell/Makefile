GHC ?= ghc

.PHONY: all run clean

all: automation_demo

automation_demo: Main.hs
	$(GHC) -O2 Main.hs -o automation_demo

run: automation_demo
	mkdir -p ../outputs/tables
	./automation_demo

clean:
	rm -f automation_demo Main.hi Main.o
