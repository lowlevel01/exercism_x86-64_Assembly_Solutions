default rel


section .data
whatever  db "Whatever.",0
sure  db "Sure.",0
whoa  db "Whoa, chill out!",0
calm  db "Calm down, I know what I'm doing!",0
fine  db "Fine. Be that way!",0


section .text
global response
response:
    push rdi
    call is_empty
    pop rdi
    test rax, rax
    jnz .fine

    push rdi
    call is_question
    pop rdi
    mov rcx, rax
    
    push rdi
    call is_all_capital
    pop rdi
    mov rbx, rax

    
    push rdi
    call contains_letter
    pop rdi


    ; rcx : result of is_question
    ; rbx : result of is_all_capital
    ; rax : result of contains_letter
    
    test rax, rax
    jz .no_letters

    test rcx, rbx
    jnz .calm

    test rcx, rcx
    jnz .sure

    test rbx, rbx
    jnz .whoa
    
.no_letters:
    test rcx, rcx
    jnz .sure


.whatever:
    lea rax, [whatever]
    ret
.whoa:
    lea rax, [whoa]
    ret

.sure:
    lea rax, [sure]
    ret
.calm:
    lea rax, [calm]
    ret
    
.fine:
    lea rax, [fine]
    ret

is_empty:
.loop:
    mov al, [rdi]
    cmp al, 0
    je .yes
    cmp al, ' '
    je .next
    cmp al, 9      ; '\t'
    je .next
    cmp al, 10     ; '\n'
    je .next
    cmp al, 13     ; '\r'
    je .next
    mov rax, 0
    ret
.next:
    inc rdi
    jmp .loop
.yes:
    mov rax, 1
    ret


is_question:
    mov rsi, rdi
.find_end:
    mov al, [rsi]
    cmp al, 0
    je .rewind
    inc rsi
    jmp .find_end
.rewind:
    dec rsi
.skip_spaces:
    cmp byte [rsi], ' '
    je .rewind_more
    cmp byte [rsi], 9 ; '\t'
    je .rewind_more
    cmp byte [rsi], 10 ; '\n'
    je .rewind_more
    cmp byte [rsi], 13 ; '\r'
    je .rewind_more
    jmp .check
.rewind_more:
    dec rsi
    jmp .skip_spaces
.check:
    cmp byte [rsi], '?'
    jne .no
    mov rax, 1
    ret
.no:
    xor rax, rax
    ret

contains_letter:
.loop:
    cmp byte [rdi], 0
    jz .no
    cmp byte [rdi], 'a'
    jge .check_z
    cmp byte [rdi], 'A'
    jge .check_cap_z
.check_z:
    cmp byte [rdi], 'z'
    jle .yes
    jmp .next

.check_cap_z:
    cmp byte [rdi], 'Z'
    jle .yes
    jmp .next
.next:
    inc rdi
    jmp .loop

.yes:
    mov rax, 1
    ret
.no:
    mov rax, 0
    ret

is_all_capital:
    xor rax, rax        ; return value
    xor rbx, rbx        ; letter seen flag
.loop:
    mov al, [rdi]
    cmp al, 0
    je .done
    cmp al, 'a'
    jl .check_upper
    cmp al, 'z'
    jle .no             ; found lowercase → fail

.check_upper:
    cmp al, 'A'
    jl .next
    cmp al, 'Z'
    jg .next
    mov bl, 1           ; saw uppercase letter
.next:
    inc rdi
    jmp .loop
.done:
    cmp bl, 1       ; check if seen a capital letter
    jne .no             ; no letter → fail
    mov rax, 1
    ret
.no:
    xor rax, rax
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
