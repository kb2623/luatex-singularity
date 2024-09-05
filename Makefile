SINGULARITY_CACHEDIR=$(shell pwd)/build-tmp
SINGULARITY_TMPDIR=$(shell pwd)/build-cache

all: build start

build: luatex.def
	mkdir -p $(SINGULARITY_CACHEDIR)
	mkdir -p $(SINGULARITY_TMPDIR)
	SINGULARITY_CACHEDIR=$(SINGULARITY_CACHEDIR) SINGULARITY_TMPDIR=$(SINGULARITY_TMPDIR) singularity build --fakeroot luatex.sif luatex.def
	rm -rf $(SINGULARITY_CACHEDIR) $(SINGULARITY_TMPDIR)

start: luatex.sif
	singularity instance start luatex.sif luatex

stop: $(shell singularity instance list luatex)
	singularity instance stop luatex

clean: luatex.sif
	rm -f luatex.sif
