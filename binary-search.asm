section .text
global find
find:
    ; RDI : array
    ; RSI : array size
    ; RDX : number to find

    mov rbx, 0
    mov rcx, rsi
    dec rcx
.loop:
    ; calculating middle point in a way to avoid overflow
    cmp rbx, rcx
    jg .not_found
    mov r8, rbx
    mov r9, rcx
    sub r9, rbx
    shr r9, 1
    add r8, r9 ; r8 is middle point

    cmp dword [rdi+r8*4], edx
    je .equal

    cmp dword [rdi+r8*4], edx ; middle point is less than the number 
    jl .less

    dec r8
    mov rcx, r8
    jmp .next
.less:
    inc r8
    mov rbx, r8

.next:
    jmp .loop
    
.equal:
    mov rax, r8
    ret
.not_found:
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
