section .data
    num1 db 0
    num2 db 0
    operator db 0
    result db 0

section .text
    global _start

_start:
    ; Get the input from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 255
    int 80h

    ; Parse the input
    mov esi, num1
    mov edi, num1
    mov ebx, 0
    mov ecx, 0
    cld
    next_char:
        lodsb
        cmp al, 0
        je perform_operation
        cmp al, '+'
        je add_numbers
        cmp al, '-'
        je subtract_numbers
        cmp al, '*'
        je multiply_numbers
        cmp al, '/'
        je divide_numbers
        cmp al, '0'
        jl invalid_input
        cmp al, '9'
        jg invalid_input
        sub al, '0'
        mov bl, 10
        mul ebx
        add ecx, eax
        jmp next_char

    ; If the input is invalid, exit the program
    invalid_input:
        mov eax, 1
        xor ebx, ebx
        int 80h

    ; Perform the operation
    perform_operation:
        mov byte [operator], 0
        mov al, byte [esi]
        cmp al, '+'
        je add_numbers
        cmp al, '-'
        je subtract_numbers
        cmp al, '*'
        je multiply_numbers
        cmp al, '/'
        je divide_numbers
        jmp invalid_input

    ; If the operator is invalid, exit the program
    invalid_operator:
        mov eax, 1
        xor ebx, ebx
        int 80h

    add_numbers:
        inc esi
        mov byte [operator], '+'
        jmp perform_calculation

    subtract_numbers:
        inc esi
        mov byte [operator], '-'
        jmp perform_calculation

    multiply_numbers:
        inc esi
        mov byte [operator], '*'
        jmp perform_calculation

    divide_numbers:
        inc esi
        mov byte [operator], '/'
        jmp perform_calculation

    perform_calculation:
        mov edi, esi
        mov ebx, 0
        mov ecx, 0
        cld
        next_char2:
            lodsb
            cmp al, 0
            je print_result
            cmp al, '+'
            je perform_operation
            cmp al, '-'
            je perform_operation
            cmp al, '*'
            je perform_operation
            cmp al, '/'
            je perform_operation
            cmp al, '0'
            jl invalid_input
            cmp al, '9'
            jg invalid_input
            sub al, '0'
            mov bl, 10
            mul ebx
            add ecx, eax
            jmp next_char2

        ; Perform the operation
        cmp byte [operator], '+'
        je add_numbers2
        cmp byte [operator], '-'
        je subtract_numbers2
        cmp byte [operator], '*'
        je multiply_numbers2
        cmp byte [operator], '/'
        je divide_numbers2
        jmp invalid_operator

    add_numbers2:
        add byte [result], cl
        jmp perform_operation

    subtract_numbers2:
        sub byte [result], cl
        jmp perform_operation

    multiply_numbers2:
        mul byte [result], cl
        jmp perform_operation

    divide_numbers2:
        div byte [result], cl
        jmp perform_operation

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
