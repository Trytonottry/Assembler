; Simple Hello World program
; Prints "Hello, World!" to stdout
section .data
    message db 'Hello, World!', 0xa  ; message with newline
    message_len equ $ - message      ; length of message

section .text
    global _start

_start:
    ; write syscall (sys_write)
    mov rax, 1          ; syscall number for write
    mov rdi, 1          ; file descriptor 1 (stdout)
    mov rsi, message    ; pointer to message
    mov rdx, message_len; message length
    syscall

    ; exit syscall (sys_exit)
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; status code 0
    syscall