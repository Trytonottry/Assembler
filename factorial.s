; Factorial Calculator
; Calculates factorial of 5 (5!) and prints result as ASCII
section .data
    result db 'Factorial: 000000', 0xa  ; buffer for output
    result_len equ $ - result           ; length of output buffer

section .text
    global _start

_start:
    mov rcx, 5          ; calculate factorial of 5
    mov rax, 1          ; initialize result

factorial_loop:
    cmp rcx, 0          ; check if counter is 0
    je convert_to_ascii ; if yes, convert result to ASCII
    mul rcx             ; rax = rax * rcx
    dec rcx             ; decrement counter
    jmp factorial_loop

convert_to_ascii:
    mov rbx, result + 15 ; point to end of number buffer
    mov rcx, 10          ; divisor for conversion
convert_loop:
    xor rdx, rdx         ; clear remainder
    div rcx              ; divide rax by 10
    add dl, '0'          ; convert remainder to ASCII
    mov [rbx], dl        ; store ASCII digit
    dec rbx              ; move to previous position
    cmp rax, 0           ; check if quotient is 0
    jne convert_loop

    ; write syscall
    mov rax, 1           ; syscall number for write
    mov rdi, 1           ; file descriptor 1 (stdout)
    mov rsi, result      ; pointer to result
    mov rdx, result_len  ; length of result
    syscall

    ; exit syscall
    mov rax, 60          ; syscall number for exit
    xor rdi, rdi         ; status code 0
    syscall