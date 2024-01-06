section .data
    input db "a+b-5*8/2*(2-5)", 0
    output db 100 dup(0) ; Cadena de salida
    operator db "+-*/()", 0 ; Operadores válidos
    priority db 0 ; Prioridad actual
    subexpr db 0 ; Indicador de subexpresión

section .text
    global _start

_start:
    ; Leer la cadena de entrada
    mov esi, input

    ; Llamar a la función recursiva para separar la cadena
    call separate_string

    ; Imprimir la cadena de salida
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, eax
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

separate_string:
    ; Obtener el siguiente carácter de la cadena de entrada
    mov al, byte [esi]
    cmp al, 0
    je end_separate_string

    ; Comprobar si el carácter es un operador
    mov edi, operator
    mov ecx, 0
    cmp al, byte [edi + ecx]
    je handle_operator

    ; Comprobar si el carácter es un paréntesis de apertura
    cmp al, '('
    je handle_open_parenthesis

    ; Comprobar si el carácter es un paréntesis de cierre
    cmp al, ')'
    je handle_close_parenthesis

    ; Si no es un operador ni un paréntesis, añadir el carácter a la cadena de salida
    mov edi, output
    mov byte [edi], al
    inc edi
    mov output, edi

    ; Avanzar al siguiente carácter de la cadena de entrada
    inc esi
    jmp separate_string

handle_operator:
    ; Obtener la prioridad del operador actual
    mov edi, operator
    mov ecx, 0
    cmp al, byte [edi + ecx]
    jne next_operator
    mov priority, ecx

next_operator:
    ; Obtener la prioridad del siguiente operador
    mov ecx, 1
    cmp al, byte [edi + ecx]
    jne check_priority

    ; Si el siguiente operador tiene mayor prioridad, añadir el carácter a la cadena de salida
    mov edi, output
    mov byte [edi], al
    inc edi
    mov output, edi

    ; Avanzar al siguiente carácter de la cadena de entrada
    inc esi
    jmp separate_string

check_priority:
    ; Comprobar si el operador actual tiene mayor prioridad que el siguiente operador
    cmp priority, ecx
    jge next_operator

    ; Si el operador actual tiene menor prioridad, añadir el carácter a la cadena de salida
    mov edi, output
    mov byte [edi], al
    inc edi
    mov output, edi

    ; Avanzar al siguiente carácter de la cadena de entrada
    inc esi
    jmp separate_string

handle_open_parenthesis:
    ; Aumentar el indicador de subexpresión
    inc subexpr

    ; Añadir el paréntesis de apertura a la cadena de salida
    mov edi, output
    mov byte [edi], al
    inc edi
    mov output, edi

    ; Avanzar al siguiente carácter de la cadena de entrada
    inc esi
    jmp separate_string

handle_close_parenthesis:
    ; Comprobar si hay una subexpresión abierta
    cmp subexpr, 0
    jle next_operator

    ; Disminuir el indicador de subexpresión
    dec subexpr

    ; Añadir el paréntesis de cierre a la cadena de salida
    mov edi, output
    mov byte [edi], al
    inc edi
    mov output, edi

    ; Avanzar al siguiente carácter de la cadena de entrada
    inc esi
    jmp separate_string

end_separate_string:
    ; Terminar la cadena de salida con un byte nulo
    mov edi, output
    mov byte [edi], 0

    ; Retornar de la función
    ret
