

section .text
global square_root


;; Using Binary Seach


square_root:
    cmp rdi, 0
    mov rcx, 0
    jz .return
    mov rcx, 1
.loop:
    mov rax, rcx
    mul rcx

    cmp rax, rdi
    jz .return ;;; they're equal
    jg .more ;;; rax > rdi
.less:
    mov rbx, rcx
    shl rcx, 1 ;; rcx = 2*rcx
    jmp .loop
.more:
    sub rcx, rbx
    shr rcx, 1  ;;;;  rcx = rbx + (rcx-rbx) / 2
    add rcx, rbx
    jmp .loop
.return:
    mov rax, rcx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
