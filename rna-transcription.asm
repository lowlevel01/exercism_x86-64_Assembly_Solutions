default rel

section .text
global to_rna
to_rna:
.loop:
    mov al, byte [rdi]
    test al, al
    jz .return

    cmp al, 'G'
    je .G
    cmp al, 'C'
    je .C
    cmp al, 'T'
    je .T
    cmp al, 'A'
    je .A
    jmp .next

.G:
    mov byte [rsi], 'C'
    jmp .next

.C:
    mov byte [rsi], 'G'
    jmp .next

.T:
    mov byte [rsi], 'A'
    jmp .next

.A:
    mov byte [rsi], 'U'

.next:
    inc rdi
    inc rsi
    jmp .loop
.return:
    mov byte [rsi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
