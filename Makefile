SINGULARITY_CACHEDIR=$(pwd)/build

all: build start

build: luatex.def
	singularity build --fakeroot luatex.sif luatex.def

start: luatex.sif
	singularity instance start luatex.sif luatex

stop: $(shell singularity instance list luatex)
	singularity instance stop luatex

clean: luatex.sif
	rm -f luatex.sif
