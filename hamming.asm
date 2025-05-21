section .text
global distance
distance:
    xor rcx, rcx
    cmp byte [rdi], 0
    jnz .second
    inc rcx
.second:
    cmp byte [rsi], 0
    jnz .check
    inc rcx
.check:
    cmp rcx, 2 ;; both strings are nullbytes <===> empty ===> Hamming distance = 0
    jz .both_empty
    cmp rcx, 1 ;; only one is empty ====> error
    jz .error
    xor rcx, rcx ;; ====> zeroing rcx to be used for the next calculation
.loop:
    cmp byte [rdi], 0
    jz .length_check ;; when reaching a nullbyte, we check if the other one also reached an nullbyte ===> Same length
    cmp byte [rdi], 0
    jz .length_check
    mov al, byte [rsi]
    cmp al, byte [rdi]
    jz .same ;; Skip incrementation if it's the same character
    inc rcx
.same:
    inc rdi
    inc rsi
    jmp .loop

.error:
    mov rax, -1
    ret
    
.both_empty:
    mov rax, 0
    ret

;; When reaching a null byte in one the strings, we check if the other also reached a null byte <====> same length
.length_check:
    cmp byte [rdi], 0
    jnz .error
    cmp byte [rsi], 0
    jnz .error
    jmp .done
    
.done:
    mov rax, rcx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
