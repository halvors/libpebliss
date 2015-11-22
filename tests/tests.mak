PWD=$(shell pwd)
OUTDIR = ../bin/
LIBPATH = ../../lib/libpebliss.a
NAME=$(shell basename $(PWD))
CXXFLAGS = -O2 -Wall -I../../pe_lib -I../

ifdef PE_DEBUG
CXXFLAGS  += -g -O0
endif

all: $(NAME)

clean:
	rm -f $(NAME) *.o
	rm -f $(OUTDIR)$(NAME)

$(NAME): main.o
	$(CXX) -Wall $^ -lpebliss -L../../lib -o ${OUTDIR}$(NAME)

main.o: $(LIBPATH)

