;; this one is insane tbh

section .text
global rows
rows:
    ; Provide your implementation here
    cmp rsi, 0
    je .zero


    mov rax, rsi
    inc rax
    mul rsi
    shr rax, 1
    push rax

    mov qword [rdi], 1
    mov r8, 1           ; current write position
    mov rcx, 1          ; current row number (next row to generate)

    cmp rsi, 1
    je .done
    
    
.row_loop:
    cmp rcx, rsi
    jge .done

    ; Start new row with 1
    mov qword [rdi + r8*8], 1
    inc r8

    ; Calculate start position of previous row
    ; Previous row is (rcx-1), so we need sum from 0 to (rcx-1)
    ; which is (rcx-1)*rcx/2
    mov rax, rcx
    dec rax
    mul rcx
    shr rax, 1
    mov rbx, rax        ; rbx = start position of previous row

    ; Generate middle elements (positions 1 to rcx-1 in current row)
    mov rdx, 1          ; position in current row

.middle_loop:
    cmp rdx, rcx        ; if position == row_number, we're done with middle
    jge .end_row

    ; Calculate positions in previous row to add
    ; We need element at (rdx-1) and element at (rdx) from previous row
    mov r9, rbx         ; start of previous row
    add r9, rdx         ; 
    dec r9              ; r9 = position of left parent
    mov r10, rbx
    add r10, rdx        ; r10 = position of right parent

    ; Add the two parent values
    mov r11, qword [rdi + r9*8]   ; left parent
    mov r12, qword [rdi + r10*8]  ; right parent
    add r11, r12
    mov qword [rdi + r8*8], r11   ; store sum

    inc r8              ; next write position
    inc rdx             ; next position in current row
    jmp .middle_loop

.end_row:
    ; End row with 1
    mov qword [rdi + r8*8], 1
    inc r8
    inc rcx             ; next row number
    jmp .row_loop    
    
.done:
    pop rax
    ret

.zero:
    mov qword [rdi], 0
    xor rax, rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
