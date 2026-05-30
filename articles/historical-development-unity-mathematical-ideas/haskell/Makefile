GHC ?= ghc

.PHONY: all run clean

all: historical_development_unity_demo

historical_development_unity_demo: Main.hs
	$(GHC) -O2 Main.hs -o historical_development_unity_demo

run: historical_development_unity_demo
	mkdir -p ../outputs/tables
	./historical_development_unity_demo

clean:
	rm -f historical_development_unity_demo Main.hi Main.o
