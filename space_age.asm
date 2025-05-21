default rel


section .data
planet_earth_ratio:
; Same order as in the Enum in the tests
    dd 0.2408467            ; MERCURY
    dd 0.61519726           ; VENUS
    dd 1.0                  ; EARTH
    dd 1.8808158            ; MARS
    dd 11.862615            ; JUPITER
    dd 29.447498            ; SATURN
    dd 84.016846            ; URANUS
    dd 164.79132            ; NEPTUNE

earth_year_seconds:
    dd 31557600.0           

section .text
global age
age:
    cvtsi2ss xmm0, esi ; transforming parameter to float
    
    lea rax, [earth_year_seconds]
    divss xmm0, DWORD [rax] ; divide parameter by earth_year_seconds
    
    lea rax, [planet_earth_ratio]     ; dividing by the orbital period in earth years
    divss xmm0, DWORD [rax + rdi * 4] ; indexing by the parameter since it's an enum
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
