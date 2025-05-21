default rel


section .text
global nucleotide_counts

nucleotide_counts:
    ;; Zeroing out the output array 
    xor rax, rax
    mov rcx, 4

    lea r8, [rsi]
.init_loop:
    mov [r8], rax
    add r8, 8
    loop .init_loop

;; Looping over the string and keeping count of every element
    lea rbx, [rsi]  
.loop:
    cmp byte [rdi], 0
    jz .finish
.A:
    cmp byte [rdi], 'A'
    jnz .C
    inc qword [rbx]
    inc rdi
    jmp .loop
    
.C:
    cmp byte [rdi], 'C'
    jnz .G
    inc qword [rbx + 8]
    inc rdi
    jmp .loop
.G:
    cmp byte [rdi], 'G'
    jnz .T
    inc qword [rbx + 16]
    inc rdi
    jmp .loop
.T:
    cmp byte [rdi], 'T'
    jnz .error ;; If character is invalid, jump to error.
    inc qword [rbx + 24]
    inc rdi
    jmp .loop
    
.error:
    mov qword [rbx], -1
    mov qword [rbx + 8], -1
    mov qword [rbx + 16], -1
    mov qword [rbx + 24], -1
    lea rax, [rbx]
    ret
    
.finish:
    lea rax, [rsi]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
