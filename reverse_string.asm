section .text
global reverse
reverse:
    push rbx
    push rdi
    xor rcx, rcx

;; Calculate the length of the string
.length:
    cmp byte [rdi+rcx], 0
    jz .reverse
    inc rcx
    jmp .length
    

;; Swapping the string in place with two pointers

.reverse:
    lea rbx, [rdi + rcx - 1]

.swap_loop:
    cmp rdi, rbx
    jge .final

    mov al, [rdi]
    mov dl, [rbx]
    mov [rdi], dl
    mov [rbx], al
    inc rdi
    dec rbx
    jmp .swap_loop

.final:
    pop rax ;; I pop into rax because it's the return value and it is the value of RDI in the beginning which points to the beginning of the string
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
