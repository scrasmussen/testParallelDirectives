lc=ftn
# lc=ifort
# lc=pgfortran
file=forall_doconcurrent_comparison.f90
fopts=-O0

all: build

build:
	$(lc) $(file) -o runMe.exe $(fopts)

run:
	./runMe.exe

clean:
	rm -f *~ *.exe a.out *.o
