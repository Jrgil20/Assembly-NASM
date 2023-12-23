section .data
    Welcome db 'Bienvenidos a Transcripto Simple', 0
    WelcomeLen equ $-Welcome 
    NewLine db 0Ah, 0Dh 
    InputPrompt db 'Ingrese la Cadena: ', 0 
    InputPromptLen equ $-InputPrompt    
    OutputPrompt db 'ELa Cadena ingresada es : ', 0 
    OutputPromptLen equ $-OutputPrompt 
    Buffer times 100 db 0 ; Búfer de entrada (Cadena donde se almacena la entrada dada )

section .text
    global _start

; Función para imprimir un salto de línea
print_newline:
    mov eax, 4 
    mov ebx, 1 
    mov ecx, NewLine 
    mov edx, 2 
    int 0x80 
    ret 


_start:
    ; Escribir el mensaje de bienvenida en la consola
    mov eax, 4
    mov ebx, 1
    mov ecx, Welcome
    mov edx, WelcomeLen
    int 0x80

    call print_newline

    ; Solicitar al usuario que ingrese una cadena de texto
    mov eax, 4 
    mov ebx, 1 
    mov ecx, InputPrompt 
    mov edx, InputPromptLen
    int 0x80

    ; Leer la cadena de texto ingresada por el usuario
    mov eax, 3 
    mov ebx, 0 
    mov ecx, Buffer 
    mov edx, 100 
    int 0x80

    ; Inicializar el puntero al búfer
    mov esi, Buffer

    ; Recorrer la cadena hasta encontrar el byte nulo (terminador)
    mov ecx, 0
    mov al, byte [esi + ecx]
    while_not_null:
        cmp al, 0
        je end_loop

        ; Aquí puedes realizar las operaciones que desees con el byte de la cadena
        cmp al, 'a'
        je replace_a
        cmp al, 'e'
        je replace_e
        cmp al, 'i'
        je replace_i
        cmp al, 'o'
        je replace_o
        cmp al, 'u'
        je replace_u
        jmp continue_loop

    replace_a:
        mov byte [esi + ecx], '$'
        jmp continue_loop

    replace_e:
        mov byte [esi + ecx], '#'
        jmp continue_loop
    
    replace_i: 
        mov byte [esi + ecx], '%'
        jmp continue_loop

    replace_o:
        mov byte [esi + ecx], '&'
        jmp continue_loop

    replace_u:
        mov byte [esi + ecx], '@'
        jmp continue_loop

    continue_loop:
        ; Incrementar el contador y cargar el siguiente byte de la cadena
        inc ecx
        mov al, byte [esi + ecx]
        jmp while_not_null

    end_loop:

    ; Escribir el mensaje de salida en la consola
    mov eax, 4
    mov ebx, 1
    mov ecx, OutputPrompt
    mov edx, OutputPromptLen
    int 0x80

    ; Imprimir la cadena de texto ingresada por el usuario
    mov eax, 4
    mov ebx, 1
    mov ecx, Buffer 
    mov edx, 100
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx	   
    int 0x80