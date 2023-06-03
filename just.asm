; ----------------------------------
; CTF          - Reverse Engineering
; by: @k1k9    - 2021-04-11
; ----------------------------------

section .bss
    input resb 40
    input_length equ $-input

section .data
    error_message db "Wrong flag!", 0x0A, 0x00
    error_message_length equ $-error_message
    success_message db "Success this is the flag!", 0x0A, 0x00
    success_message_length equ $-success_message

section .text
    global _start

_start:
    mov rax, 0x0
    mov rdi, 0x0
    mov rsi, input
    mov rdx, input_length - 1
    syscall
    jmp _easy_part

_return:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, error_message
    mov rdx, error_message_length
    syscall

    mov rax, 0x3C
    mov rdi, 0x0
    syscall 

_easy_part:
    ; compare 8 characters from input with ctfLearn{
    cmp byte [input], 0x63 ; c
    jne _return
    cmp byte [input + 1], 0x74 ;t
    jne _return
    cmp byte [input + 2], 0x66 ;f
    jne _return
    cmp byte [input + 3], 0x4C ; L
    jne _return
    cmp byte [input + 4], 0x65 ; e
    jne _return
    cmp byte [input + 5], 0x61 ; a
    jne _return
    cmp byte [input + 6], 0x72 ; r
    jne _return
    cmp byte [input + 7], 0x6E ; n
    jne _return
    cmp byte [input + 8], 0x7B ; {
    jne _return
    jmp _what_is_this

_what_is_this:
    ; t ^ h
    movzx rax, byte [input + 9]
    movzx rdi, byte [input + 10]
    xor rax, rdi
    cmp rax, 0x1c
    jne _return

    ; h ^ 1
    movzx rax, byte [input + 10]
    movzx rdi, byte [input + 11]
    xor rax, rdi
    cmp rax, 0x59
    jne _return

    ; 1 ^ s
    movzx rax, byte [input + 11]
    movzx rdi, byte [input + 12]
    xor rax, rdi
    cmp rax, 0x42
    jne _return

    ; s ^ _
    movzx rax, byte [input + 12]
    movzx rdi, byte [input + 13]
    xor rax, rdi
    cmp rax, 0x2c
    jne _return

    jmp _what_is_this_2

_what_is_this_2:
    ; _ ^ w
    movzx rax, byte [input + 13]
    movzx rdi, byte [input + 14]
    xor rax, rdi
    cmp rax, 0x28
    jne _return

    ; w ^ 4
    movzx rax, byte [input + 14]
    movzx rdi, byte [input + 15]
    xor rax, rdi
    cmp rax, 0x43
    jne _return

    ; 4 ^ s
    movzx rax, byte [input + 15]
    movzx rdi, byte [input + 16]
    xor rax, rdi
    cmp rax, 0x47
    jne _return

    ; s ^ _
    movzx rax, byte [input + 16]
    movzx rdi, byte [input + 17]
    xor rax, rdi
    cmp rax, 0x2c
    jne _return

    jmp _what_is_this_3
    
_what_is_this_3:
    ; _ ^ 3
    movzx rax, byte [input + 17]
    movzx rdi, byte [input + 18]
    xor rax, rdi
    cmp rax, 0x6c
    jne _return

    ; 3 ^ a
    movzx rax, byte [input + 18]
    movzx rdi, byte [input + 19]
    xor rax, rdi
    cmp rax, 0x52
    jne _return

    ; a ^ s
    movzx rax, byte [input + 19]
    movzx rdi, byte [input + 20]
    xor rax, rdi
    cmp rax, 0x12
    jne _return

    ; s ^ y
    movzx rax, byte [input + 20]
    movzx rdi, byte [input + 21]
    xor rax, rdi
    cmp rax, 0xa
    jne _return

    jmp _beautifull

_beautifull:
    ; y ^ }
    movzx rax, byte [input + 21]
    movzx rdi, byte [input + 22]
    xor rax, rdi
    cmp rax, 0x4
    jne _return
    jmp _ending

_ending:
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, success_message
    mov rdx, success_message_length
    syscall

    mov rax, 0x3C
    mov rdi, 0x0
    syscall