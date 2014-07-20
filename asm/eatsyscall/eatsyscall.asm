; This is a "Hello-world" program
; makefile is:
; 
;eatsyscall: eatsyscall.o
;	ld -o eatsyscall eatsyscall.o
;eatsyscall.o: eatsyscall.asm
;	nasm -f elf -g -F stabs eatsyscall.asm

SECTION .data
	EatMsg: db "00000000000000000000000000000000", 10
	EatLen equ $-EatMsg

SECTION .bss

SECTION .text
	global _start
_start:
	nop
	mov eax, 4 				; system write
	mov ebx, 1 				; standard ouput
	mov ecx, EatMsg
	mov edx, EatLen
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

; The Following is the result:

;~/Hack/SedAwk/asm/eatsyscall->./eatsyscall 
;Eat at Liu's
