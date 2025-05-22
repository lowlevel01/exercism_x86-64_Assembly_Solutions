;; Ignore 3rd argument

section .text
global value
value:
    call color_code
    push rax
    mov rdi, rsi
    call color_code
    mov rdi, rax
    pop rax
    lea rax, [rax + rax*4] ;; rax = rax + 4*rax
    shl rax, 1 ;; rax = 2*rax
    add rax, rdi 
    ret


color_code:
    lea rbx, [rdi]
    cmp byte [rbx], 'w'
    jnz .violet
    mov rax, 9
    jmp .return
.violet:
    cmp byte [rbx], 'v'
    jnz .yellow
    mov rax, 7
    jmp .return
.yellow:
    cmp byte [rbx], 'y'
    jnz .orange
    mov rax, 4
    jmp .return
.orange:
    cmp byte [rbx], 'o'
    jnz .red
    mov rax, 3
    jmp .return
.red:
    cmp byte [rbx], 'r'
    jnz .grey
    mov rax, 2
    jmp .return

;; dealing with grey and green : difference in 4th letter
.grey:
    cmp byte [rbx+3], 'y'
    jnz .green
    mov rax, 8
    jmp .return
.green:
    cmp byte [rbx+3], 'e'
    jnz .blue
    cmp byte [rbx], 'g'
    jnz .blue
    mov rax, 5
    jmp .return

;; blue, brown and black are different in 3rd letter
.blue:
    cmp byte [rbx+2], 'u'
    jnz .black
    mov rax, 6
    jmp .return
.black:
    cmp byte [rbx+2], 'a'
    jnz .brown
    mov rax, 0
    jmp .return
.brown:
    cmp byte [rbx+2], 'o'
    mov rax, 1
    jmp .return
.return:
    ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
