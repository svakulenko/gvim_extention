#path to include
IDIR = ../include

CC = g++

#what dir we include
CFLAGS = -I$(IDIR)

#what flags
GCCFLAGS = -Wall

#sources dir
ODIR = src

EXEAPPLICATION = applicaton

#????
LDIR = ../lib

#path to lib directory 
#LDFLAGS = -L/path/to/libdir 
LDFLAGS = 

#static libs
#LIBS= -lmath
LIBS = 

#include headers
#_DEPS = hellomake.h
_DEPS =
SOURCES = main.cpp
#SOURCES += hellomake.cpp

DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

OBJECTS = $(SOURCES:.cpp=.o)

OBJ = $(patsubst %,$(ODIR)/%,$(OBJECTS))

$(ODIR)/%.o: %.cpp $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) $(GCCFLAGS) 

$(EXEAPPLICATION): $(OBJ)
	g++ -o $@ $^ $(CFLAGS$) $(GCCFLAGS) $(LDFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
