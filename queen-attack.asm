section .text
global can_create
can_create:
    cmp rdi, 7
    jg .no
    cmp rsi, 7
    jg .no
    mov rax, 1
    ret
.no:
    mov rax, 0
    ret

global can_attack
can_attack:
    ; the can attack attack each other if they're on the same row/column/diagonal
    ; white : RDI, RSI
    ; black : RDX, RCX
    ; They're on the same diagonal if the difference between their coords is the same 
    ; for both X & Y
    sub rdi, rdx
    jz .yes
    sub rsi, rcx
    jz .yes

    ;; comparing absolute values, could've computed the sum and see if it's 0 for 
    ;; the +,- and -,+ 
    test rdi, rdi
    jns .negative_check
    neg rdi
.negative_check:
    test rsi, rsi
    jns .diagonal_check
    neg rsi
.diagonal_check:
    cmp rdi, rsi ; same diagonal check
    jz .yes

    mov rax, 0
    ret
    
.yes:
    mov rax, 1
    ret

    

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
