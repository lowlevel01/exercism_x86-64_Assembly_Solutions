section .text
global square_of_sum
square_of_sum:
    xor rax, rax
.square_of_sum_:
    add rax, rdi
    dec rdi
    jnz .square_of_sum_
    mov rdi, rax
    mul rdi
    ret

global sum_of_squares
sum_of_squares:
    push rbx
    xor rbx, rbx
.sum_of_squares_:

    mov rax, rdi
    mul rdi
    add rbx, rax
    dec rdi
    jnz .sum_of_squares_
    mov rax, rbx
    pop rbx
    ret

global difference_of_squares
difference_of_squares:
    push rdi
    call sum_of_squares
    mov rbx, rax

    pop rdi
    call square_of_sum

    sub rax, rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
