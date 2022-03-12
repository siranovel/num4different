CC = gcc
OBJS = CNum4Diff.o

NUM4DIFFSO = libnum4diff.so

.c.o:
	${CC} -fPIC    -Wall -c $< 

all: ${NUM4DIFFSO}

${NUM4DIFFSO}: ${OBJS}
	${CC}  -shared ${JAVA_LDFLAGS} -o $@ $^

clean:
	rm *.o
######################################
CNum4Diff.o: CNum4Diff.c CNum4Diff.h
