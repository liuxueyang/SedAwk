; This program transfer binary file to hexformat
; makefile is:

;hexdump1: hexdump1.o
;	ld -o hexdump1 hexdump1.o
;hexdump1.o: hexdump1.asm
;	nasm -f elf -g -F stabs hexdump1.asm

SECTION .bss
	BUFFLEN equ 16
	Buff: resb BUFFLEN

SECTION .data
	HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00", 10
	HEXLEN equ $-HexStr 
	Digits: db "0123456789ABCDEF"

SECTION .text
	global _start
_start:
	nop
Read:
	mov eax, 3
	mov ebx, 0
	mov ecx, Buff 
	mov edx, BUFFLEN 
	int 80h
	mov ebp, eax 		; # of chars read 
	cmp eax, 0
	je Exit

	; set address 
	mov esi, Buff 	; Buff addr 
	mov edi, HexStr ; Str addr 
	xor ecx, ecx 		; # of processed chars 

Scan:
	xor eax, eax 

	; multiply 3 and ecx 
	mov edx, ecx 
	shl edx, 1
	add edx, ecx 

	; get a byte from input 
	mov al, byte [esi+ecx]
	mov ebx, eax 		; backup it

	; least significant 4 bits
	and eax, 0fh
	mov al, byte [Digits+eax]
	mov byte [HexStr+edx+2], al 		; write to HexStr

	; most significant 4 bits
	shr ebx, 4
	mov bl, byte [Digits+ebx]
	mov byte [HexStr+edx+1], bl 	; write to HexStr

	; get next character
	inc ecx
	cmp ecx, ebp 
	jna Scan 

	; write HexStr to output
	mov eax, 4
	mov ebx, 1
	mov ecx, HexStr 
	mov edx, HEXLEN 
	int 80h
	jmp Read

	; work done
Exit:
	mov eax, 1
	mov ebx, 0
	int 80h
