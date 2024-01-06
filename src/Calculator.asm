; Este código realiza una operación de selección.
; Toma dos valores y compara si el primer valor es mayor que el segundo.
; Si es así, se guarda el primer valor en el registro eax.
; Si no, se guarda el segundo valor en el registro eax.
; Finalmente, el valor en el registro eax es devuelto como resultado.

section .data

   ; Mensajes

   msg1      db      10,'-Calculadora-',10,0
   lmsg1      equ      $ - msg1
   
   msg2      db      10,'Numero 1: ',0
   lmsg2      equ      $ - msg2

   msg3      db      'Numero 2: ',0
   lmsg3      equ      $ - msg3

   msg4      db      10,'1. Sumar',10,0
   lmsg4      equ      $ - msg4

   msg5      db      '2. Restar',10,0
   lmsg5      equ      $ - msg5

   msg6      db      '3. Multiplicar',10,0
   lmsg6      equ      $ - msg6

   msg7      db      '4. Dividir',10,0
   lmsg7      equ      $ - msg7

   msg8      db      'Operacion: ',0
   lmsg8      equ      $ - msg8

   msg9      db      10,'Resultado: ',0
   lmsg9      equ      $ - msg9

   msg10      db      10,'Opcion Incorrecta',10,0
   lmsg10      equ      $ - msg10

   nlinea      db      10,10,0
   lnlinea      equ      $ - nlinea

   msg_error      db      10,'Entrada no válida. Por favor, ingrese un número del 0 al 9.',10,0
   lmsg_error      equ      $ - msg_error

section .bss
   
   ; Espacios reservados para almacenar los valores proporcionados
   ; por el usuario.
   
   opc         resb    2
   num1      resw   2
   num2      resw    2
   result      resw    2

section .text

   global _start

_start:

   ; Imprimimos en pantalla el mensaje 1
   mov eax, 4
   mov ebx, 1
   mov ecx, msg1
   mov edx, lmsg1
   int 80h
   
   ; Imprimimos en pantalla el mensaje 2
   mov eax, 4
   mov ebx, 1
   mov ecx, msg2
   mov edx, lmsg2
   int 80h
   
   ; Obtenemos el valor de numero1
   mov eax, 3
   mov ebx, 0
   mov ecx, num1
   mov edx, 2
   int 80h

   ; Imprimimos en pantalla el mensaje 3
   mov eax, 4
   mov ebx, 1
   mov ecx, msg3
   mov edx, lmsg3
   int 80h
   
   ; Obtenemos el valor de numero2
   mov eax, 3
   mov ebx, 0
   mov ecx, num2
   mov edx, 2
   int 80h

   ; Imprimimos en pantalla el mensaje 4
   mov eax, 4
   mov ebx, 1
   mov ecx, msg4
   mov edx, lmsg4
   int 80h

   ; Imprimimos en pantalla el mensaje 5
   mov eax, 4
   mov ebx, 1
   mov ecx, msg5
   mov edx, lmsg5
   int 80h

   ; Imprimimos en pantalla el mensaje 6
   mov eax, 4
   mov ebx, 1
   mov ecx, msg6
   mov edx, lmsg6
   int 80h

   ; Imprimimos en pantalla el mensaje 7
   mov eax, 4
   mov ebx, 1
   mov ecx, msg7
   mov edx, lmsg7
   int 80h

   ; Imprimimos en pantalla el mensaje 8
   mov eax, 4
   mov ebx, 1
   mov ecx, msg8
   mov edx, lmsg8
   int 80h
   
   ; Obtenemos la opcion deseada por el usuario
   mov ebx,0
   mov ecx,opc
   mov edx,2
   mov eax,3
   int 80h
   
   mov ah, [opc]   ; Movemos la opcion seleccionada al registro ah
   sub ah, '0'      ; Convertimos de ascii a decimal
   
   ; Comparamos el valor ingresado por el usuario para saber que
   ; operacion desea realizar.
   cmp ah, 1
   je sumar
   cmp ah, 2
   je restar
   cmp ah, 3
   je multiplicar
   cmp ah, 4
   je dividir
   
   ; Si el valor ingresado por el usuario no cumple ninguna de las
   ; condiciones anteriores entonces mostramos un mensaje de error y
   ; finalizamos el programa.
   mov eax, 4
   mov ebx, 1
   mov ecx, msg10
   mov edx, lmsg10
   int 80h
   
   jmp salir

