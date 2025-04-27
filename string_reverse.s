; String Reverse Program
; Reverses a predefined string and prints it
section .data
    original db 'Hello, Assembly!', 0xa  ; original string
    original_len equ $ - original       ; length of original string
    reversed times original_len db 0     ; buffer for reversed string

section .text
    global _start

_start:
    ; Reverse the string
    mov rsi, original           ; source string pointer
    mov rdi, reversed           ; destination buffer pointer
    mov rcx, original_len - 1   ; length excluding newline
    add rsi, rcx                ; point to end of source (before newline)
    inc rdi                     ; start from beginning of destination

reverse_loop:
    mov al, [rsi]               ; get character from source
    mov [rdi], al               ; store in destination
    dec rsi                     ; move backward in source
    inc rdi                     ; move forward in destination
    loop reverse_loop

    ; Copy newline to end
    mov byte [rdi], 0xa         ; add newline to reversed string

    ; write syscall
    mov rax, 1                  ; syscall number for write
    mov rdi, 1                  ; file descriptor 1 (stdout)
    mov rsi, reversed           ; pointer to reversed string
    mov rdx, original_len       ; length of reversed string
    syscall

    ; exit syscall
    mov rax, 60                 ; syscall number for exit
    xor rdi, rdi                ; status code 0
    syscall