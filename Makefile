CACHEDIR=$(shell pwd)/build-tmp
TMPDIR=$(shell pwd)/build-cache

all: build start

build: luatex.def
	mkdir -p $(CACHEDIR)
	mkdir -p $(TMPDIR)
	SINGULARITY_CACHEDIR=$(CACHEDIR) SINGULARITY_TMPDIR=$(TMPDIR) singularity build --fakeroot luatex.sif luatex.def
	rm -rf $(CACHEDIR) $(TMPDIR)

start: luatex.sif
	singularity instance start luatex.sif luatex

stop: $(shell singularity instance list luatex)
	singularity instance stop luatex

clean: luatex.sif
	rm -f luatex.sif
	rm -rf $(CACHEDIR) $(TMPDIR)
