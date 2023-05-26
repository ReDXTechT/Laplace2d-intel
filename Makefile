CC=icc
LD=icc
CFLAGS=-O3 -qopenmp
LDFLAGS=-O3 -qopenmp 

all: exe 

exe: laplace2d.o jacobi.o
	$(LD) $(LDFLAGS) -o $@ $^ ${NVTXLIB} 

run: exe
	./exe

.PHONY: clean
clean:
	-rm -f *.o  core exe
.SUFFIXES: .c  .o
.c.o:
	$(CC) $(CFLAGS) -c -o $@ $< 
