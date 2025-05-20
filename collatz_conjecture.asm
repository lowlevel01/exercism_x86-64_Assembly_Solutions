section .text
global steps
steps:
    cmp edi, 1  ; check if edi <= 0
    jl .error
    xor rax, rax
.parity:
    cmp rdi, 1
    jz .final
    inc rax
    test rdi, 1
    jnz .odd
.even:
    shr rdi, 1 ; rdi = rdi / 2
    jmp .parity
.odd:
    lea rdi, [rdi + rdi*2 +1] ; rdi = 3*rdi + 1
    jmp .parity

.error:
    mov rax, -1
.final:
    ret



%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
