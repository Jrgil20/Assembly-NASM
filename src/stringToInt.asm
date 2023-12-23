section .data
    str db "12345"  ; Cadena numérica de ejemplo

section .text
    global _start

_start:
    ; Llamada a la función para convertir la cadena en entero
    mov esi, str
    call stringToInt

    ; Aquí puedes realizar operaciones con el entero convertido

    ; Terminar el programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

stringToInt:
    ; Inicializar el valor del entero en 0
    xor eax, eax

    ; Recorrer la cadena de caracteres
    mov ecx, 0
    movzx edx, byte [esi + ecx]

convertLoop:
    ; Verificar si se llegó al final de la cadena
    cmp dl, 0
    je convertEnd

    ; Convertir el dígito a entero
    sub dl, '0'
    imul eax, 10
    add eax, edx

    ; Avanzar al siguiente dígito
    inc ecx
    movzx edx, byte [esi + ecx]
    jmp convertLoop

convertEnd:
    ret
