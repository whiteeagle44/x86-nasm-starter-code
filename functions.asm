section	.text
global _func, func		; '_func' for compatiility with NASM for Windows

_func:
func:
	; subroutine prologue
	push ebp			; save caller's value of ebp
	mov	ebp, esp		; overwrite ebp with the value of stack pointer
	push ebx			; save callee-save register
	mov	eax, DWORD [ebp+8] ; save address of *a (param 1) to rax

	; subroutine body
replace_loop:
	mov bl, [eax]  		; move value at address eax into 8bit register bl
	cmp bl, 0			; check if reached end of string
	je exit_loop		; if yes, go to exit_loop
	cmp bl, 'a'			; check if current letter is 'a'
	jne increment_loop	; if not, go to increment_loop
	mov	BYTE [eax], '*'	; it is 'a' so change it to '*'

increment_loop:
    inc eax				; increment address of string by one byte
    jmp replace_loop	; go to replace_loop

exit_loop:
	; subroutine epilogue
	xor	eax, eax		; eax = 0
	pop ebx				; bring back the caller's value of ebx from the stack
	pop	ebp				; deallocate local var: rbx
	ret