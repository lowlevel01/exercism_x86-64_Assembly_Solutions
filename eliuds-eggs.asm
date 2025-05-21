section .text
global egg_count

;; Count the number of set bits in a number

egg_count:
    xor rax, rax
.loop:
    test rdi, rdi
    jz .finish
    test rdi, 1
    jz .lsb_not_set ;; skip incrementing if lsb is not set
    inc rax
.lsb_not_set:
    shr rdi, 1
    jmp .loop
.finish:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
