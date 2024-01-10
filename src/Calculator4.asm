section .data
    num1 db 0
    num2 db 0
    operator db 0
    result db 0

section .text
    global _start

_start:
    ; Get the first number
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 80h

    ; Get the operator
    mov eax, 3
    mov ebx, 0
    mov ecx, operator
    mov edx, 1
    int 80h

    ; Get the second number
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 80h

    ; Convert the numbers from ASCII to integers
    sub byte [num1], '0'
    sub byte [num2], '0'

    ; Perform the operation
    cmp byte [operator], '+'
    je add_numbers
    cmp byte [operator], '-'
    je subtract_numbers
    cmp byte [operator], '*'
    je multiply_numbers
    cmp byte [operator], '/'
    je divide_numbers

    ; If the operator is invalid, exit the program
    mov eax, 1
    xor ebx, ebx
    int 80h

add_numbers:
    add byte [num1], [num2]
    jmp print_result

subtract_numbers:
    sub byte [num1], [num2]
    jmp print_result

multiply_numbers:
    mul byte [num1], [num2]
    jmp print_result

divide_numbers:
    div byte [num1], [num2]
    jmp print_result

print_result:
    ; Convert the result from an integer to ASCII
    add byte [result], '0'

    ; Print the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 80h

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 80h
