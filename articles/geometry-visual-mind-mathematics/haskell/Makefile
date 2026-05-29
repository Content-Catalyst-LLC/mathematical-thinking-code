GHC ?= ghc

.PHONY: all run clean

all: geometry_visual_mind_demo

geometry_visual_mind_demo: Main.hs
	$(GHC) -O2 Main.hs -o geometry_visual_mind_demo

run: geometry_visual_mind_demo
	mkdir -p ../outputs/tables
	./geometry_visual_mind_demo

clean:
	rm -f geometry_visual_mind_demo Main.hi Main.o
