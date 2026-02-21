# scrapfetch-asm
Version of [scrapfetch](https://github.com/amodi444/scrapfetch) that was rewritten on NASM(x86_64 architecture)
## Building
### Dependencies
To build scrapfetch-asm, you need [NASM](https://nasm.us/)

### Command for installing NASM on Arch Linux:
```
pacman -S nasm
```
After installing dependencies, clone repo:
```
git clone https://github.com/amodi444/scrapfetch-asm.git
cd scrapfetch-asm
```
Now build it:
```
make
./scrapfetch-asm
```
