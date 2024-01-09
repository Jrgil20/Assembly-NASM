section .data
    menu_prompt db 'Seleccione Que operacion desea realizar:', 0
    menu_prompt_len equ $ - menu_prompt
    option1 db '1. Suma', 0
    option1_len equ $ - option1
    option2 db '2. Resta', 0
    option2_len equ $ - option2
    option3 db '3. Multiplicacion', 0
    option3_len equ $ - option3
    option4 db '4. Division', 0
    option4_len equ $ - option4
    invalid_Opction db 'Opcion invalida', 0
    invalid_Opction_len equ $ - invalid_Opction
    ReadNumberprompt db 'Ingrese un numero: ', 0
    ReadNumberprompt_len equ $ - ReadNumberprompt
    newline_char db 10
    newline_char_len equ $ - newline_char

section .text
    global _start

_start:
call menu

menu:
    ; Mostrar el menú
    mov eax, 4
    mov ebx, 1
    mov ecx, menu_prompt
    mov edx, menu_prompt_len
    int 0x80

    call newline
  
    ; Imprimir la opción 1
    mov eax, 4
    mov ebx, 1
    mov ecx, option1
    mov edx, option1_len
    int 0x80    

    call newline

    ; Imprimir la opción 2
    mov eax, 4
    mov ebx, 1
    mov ecx, option2
    mov edx, option2_len
    int 0x80

    call newline

    ; Imprimir la opción 3
    mov eax, 4
    mov ebx, 1
    mov ecx, option3
    mov edx, option3_len
    int 0x80

    call newline

    ; Imprimir la opción 4
    mov eax, 4
    mov ebx, 1
    mov ecx, option4
    mov edx, option4_len
    int 0x80
    
    call newline

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
    cmp byte [esp], '4'
    je option4_selected
    ; Opción inválida
    jmp invalid_option

newline:
    ; Imprimir un salto de línea
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, newline_char ; string
    mov edx, newline_char_len ; len
    int 0x80 ; syscall
    ret ; return


option1_selected:
    ; Imprimir la opción 1
        mov eax, 4
        mov ebx, 1
        mov ecx, option1
        mov edx, option1_len
        int 0x80

        call newline

        call Read_Number_prompt

        ; Leer el primer número
        mov eax, 3 ; sys_read
        mov ebx, 0 ; stdin
        mov ecx, esp ; buffer
        mov edx, 2 ; len
        int 0x80 ; syscall
        
        call newline

        call Read_Number_prompt

        ; Leer el segundo número
        mov eax, 3 ; sys_read
        mov ebx, 0 ; stdin
        mov ecx, esp ; buffer
        mov edx, 2 ; len
        int 0x80 ; syscall

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

option4_selected:
    ; Imprimir la opción 4
        mov eax, 4
        mov ebx, 1
        mov ecx, option4
        mov edx, option4_len
        int 0x80
    jmp exit

Read_Number_prompt:
    ; Imprimir el prompt para leer un número
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, ReadNumberprompt ; string
    mov edx, ReadNumberprompt_len ; len
    int 0x80 ; syscall
    ret ; return

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
