CC ?= cc
CFLAGS ?= -std=c11 -Wall -Wextra -Wpedantic -O2
PREFIX ?= $(HOME)/.local
PROGRAM := linecount
SOURCE := linecount.c
BINARY := build/$(PROGRAM)

.PHONY: all clean install uninstall

all: $(BINARY)

$(BINARY): $(SOURCE)
	mkdir -p build
	$(CC) $(CFLAGS) -o $@ $<

install: $(BINARY)
	install -d "$(PREFIX)/bin"
	install -m 0755 "$(BINARY)" "$(PREFIX)/bin/$(PROGRAM)"

uninstall:
	rm -f "$(PREFIX)/bin/$(PROGRAM)"

clean:
	rm -rf build
