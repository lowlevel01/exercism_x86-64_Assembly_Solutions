default rel

section .data
first: db "One for ", 0
no_name: db "you", 0
last: db ", one for me.", 0

section .text
global two_fer
two_fer:
    mov rbx, rdi
    mov rdi, rsi
    lea rsi, [first]
    call copy
    mov rsi, rbx
    test rsi, rsi ;; Check if name is provided
    jnz write_name
    lea rsi, [no_name]
    
write_name:
    call copy
    lea rsi, [last]
    call copy
    ret
    
    
copy:
.copy_loop:
    mov al, byte [rsi]
    mov byte [rdi], al
    inc rsi
    inc rdi
    test al, al
    jnz .copy_loop
    dec rsi ;; decremented to point at the nullbyte. The middle part is written starting from there.
    dec rdi
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
