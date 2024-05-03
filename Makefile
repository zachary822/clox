# Define compiler
CC=gcc

# Define any compile-time flags
CFLAGS=-Wall -g

# Define any directories containing header files
INCLUDES=

# Define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
LFLAGS=

# Define any libraries to link into executable
LIBS=-lreadline

# Define the C source files
SRCS=$(wildcard *.c)

# Define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#   For each word in 'name' replace 'string1' with 'string2'
OBJS=$(SRCS:.c=.o)

# Define the executable file 
MAIN=clox

#
# The following part of the Makefile is generic; it can be used to 
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#

.PHONY: depend clean

all:    $(MAIN)
	@echo  clox has been compiled

$(MAIN): $(OBJS) 
	$(CC) $(CFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS) $(LFLAGS) $(LIBS)

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of 
# the rule(a .c file) and $@: the name of the target of the rule (a .o file)
# (see the gnu make manual section about automatic variables)
.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $<  -o $@

clean:
	$(RM) *.o $(MAIN)

depend: $(SRCS)
	makedepend $(INCLUDES) $^

# DO NOT DELETE THIS LINE -- make depend needs it
