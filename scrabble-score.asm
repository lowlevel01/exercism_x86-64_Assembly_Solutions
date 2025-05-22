default rel

section .data

letters:
dq 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10


section .text
global score
score:
    lea rbx, [letters]
    xor rcx, rcx
    xor rax, rax
.loop:
    cmp byte [rdi], 0
    jz .finished
    mov al, byte [rdi]
    cmp al, 'Z'
    jle .uppercase
    sub al, 'a' ;; index is computed based on the difference between 'A' or 'a' and the character
    add rcx, qword [rbx + rax*8]
    jmp .next
.uppercase:
    sub al, 'A'
    add rcx, qword [rbx + rax*8]
.next:
    inc rdi
    jmp .loop
.finished:
    mov rax, rcx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
