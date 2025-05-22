default rel

section .data
lookup:
    times 26 db 0


section .text
global is_isogram
is_isogram:
    ; fill lookup table with 0's
    push rdi
    lea rdi, [lookup]
    mov rcx, 26
    xor rax, rax
    rep stosb ;; put value in al ( = 0) into RDI . Increment RDI . Do that RCX times

    pop rdi
    xor rax, rax
    lea rbx, [lookup]
.loop:
    mov al, byte [rdi]
    test al, al
    je .yes

    ; check for uppercase
    cmp al, 'A'
    jl .next
    cmp al, 'Z'
    jle .uppercase

    ; check for lowercase
    cmp al, 'a'
    jl .next
    cmp al, 'z'
    jg .next
    
    ; process lowercase
    sub al, 'a'
    cmp byte [rbx+rax], 0
    jne .no
    mov byte [rbx+rax], 1
    jmp .next
    
.uppercase:
    sub al, 'A'
    cmp byte [rbx+rax], 0
    jne .no
    mov byte [rbx+rax], 1
.next:
    inc rdi
    jmp .loop
.no:
    mov rax, 0
    ret
.yes:
    mov rax, 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
