Lower2Upper: Lower2Upper.o
	ld -o Lower2Upper Lower2Upper.o
Lower2Upper.o: Lower2Upper.asm
	nasm -f elf -g -F stabs Lower2Upper.asm
