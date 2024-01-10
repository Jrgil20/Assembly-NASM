;	CALCULADORA BASICA CON NUMEROS DE 32 BITS
;	REALIZA OPERACIONES DE SUMA, RESTA, MULTIPLICACION Y DIVISON

section .data				
	opcion db '0'
	salir db '0'
	msj1 db ' Ingrese una Opcion: ', 13, 10
	lenmsj1: equ $-msj1
	msjOpc db '1.Suma 2.Resta 3.Multiplicacion 4.Division', 13, 10
	lenmsjOpc: equ $-msjOpc
	msjn1 db 'numero 1: '
	lenmsjn equ $-msjn1
	msjn2 db 'numero 2: '
	msjres db 13, 10, 'Resultado: '
	lenmsjres equ $-msjres
	Salir db 13, 10, 10, 'Salir? [Y/n]', 13, 10
	lenSalir equ $-Salir

section .bss				;********VARIABLES********
	numero1 resd 1
	numero2 resd 1
	resultado resd 1
	cadena1 resb 10
	cadena2 resb 10
	cadenaRes resb 10
	cadenaF resb 10
	longitud1 resb 1
	longitud2 resb 1
	signo resb 1

section .text

%macro Input 2				;MACRO -> Input (1:Variable, 2:Longitud)
	mov eax, 3
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

%macro Output 2				;MACRO -> Output (1:Variable 2:Longitud)
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro


%macro Longitud 2			;MACRO -> Guardar Longitud variable (1:Variable 2:Longitud)
	xor esi, esi
	xor eax, eax
	contar%1:
	mov al, [%1+esi]
	cmp al, ''
	jne incrementar%1
	je final%1
	
	incrementar%1:
	inc esi
	jmp contar%1
	
	final%1:
	dec esi
	mov [%2], esi
	xor esi, esi
	xor eax, eax
%endmacro

%macro CadenaANumero 3			;MACRO -> CONVERTIR CADENA A NUMERO (1:Numero 2:Cadena 3:Long Cadena)
	mov esi, [%3]
	dec esi
	mov ecx, [%3]
	mov ebx, 1
	cadenaANum%1:
	xor eax, eax
	mov al, [%2+esi]
	sub al, 30h
	mul ebx
	add [%1], eax
	
	mov eax, ebx
	mov edx, 10
	mul edx
	mov ebx, eax
	dec esi
	LOOP cadenaANum%1
%endmacro

%macro LimpiarCadena 2			;MACRO -> LIMPIAR CADENA (1:Cadena 2:Long Cadena)
	xor eax, eax
	xor esi, esi
	mov al, ''
	mov ecx, %2
	cicloLimpiar%1:
	mov [%1+esi], al
	inc esi
	LOOP cicloLimpiar%1
%endmacro

;******************************
;*                            *
;*      --> M A I N <--       *
;*                            *
;******************************

global _start:
_start:
	
	Inicio:				;SE LIMPIAN TODAS LAS VAR. ANTES DE SEGUIR
	xor eax, eax
	mov [numero1], eax
	mov [numero2], eax
	mov [resultado], eax
	LimpiarCadena cadena1, 10
	LimpiarCadena cadena2, 10
	LimpiarCadena cadenaRes, 10
	LimpiarCadena cadenaF, 10
	
	Output msj1, lenmsj1		;MENSAJE INICIAL & OPCION A REALIZAR
	Output msjOpc, lenmsjOpc
	Input opcion, 2
	mov al, [opcion]		;VERIFICAR OPCION
	cmp al, '1'
	jb Inicio
	cmp al, '4'
	ja Inicio
	
	Output msjn1, lenmsjn		;***PROCESAR NUMERO 1
	Input cadena1, 10
	Longitud cadena1, longitud1
	CadenaANumero numero1, cadena1, longitud1
	
	
	Output msjn2, lenmsjn		;***PROCESAR NUMERO 2
	Input cadena2, 10
	Longitud cadena2, longitud2
	CadenaANumero numero2, cadena2, longitud2
	

	mov eax, [numero1]		;REALIZAR OPERACION
	mov ebx, [numero2]
	mov dl, [opcion]
	cmp dl, '1'
	je Sumar
	cmp dl, '2'
	je Restar
	cmp dl, '3'
	je Multip
	cmp dl, '4'
	je Dividir
	
	Sumar:				;SUMA
	add eax, ebx
	jmp Resultado
	Restar:				;RESTA
	sub eax, ebx
	jmp procesarResta
	Multip:				;MULTIPLICACION
	mul ebx
	jmp Resultado
	Dividir:			;DIVISION	
	xor edx, edx
	idiv ebx
	push edx
	jmp Resultado
	
	procesarResta:			;Procesar Resta por si es negativo
	cmp eax, 0
	jg Resultado
	jl negativo
	negativo:
	neg eax
	mov bl, '-'
	mov [signo], bl
	jmp Resultado
	
	;CONVERTIR NUMERO RESULTADO (EAX) A CADENA DE CARACTERES
	
	Resultado:
	xor esi, esi
	mov ebx, 10
	acadena:
	xor edx, edx
	idiv ebx
	add edx, 30h
	mov [cadenaRes+esi], edx
	inc esi
	cmp eax, 0
	jne acadena
	
	Invertircadena:
	mov eax, cadenaRes 		;INVERTIR CADENA (RESULTADO)
	mov esi, 0
	mov edi, 9
	mov ecx, 10
	invertir:
	xor ebx, ebx
	mov bl, [eax+esi]
	mov [cadenaF+edi], bl
	inc esi
	dec edi
	LOOP invertir
	
	Output msjres, lenmsjres	;IMPRIMIR RESULTADO
	Output signo, 1
	Output cadenaF, 10
	
	Output Salir, lenSalir 		;OPCION DE SALIR O CONTINUAR
	Input salir, 2
	mov al, [salir]
	cmp al, 'n'
	je Inicio
	
	mov eax, 1			;SALIR	
	int 80h
