;; No need to compare all the strings
;; two start with the same letter 'g' , can be distinguished with 4th letter
;; three start with 'b' , can be distinguished with 3rd letter
;; the rest are different


default rel

section .data
    black   db "black", 0
    brown   db "brown", 0
    red     db "red", 0
    orange  db "orange", 0
    yellow  db "yellow", 0
    green   db "green", 0
    blue    db "blue", 0
    violet  db "violet", 0 
    grey    db "grey", 0
    white   db "white", 0

    color_array dq black, brown, red, orange, yellow, green, blue, violet, grey, white


section .text
global color_code

;; two start with "g"
;; three start with "b"
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
    mov rax, 5
    jmp .return

;; blue, brown and black are different in 3rd letter
.blue:
    cmp byte [rbx+2], 'u'
    jnz .black
    mov rax, 5
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

global colors
colors:
    lea rax, [color_array]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
