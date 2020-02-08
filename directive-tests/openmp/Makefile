FC=gfortran
FOPTS=-fopenmp
file=parallelSections
file=parallelSingleDepend1
file=parallelLoop1

lc=ftn
lopts=$(FOPTS)


all: build

build:
	$(lc) $(lopts) $(file).f90

test:
	./a.out
