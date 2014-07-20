; This program transfer binary file to hexformat
; makefile is:

;hexdump2: hexdump2.o
;	ld -o hexdump2 hexdump2.o
;hexdump2.o: hexdump2.asm
;	nasm -f elf -g -F stabs hexdump2.asm

SECTION .bss
	BUFFLEN equ 16
	Buff: resb BUFFLEN

SECTION .data
	HexConStr: db "00000000000000000000000000000000",10
	HEXCONLEN equ $-HexConStr
	Digits: db "0123456789ABCDEF"

SECTION .text
	global _start
_start:
	nop
	
	; output HexConstr 
	mov eax, 4
	mov ebx, 1
	mov ecx, HexConStr 
	mov edx, HEXCONLEN 
	int 80h

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
	mov edi, HexConStr ; Str addr 
	xor ecx, ecx 		; # of processed chars 

Scan:
	xor eax, eax 

	; get a byte from input 
	mov al, byte [esi+ecx]
	mov ebx, eax 		; backup it

	; least significant 4 bits
	and eax, 0fh
	mov al, byte [Digits+eax]
	mov byte [HexConStr+ecx*2+1], al 		; write to HexStr

	; most significant 4 bits
	shr bl, 4
	mov bl, byte [Digits+ebx]
	mov byte [HexConStr+ecx*2], bl 	; write to HexStr

	; get next character
	inc ecx
	cmp ecx, ebp 
	jna Scan 

	; write HexConStr to output
	mov eax, 4
	mov ebx, 1
	mov ecx, HexConStr 
	mov edx, HEXCONLEN 
	int 80h

	jmp Read 								; get next Buff

	; work done
Exit:
	mov eax, 1
	mov ebx, 0
	int 80h
