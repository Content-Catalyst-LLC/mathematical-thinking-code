GHC ?= ghc

.PHONY: all run clean

all: ai_discovery_demo

ai_discovery_demo: Main.hs
	$(GHC) -O2 Main.hs -o ai_discovery_demo

run: ai_discovery_demo
	mkdir -p ../outputs/tables
	./ai_discovery_demo

clean:
	rm -f ai_discovery_demo Main.hi Main.o
