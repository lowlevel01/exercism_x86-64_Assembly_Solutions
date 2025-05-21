section .text

;; a struct containing values of all sides is passed in argument by VALUE !
;; so it is fetched from the stack
;; [rsp] contains the return address
;; [rsp+8] , [rsp+16] and [rsp+24] contain the values of the elements of the struct


global is_equilateral
is_equilateral:
    movsd xmm0, [rsp+8]
    movsd xmm1, [rsp+16]
    movsd xmm2, [rsp+24]
    call is_triangle
    test rax, rax
    jz no
    comisd xmm0, xmm1
    jnz no
    comisd xmm0, xmm2
    jnz no
    jmp yes ;; to reach this jump => xmm0 = xmm1 = xmm2
    ret

global is_isosceles
is_isosceles:
    movsd xmm0, [rsp+8]
    movsd xmm1, [rsp+16]
    movsd xmm2, [rsp+24]
    call is_triangle
    test rax, rax
    jz no
    comisd xmm0, xmm1
    jz yes
    comisd xmm0, xmm2
    jz yes
    comisd xmm1, xmm2
    jz yes
    jmp no ;; to reach this jump => at least two of xmm0, xmm1 and xmm2 must be equal
    ret

global is_scalene
is_scalene:
    movsd xmm0, [rsp+8]
    movsd xmm1, [rsp+16]
    movsd xmm2, [rsp+24]
    call is_triangle
    test rax, rax
    jz no
    comisd xmm0, xmm1
    jz no
    comisd xmm0, xmm2
    jz no
    comisd xmm1, xmm2
    jz no
    jmp yes ;; to reach this jump => all xmm0, xmm1 and xmm2 should be different
    ret

;; This functions verifies the triangle inequalities
is_triangle:
    pxor xmm3, xmm3
    comisd xmm0, xmm3
    jbe no
    comisd xmm1, xmm3
    jbe no
    comisd xmm2, xmm3
    jbe no
    movsd xmm3, xmm0
    addsd xmm3, xmm1
    comisd xmm3, xmm2
    jbe no
    movsd xmm3, xmm0
    addsd xmm3, xmm2
    comisd xmm3, xmm1
    jbe no
    movsd xmm3, xmm1
    addsd xmm3, xmm2
    comisd xmm3, xmm0
    jbe no
    jmp yes


yes:
    mov rax, 1
    ret
no:
    xor rax, rax
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
