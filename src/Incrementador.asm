section .data
    input_msg db "Ingrese un número: ", 0
    input_msg_len equ $ - input_msg
    output_msg db "El número incrementado es: ", 0
    output_msg_len equ $ - output_msg


section .bss
    num resb 10

section .text
    global _start

_start:
    ; Imprimir mensaje de entrada
    mov eax, 4
    mov ebx, 1
    mov ecx, input_msg
    mov edx, input_msg_len
    int 0x80

    ; Leer número del usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 10
    int 0x80

    ; Convertir a entero
    mov eax, 0
    mov edi, 10
    xor esi, esi
convert_loop:
    movzx ebx, byte [ecx+esi]
    cmp ebx, 0
    je convert_done
    imul eax, edi
    add eax, ebx
    inc esi
    jmp convert_loop
convert_done:

    ; Sumar 1 al número
    add eax, 1

    ; Convertir a cadena
    mov edi, 10
    xor esi, esi
convert_to_string:
    xor edx, edx
    div edi
    add dl, '0'
    push dx
    inc esi
    test eax, eax
    jnz convert_to_string

    ; Imprimir mensaje de salida
    mov eax, 4
    mov ebx, 1
    mov ecx, output_msg
    mov edx, output_msg_len
    int 0x80

    ; Imprimir número convertido
print_loop:
    pop dx
    add dl, '0'
    mov eax, 4
    mov ebx, 1
    mov [num], dl ; mover dl a la memoria
    lea ecx, [num] ; cargar la dirección de num en ecx
    mov edx, 1
    int 0x80
    dec esi
    jnz print_loop

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
