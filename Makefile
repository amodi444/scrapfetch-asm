PREFIX ?= /usr/local

all: scrapfetch

scrapfetch: scrapfetch-asm.asm
	nasm -f elf64 scrapfetch-asm.asm
	gcc scrapfetch-asm.o -o scrapfetch-asm -no-pie

install: scrapfetch
	cp -r scrapfetch-asm $(PREFIX)/bin/

clean:
	rm -f scrapfetch-asm
	rm -f scrapfetch-asm.o