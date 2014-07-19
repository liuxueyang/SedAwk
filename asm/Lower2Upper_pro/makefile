Lower2Upper_pro: Lower2Upper_pro.o
	ld -o Lower2Upper_pro Lower2Upper_pro.o
Lower2Upper_pro.o: Lower2Upper_pro.asm
	nasm -f elf -g -F stabs Lower2Upper_pro.asm