sumar:
   ; Guardamos los numeros en los registros eax y ebx
   mov eax, [num1]
   mov ebx, [num2]
   
   ; Conversion de ascii a decimal
   sub eax, '0'
   sub ebx, '0'
   
   ; Suma
   add eax, ebx
   
   ; Conversion de decimal a ascii
   add eax, '0'
   
   ; Movemos el resultado
   mov [result], eax
   
   ; Imprimimos el mensaje 9
   mov eax, 4
   mov ebx, 1
   mov ecx, msg9
   mov edx, lmsg9
   int 80h
   
   ; Imprimimos el resultado
   mov eax, 4
   mov ebx, 1
   mov ecx, result
   mov edx, 1
   int 80h

   ; Finalizamos el programa
   jmp salir

restar:
   ; Guardamos los numeros en los registros eax y ebx
   mov eax, [num1]
   mov ebx, [num2]
   
   ; Conversion de ascii a decimal
   sub eax, '0'
   sub ebx, '0'
   
   ; Resta
   sub eax, ebx

   ; Conversion de decimal a ascii
   add eax, '0'
   
   ; Movemos el resultado
   mov [result], eax
   
   ; Imprimimos el mensaje 9
   mov eax, 4
   mov ebx, 1
   mov ecx, msg9
   mov edx, lmsg9
   int 80h
   
   ; Imprimimos el resultado
   mov eax, 4
   mov ebx, 1
   mov ecx, result
   mov edx, 1
   int 80h

   ; Finalizamos el programa
   jmp salir

multiplicar:
   ; Guardamos los numeros en los registros ax y bx
   mov ax, [num1]
   mov bx, [num2]
   
   ; Conversion de ascii a decimal
   sub ax, '0'
   sub bx, '0'
   
   ; Multiplicacion. AL = AX x BX
   mul bx
   
   ; Conversion decimal a ascii
   add al, '0'
   
   ; Movemos el resultado
   mov [result], al
   
   ; Imprimimos el mensaje 9
   mov eax, 4
   mov ebx, 1
   mov ecx, msg9
   mov edx, lmsg9
   int 80h
   
   ; Imprimimos el resultado
   mov eax, 4
   mov ebx, 1
   mov ecx, result
   mov edx, 1
   int 80h

   ; Finalizamos el programa
   jmp salir
   
dividir:
   ; Guardamos los numeros en los registros ax y bl
   mov ax, [num1]
   mov bl, [num2]

   ; Conversion de ascii a decimal
   sub ax, '0'
   sub bl, '0'
   
   ; Division. AL = AX / BL
   div bl
   
   ; Conversion decimal a ascii
   add al, '0'
   
   ; Movemos el resultado
   mov [result], al
   
   ; Imprimimos el mensaje 9
   mov eax, 4
   mov ebx, 1
   mov ecx, msg9
   mov edx, lmsg9
   int 80h
   
   ; Imprimimos el resultado
   mov eax, 4
   mov ebx, 1
   mov ecx, result
   mov edx, 1
   int 80h
   
   ; Finalizamos el programa
   jmp salir

salir:
   ; Imprimimos dos nuevas lineas
   mov eax, 4
   mov ebx, 1
   mov ecx, nlinea
   mov edx, lnlinea
   int 80h
   ; Finalizamos el programa
   mov eax, 1
   mov ebx, 0
   int 80