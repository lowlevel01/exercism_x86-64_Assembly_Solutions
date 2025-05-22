section .text
global allergic_to
allergic_to:
    cmp rsi, 0
    jz .false
    mov cl, dil
    mov rax, 1
    shl rax, cl
    test rax, rsi
    jz .false
    mov rax, 1
    ret
.false:
    mov rax, 0
    ret

global list
list:
    ; RDI : score
    ; RSI : pointer to struct
    ;     struct item_list {
    ;        int size;
    ;        enum item items[MAX_ITEMS];
    ;     };

    xor rcx, rcx
    xor r8, r8
    lea rbx, [rsi + 4]   ; items[] array (after 4-byte size)

    push rsi ; save pointer to struct 
.loop:
    cmp rcx, 7
    jg .finished

    push rdi ; save score value

    ; call allergic_to(ecx, score)
    mov rsi, rdi ; move score to 2nd paramter
    mov rdi, rcx ; allergen index is 1st parameter
    call allergic_to
    
    pop rdi ; restore score value
    
    test rax, rax
    jz .next

     mov dword [rbx], ecx ; store allergen in array
     add rbx, 4 ; move pointer to next element in the array
     inc r8
.next:
    inc rcx
    jmp .loop

    
.finished:
    pop rsi
    mov dword [rsi], r8d  ; list->size = count
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
