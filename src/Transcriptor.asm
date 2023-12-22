section .data
    Welcome db 'Bienvenidos a Transcripto Simple', 0
    WelcomeLen equ $-Welcome ; Longitud del mensaje de bienvenida
    NewLine db 0Ah, 0Dh ; Caracteres de nueva línea
    InputPrompt db 'Ingrese la Cadena: ', 0 ; Mensaje de solicitud de entrada
    InputPromptLen equ $-InputPrompt    ; Longitud del mensaje de solicitud de entrada
    OutputPrompt db 'ELa Cadena ingresada es : ', 0 ; Mensaje de salida
    OutputPromptLen equ $-OutputPrompt ; Longitud del mensaje de salida
    Buffer times 100 db 0 ; Búfer de entrada (Cadena donde se almacena la entrada dada )

section .text
    global _start

; Función para imprimir un salto de línea
print_newline:
    mov eax, 4 ; Número de la llamada al sistema para 'write'
    mov ebx, 1 ; Descriptor de archivo para la salida estándar
    mov ecx, NewLine ; Puntero a la cadena a imprimir
    mov edx, 2 ; Longitud de la cadena
    int 0x80 ; Realizar la llamada al sistema
    ret ; Regresar al punto de llamada


_start:
    ; Escribir el mensaje de bienvenida en la consola
    mov eax, 4
    mov ebx, 1
    mov ecx, Welcome
    mov edx, WelcomeLen
    int 0x80

    call print_newline

    ; Solicitar al usuario que ingrese una cadena de texto
    mov eax, 4 ; Número de la llamada al sistema para 'write'
    mov ebx, 1 ; Descriptor de archivo para la salida estándar
    mov ecx, InputPrompt ; Puntero a la cadena a imprimir
    mov edx, InputPromptLen ;   Longitud de la cadena
    int 0x80

    ; Leer la cadena de texto ingresada por el usuario
    mov eax, 3 ; Número de la llamada al sistema para 'read'
    mov ebx, 0 ;   Descriptor de archivo para la entrada estándar
    mov ecx, Buffer ; Puntero al búfer de entrada
    mov edx, 100 ; Longitud del búfer
    int 0x80

    ; Escribir el mensaje de salida en la consola
    mov eax, 4
    mov ebx, 1
    mov ecx, OutputPrompt
    mov edx, OutputPromptLen
    int 0x80

    ; Imprimir la cadena de texto ingresada por el usuario
    mov eax, 4
    mov ebx, 1
    mov ecx, Buffer ; Puntero a la cadena a imprimir
    mov edx, 100
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx	   
    int 0x80