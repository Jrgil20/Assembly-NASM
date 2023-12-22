section .data ; declaramos la seccion de datos
    Welcome db 'Bienvenidos a Lenguaje emsamblador', 0 ; declaramos el string a imprimir
    WelcomeLen equ $-Welcome ; calculamos la longitud del string


section .text ; declaramos la seccion de codigo
    global _start 

_start: 
    ; escribimos el string en la salida estandar
    mov eax, 4 
    mov ebx, 1 
    mov ecx, Welcome ; cargamos la direccion de memoria del string en el registro ecx
    mov edx, WelcomeLen ;  cargamos la longitud del string en el registro edx
    int 0x80 

    ; salimos del programa
    mov eax, 1 
    xor ebx, ebx 
    int 0x80 
