    ; FILEPATH: /workspaces/Assembly-with-linux/src/Suma.asm

    ; Este programa en ensamblador realiza la suma de dos números enteros ingresados por el usuario.
    ; El programa solicita al usuario que ingrese dos números y luego los convierte a enteros.
    ; Luego, realiza la suma de los dos números y almacena el resultado en una cadena.
    ; Finalmente, imprime el resultado en la salida estándar y termina la ejecución del programa.

    ; El programa utiliza las siguientes funciones del sistema operativo:
    ; - La función 4 del sistema para escribir en la salida estándar.
    ; - La función 3 del sistema para leer desde la entrada estándar.
    ; - La función 1 del sistema para terminar la ejecución del programa.

section .data
    prompt1 db "Ingrese el primer número: ", 0
    prompt2 db "Ingrese el segundo número: ", 0
    result db "El resultado es: ", 0

section .bss
    num1 resb 10
    num2 resb 10
    sum resb 10

section .text
    global _start

_start:

    ; Imprimir el primer prompt
    mov eax, 4 ; Cargar el número de la función del sistema para escribir en la salida estándar
    mov ebx, 1 ; Cargar el descriptor de archivo para la salida estándar
    mov ecx, prompt1 ; Cargar la dirección del mensaje a imprimir
    mov edx, 21 ; Cargar la longitud del mensaje
    int 0x80 ; Llamar a la interrupción del sistema operativo para imprimir el mensaje
   
    ; Leer el primer número
    mov eax, 3  ; Mueve el valor 3 al registro eax para indicar la operación de lectura
    mov ebx, 0  ; Mueve el valor 0 al registro ebx para indicar la entrada estándar
    mov ecx,   ; Mueve la dirección de memoria de la variable num1 al registro ecx para almacenar el número leído
    mov edx, 10    ; Mueve el valor 10 al registro edx para indicar la longitud máxima de la entrada
    int 0x80  ; Realiza una interrupción del sistema operativo (int 0x80) para leer el número desde la entrada estándar

    ; Imprimir el segundo prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 22
    int 0x80

    ; Leer el segundo número
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 10
    int 0x80

    ; Convertir los números a enteros
    mov eax, 0
    mov esi, num1
    convert_loop1:
        cmp byte [esi], 0
        je convert_end1
        sub byte [esi], '0'
        imul eax, 10
        add al, byte [esi]
        inc esi
        jmp convert_loop1
    convert_end1:
    mov ebx, eax

    mov eax, 0
    mov esi, num2
    convert_loop2:
        cmp byte [esi], 0
        je convert_end2
        sub byte [esi], '0'
        imul eax, 10
        add al, byte [esi]
        inc esi
        jmp convert_loop2
    convert_end2:
    add ebx, eax

    ; Convertir el resultado a una cadena
    mov eax, ebx
    mov edi, sum
    convert_loop3:
        xor edx, edx
        mov ecx, 10
        div ecx
        add dl, '0'
        dec edi
        mov [edi], dl
        test eax, eax
        jnz convert_loop3

    ; Imprimir el resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 16
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, sum
    mov edx, 10
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
