section .data
    menu_prompt db 'Seleccione una opción:', 0
    menu_prompt_len equ $ - menu_prompt
    option1 db 'Opción 1', 0
    option1_len equ $ - option1
    option2 db 'Opción 2', 0
    option2_len equ $ - option2
    option3 db 'Opción 3', 0
    option3_len equ $ - option3
    invalid_Opction db 'Opcion invalida', 0
    invalid_Opction_len equ $ - invalid_Opction

section .text
    global _start

_start:
    ; Mostrar el menú
    mov eax, 4
    mov ebx, 1
    mov ecx, menu_prompt
    mov edx, menu_prompt_len
    int 0x80

    ; Leer la opción seleccionada
    mov eax, 3
    mov ebx, 0
    mov ecx, esp
    mov edx, 2
    int 0x80

    ; Comparar la opción seleccionada
    cmp byte [esp], '1'
    je option1_selected
    cmp byte [esp], '2'
    je option2_selected
    cmp byte [esp], '3'
    je option3_selected

    ; Opción inválida
    jmp invalid_option

option1_selected:
    ; Imprimir la opción 1
        mov eax, 4
        mov ebx, 1
        mov ecx, option1
        mov edx, option1_len
        int 0x80
    jmp exit

option2_selected:
    ; Imprimir la opción 2
        mov eax, 4
        mov ebx, 1
        mov ecx, option2
        mov edx, option2_len
        int 0x80
    jmp exit

option3_selected:
    ; Imprimir la opción 3
        mov eax, 4
        mov ebx, 1
        mov ecx, option3
        mov edx, option3_len
        int 0x80
    jmp exit

invalid_option:
    ; Opción inválida seleccionada
    ; Imprimir la opción inválida
        mov eax, 4
        mov ebx, 1
        mov ecx, invalid_Opction
        mov edx, invalid_Opction_len
        int 0x80
    jmp _start ; Vuelve a solicitar una opción válida

exit:
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
