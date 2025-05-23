section .text
global is_armstrong_number
is_armstrong_number:


    call number_of_digits
    mov rsi, rax

    push rdi
    mov rax, rdi
    xor rcx, rcx
.loop:
    cmp rax, 0
    jz .check
    xor rdx, rdx
    mov rbx, 10
    div rbx
    mov rdi, rdx ; remainder is in rdx
    push rax
    call power
    add rcx, rax
    pop rax
    jmp .loop
.check:
    pop rdi
    cmp rdi, rcx
    jz .yes
    xor rax, rax
    ret
.yes:
    mov rax, 1
    ret

number_of_digits:
    push rcx
    push rdx
    push rbx
    mov rax, rdi        ; copy input to rax
    xor rcx, rcx        ; digit counter
.count_loop:
    cmp rax, 0
    jz .count_done
    inc rcx
    xor rdx, rdx
    mov rbx, 10
    div rbx             ; rax = rax/10
    jmp .count_loop
.count_done:
    mov rax, rcx        ; return count in rax
    pop rbx
    pop rdx
    pop rcx
    ret
    
    
power:
    ; compute rdi^rsi
    push rcx
    push rdx
    mov rax, 1          ; result starts at 1
    mov rcx, rsi        ; loop counter = power
    cmp rcx, 0
    jz .power_done      
.power_loop:
    imul rax, rdi       ; multiply result by base
    dec rcx
    jnz .power_loop
.power_done:
    pop rdx
    pop rcx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
