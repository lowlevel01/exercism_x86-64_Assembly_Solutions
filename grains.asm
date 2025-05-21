section .text
global square
square:
    cmp rdi, 0
    jle .error
    cmp rdi, 64
    jg .error
    mov rax, 1
    mov cl, dil 
    dec cl ;; grains = 2^(n-1)
    shl rax, cl ;; cl is the only register accepted in the right side of shl
    ret
    
.error:
    xor rax, rax
    ret

global total
total:
    mov rax, -1 ;; 2^0 + 2^1 + ... + 2^63 = 2^64 - 1 which is -1
    ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
