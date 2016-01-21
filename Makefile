TARGET=nautilus_ext.so
OBJECTS=plugin.o

LIBDIR=/usr/lib
WFLAGS=-Wall -pedantic -Wmissing-prototypes
CFLAGS= $(WFLAGS) -fPIC -g \
	$(shell pkg-config --cflags libnautilus-extension gtk+-3.0)

LDFLAGS=-shared \
	$(shell pkg-config --libs libnautilus-extension gtk+-3.0)

all: $(TARGET)

$(TARGET): $(OBJECTS)
		gcc $(LDFLAGS) $(OBJECTS) -o $(TARGET)
		chmod -x $(TARGET)

install: all
	mkdir -p $(LIBDIR)/nautilus/extensions-3.0
	cp $(TARGET) $(LIBDIR)/nautilus/extensions-3.0/

plugin.o: plugin.c
	gcc -c $(CFLAGS) plugin.c -o plugin.o

clean:
	rm -f $(OBJECTS) $(TARGET)
