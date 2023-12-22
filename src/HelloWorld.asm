section .data ; declaramos la seccion de datos
    ; creamos una variable llamada hello que contiene el string "Hola Mundo"
    hello db 'Hola Mundo', 0

section .text ; declaramos la seccion de codigo
    global _start ; declaramos la etiqueta _start como global para que el enlazador pueda encontrarla

_start: ; etiqueta _start
    ; escribimos el string en la salida estandar
    mov eax, 4 ; 4 es el numero de la llamada al sistema para escribir en la salida estandar
    mov ebx, 1 ; 1 es el descriptor de la salida estandar
    mov ecx, hello ; cargamos la direccion de memoria del string en el registro ecx
    mov edx, 10 ;  cargamos la longitud del string en el registro edx
    int 0x80 ; llamamos al sistema

    ; salimos del programa
    mov eax, 1 ; 1 es el numero de la llamada al sistema para salir del programa
    xor ebx, ebx ; ponemos ebx a 0
    int 0x80 ; llamamos al sistema
