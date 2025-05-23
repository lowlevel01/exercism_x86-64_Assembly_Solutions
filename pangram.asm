default rel

section .data
lookup: times 26 db 0

section .text
global is_pangram
is_pangram:
    lea rbx, [lookup]
    mov rcx, 0
.clear_loop:
    cmp rcx, 26
    je .clear_done
    mov byte [rbx + rcx], 0
    inc rcx
    jmp .clear_loop
.clear_done:


.loop:
    cmp byte [rdi], 0
    jz .check

    push rdi
    call is_lower
    pop rdi

    test rax, rax
    jnz .lower

    push rdi
    call is_upper
    pop rdi

    test rax, rax
    jnz .upper

    jmp .next
    
.lower:
    xor rax, rax
    mov al, byte [rdi]
    sub al, 'a'
    mov byte [rbx + rax], 1
    jmp .next
    
.upper:
    xor rax, rax
    mov al, byte [rdi]
    sub al, 'A'
    mov byte [rbx + rax], 1
    jmp .next

.next:
    inc rdi
    jmp .loop
    

.check:
    xor rcx, rcx
.check_loop:
    cmp rcx, 26
    jz .yes
    cmp byte [rbx+rcx], 0
    jz .no
    inc rcx
    jmp .check_loop
.yes:
    mov rax, 1
    ret
.no:
    mov rax,0
    ret

is_upper:
    cmp byte [rdi], 'A' 
    jl .no
    cmp byte [rdi], 'Z'
    jle .yes

.no:
    mov rax, 0
    ret
.yes:
    mov rax, 1
    ret

is_lower:
    cmp byte [rdi], 'a' 
    jl .no
    cmp byte [rdi], 'z'
    jle .yes

.no:
    mov rax, 0
    ret
.yes:
    mov rax, 1
    ret
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
