; This program turns lowercase character to uppercase
; character, read one character from file each time
; makefile is:
;
;Lower2Upper: Lower2Upper.o
;	ld -o Lower2Upper Lower2Upper.o
;Lower2Upper.o: Lower2Upper.asm
;	nasm -f elf -g -F stabs Lower2Upper.asm

SECTION .bss
	Buff resb 1

SECTION .data

SECTION .text
	global _start
_start:
	nop
Read:
	mov eax, 3 ; system read
	mov ebx, 0 ; standard input
	mov ecx, Buff
	mov edx, 1
	int 80h
	cmp eax, 0
	je Exit ; EOF, file exhausted

	; do char transfer
	cmp byte [Buff], 61h ; less than character 'a'
	jb Write

	cmp byte [Buff], 7ah ; greater than character 'z'
	ja Write

	; the current character is a lowercase character
	; we can transfer it to uppercase 
	sub byte [Buff], 20h

Write:
	mov eax, 4 ; system Write
	mov ebx, 1 ; standard output
	mov ecx, Buff
	mov edx, 1
	int 80h 
	jmp Read ; read next character

Exit:
	mov eax, 1
	mov ebx, 0
	int 80h

; The Following is the result:

;~/Hack/SedAwk/asm/Lower2Upper->cat in.txt
;Hello, I am liuxueyang.
;Are you sad?
;~/Hack/SedAwk/asm/Lower2Upper->./Lower2Upper < in.txt > out.txt
;~/Hack/SedAwk/asm/Lower2Upper->cat out.txt
;HELLO, I AM LIUXUEYANG.
;ARE YOU SAD?
