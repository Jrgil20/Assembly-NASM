section .data
    num db 12345 ; numero a ser convertido
    str db 10 dup(' ') ; string que recebera o numero convertido

section .text
    global _start

_start:
    mov eax, num ; move o numero para o registrador eax
    call int_to_string ;llama a la funcion int_to_string
    mov edx, str ; move a string para o registrador edx
    call print_string ;llama a la funcion print_string

    mov eax, 1 ; syscall para terminar el programa
    xor ebx, ebx ; codigo de retorno
    int 0x80 ; llama al kernel

int_to_string:
    xor ecx, ecx ; contador
    mov ebx, 10 ; divisor

    convert_loop:
        xor edx, edx ; limpia edx
        div ebx ; divide eax por ebx
        add dl, '0' ; convierte el numero en un caracter
        mov [edx + str + ecx], dl ; mueve el caracter para la cadena
        inc ecx ; incrementa el contador
        test eax, eax ; verifica si eax es 0
        jnz convert_loop ; si no es 0, continua el loop

    mov byte [str + ecx], 0
    ret ; retorna


; funcion para imprimir una cadena
print_string:
    mov eax, 4 ; syscall para imprimir
    mov ebx, 1 ; stdout
    mov ecx, edx ; cadena a imprimir
    mov edx, ecx ; longitud de la cadena
    int 0x80 ; llama al kernel
    ret ; retorna
