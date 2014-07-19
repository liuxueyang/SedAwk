; This program does the same thing as Lower2Upper.asm
; The only progress is that it reads a buffer of characters
; each time.
; makefile is: 
;
;Lower2Upper_pro: Lower2Upper_pro.o
;	ld -o Lower2Upper_pro Lower2Upper_pro.o
;Lower2Upper_pro.o: Lower2Upper_pro.asm
;	nasm -f elf -g -F stabs Lower2Upper_pro.asm

SECTION .bss
	BUFFLEN: equ 1024 ; in fact the colon here can be omitted ;-)
	Buff: resb BUFFLEN

SECTION .data

SECTION .text
	global _start
_start:
	nop
read:
	mov eax, 3 ; system read
	mov ebx, 0 ; standard input
	mov ecx, Buff    
	mov edx, BUFFLEN 
	int 80h
	mov esi, eax 
	cmp eax, 0
	je Exit

	mov ecx, esi 
	mov ebp, Buff ; Buff addr 
	dec ebp ; on pos before Buff, in order to use ecx properly

Scan:
	; transfer chars 
	cmp byte [ebp+ecx], 61h
	jb Next

	cmp byte [ebp+ecx], 7ah
	ja Next 

	; the current characters is a lowercase character 
	sub byte [ebp+ecx], 20h

Next:
	dec ecx 
	jnz Scan ; process former character  in Buff 

	; Buff exhausted, it is time to write the Buffer to output 
Write:
	mov eax, 4
	mov ebx, 1
	mov ecx, Buff 
	mov edx, esi 
	int 80h 

	jmp read ; get next Buff

Exit:
	mov eax, 1
	mov ebx, 0
	int 80h

; The Following is the running result:

;~/Hack/SedAwk/asm/Lower2Upper_pro->cat in.txt
;Hello, I am liuxueyang.
;Are you sad?
;~/Hack/SedAwk/asm/Lower2Upper_pro->./Lower2Upper_pro < in.txt > out.txt
;~/Hack/SedAwk/asm/Lower2Upper_pro->cat out.txt
;HELLO, I AM LIUXUEYANG.
;ARE YOU SAD?
