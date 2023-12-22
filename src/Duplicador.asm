section .data
    prompt db "Ingrese un número: (1..4)", 0
    promptLen equ $ - prompt
    output db "El doble es: ", 0
    outputLen equ $ - output

section .bss ; sección para declarar variables
    number resb 14 ; variable para almacenar el número ingresado por el usuario

section .text
    global _start

_start:
    ; Solicitar número al usuario
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 0x80

    ; Leer número ingresado por el usuario
    mov eax, 3 ; sys_read
    mov ebx, 0 ; stdin
    mov ecx, number ; buffer
    mov edx, 1 ; longitud del buffer
    int 0x80

    ; Convertir número a entero
    mov eax, [number] ; mueve el número a eax
    sub eax, '0' ; resta el valor de 0 (48 posiciones en ASCII) para convertirlo a entero

    ; Calcular el doble del número
    
    add eax, eax ; eax = eax + eax

    ; Convertir el doble a cadena de caracteres
    
    add eax, '0' ; suma el valor de 0 (48 posiciones en ASCII) para convertirlo a caracter
    mov [number], eax ; mueve el número a la variable number

    ; Imprimir el doble en pantalla
    mov eax, 4
    mov ebx, 1
    mov ecx, output 
    mov edx, outputLen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, number     
    mov edx, 4
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
