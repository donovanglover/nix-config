CC=gcc
CFLAGS=-O2

LIBS=-lX11
OBJ=main.o xeb_handler.o

.PHONY: all clean
all: xeventbind

xeventbind: $(OBJ)
	$(CC) -o $@ $^ $(LIBS) $(CFLAGS)

%.o: %.c
	$(CC) -c -o $@ $< $(CLAGS)

clean:
	rm -f xeventbind *.o
