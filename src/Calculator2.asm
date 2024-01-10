;	CALCULADORA BASICA CON NUMEROS DE 32 BITS
;	REALIZA OPERACIONES DE SUMA, RESTA, MULTIPLICACION Y DIVISON

section .data				; *********MENSAJES*********
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
	numero1 resd 1 		; se guarda el primer numero de 32 bits
	numero2 resd 1 		; se guarda el segundo numero de 32 bits
	resultado resd 1 	; se guarda el resultado de la operacion
	cadena1 resb 10 	; se guarda la cadena del primer numero
	cadena2 resb 10 	; se guarda la cadena del segundo numero
	cadenaRes resb 10 	; se guarda la cadena del resultado
	cadenaF resb 10 	; se guarda la cadena del resultado invertida
	longitud1 resb 1 	; se guarda la longitud de la cadena1
	longitud2 resb 1 	; se guarda la longitud de la cadena2
	signo resb 1 		; se guarda el signo de la operacion

section .text

%macro Input 2				;MACRO -> Input (1:Variable, 2:Longitud)
	mov eax, 3 			;sys_read
	mov ebx, 1 			;stdin
	mov ecx, %1 		;variable
	mov edx, %2 		;longitud
	int 80h 			;llamada al sistema
%endmacro

%macro Output 2				;MACRO -> Output (1:Variable 2:Longitud)
	mov eax, 4 			;sys_write
	mov ebx, 1 			;stdout
	mov ecx, %1 		;variable
	mov edx, %2 		;longitud
	int 80h 			;llamada al sistema
%endmacro 


%macro Longitud 2			;MACRO -> Guardar Longitud variable (1:Variable 2:Longitud)
	xor esi, esi 		;contador
	xor eax, eax 		;limpiar eax
	contar%1: 			;ciclo contar
	mov al, [%1+esi] 	;cargar caracter
	cmp al, '' 			;comparar con fin de cadena
	jne incrementar%1 	;si no es fin de cadena, incrementar contador
	je final%1 			;si es fin de cadena, terminar
	
	incrementar%1: 		;incrementar contador
	inc esi 			;incrementar contador
	jmp contar%1		;volver a contar
	
	final%1:			;guardar longitud
	dec esi				;decrementar contador
	mov [%2], esi		;guardar longitud
	xor esi, esi		;limpiar esi
	xor eax, eax		;limpiar eax
%endmacro

%macro CadenaANumero 3			;MACRO -> CONVERTIR CADENA A NUMERO (1:Numero 2:Cadena 3:Long Cadena)
	mov esi, [%3]		;longitud
	dec esi				;decrementar contador
	mov ecx, [%3]       ;longitud
	mov ebx, 1			;base 10
	cadenaANum%1:   	;convertir cadena a numero
	xor eax, eax		;limpiar eax
	mov al, [%2+esi]	;cargar caracter
	sub al, 30h			;convertir a numero
	mul ebx				;eax = eax * ebx
	add [%1], eax		;sumar al numero
	
	mov eax, ebx		;eax = 10
	mov edx, 10			;edx = 10
	mul edx				;eax = eax * edx
	mov ebx, eax		;ebx = eax
	dec esi				;decrementar contador
	LOOP cadenaANum%1	;volver a convertir
%endmacro

%macro LimpiarCadena 2			;MACRO -> LIMPIAR CADENA (1:Cadena 2:Long Cadena)
	xor eax, eax		;limpiar eax
	xor esi, esi		;limpiar esi
	mov al, ''			;caracter vacio
	mov ecx, %2			;longitud
	cicloLimpiar%1:		;ciclo limpiar
	mov [%1+esi], al 	;limpiar caracter
	inc esi				;incrementar contador
	LOOP cicloLimpiar%1	;volver a limpiar
%endmacro


global _start:
_start:
	
	Inicio:						;SE LIMPIAN TODAS LAS VAR. ANTES DE SEGUIR
	xor eax, eax				;limpiar eax
	mov [numero1], eax			;limpiar numero1
	mov [numero2], eax			;limpiar numero2
	mov [resultado], eax		;limpiar resultado
	LimpiarCadena cadena1, 10 	;call limpiar cadena1
	LimpiarCadena cadena2, 10	;call limpiar cadena2
	LimpiarCadena cadenaRes, 10	;call limpiar cadenaRes
	LimpiarCadena cadenaF, 10	;call limpiar cadenaF
	
	Output msj1, lenmsj1		;MENSAJE INICIAL & OPCION A REALIZAR
	Output msjOpc, lenmsjOpc 	;call imprimir mensaje de opciones
	Input opcion, 2				;call leer opcion
	mov al, [opcion]			;VERIFICAR OPCION
	cmp al, '1'					;call verificar opcion
	jb Inicio					;call volver a inicio
	cmp al, '4'					;call verificar opcion
	ja Inicio					;call volver a inicio
	
	Output msjn1, lenmsjn			;***PROCESAR NUMERO 1
	Input cadena1, 10				;call leer cadena1
	Longitud cadena1, longitud1		;call longitud cadena1
	CadenaANumero numero1, cadena1, longitud1
	
	
	Output msjn2, lenmsjn			;***PROCESAR NUMERO 2
	Input cadena2, 10				;call leer cadena2
	Longitud cadena2, longitud2		;call longitud cadena2
	CadenaANumero numero2, cadena2, longitud2
	

	mov eax, [numero1]		;REALIZAR OPERACION
	mov ebx, [numero2]		;mueve numero2 a ebx
	mov dl, [opcion]		;mueve opcion a dl
	cmp dl, '1'				;compara opcion
	je Sumar				;si es 1, suma
	cmp dl, '2'				
	je Restar				;si es 2, resta
	cmp dl, '3'
	je Multip				;si es 3, multiplica
	cmp dl, '4'
	je Dividir				;si es 4, divide
	
	Sumar:				;SUMA
	add eax, ebx			;suma eax y ebx
	jmp Resultado			;salta a resultado
	Restar:				;RESTA
	sub eax, ebx			;resta eax y ebx
	jmp procesarResta 		;salta a procesar resta
	Multip:				;MULTIPLICACION
	mul ebx					;eax = eax * ebx
	jmp Resultado			;salta a resultado
	Dividir:			;DIVISION	
	xor edx, edx			;limpia edx
	idiv ebx				;eax = eax / ebx
	push edx				;guarda el resto en la pila
	jmp Resultado			;salta a resultado
	
	procesarResta:			;Procesar Resta por si es negativo
	cmp eax, 0				;compara eax con 0
	jg Resultado			;si es mayor a 0, salta a resultado
	jl negativo				;si es menor a 0, salta a negativo
	negativo:				;si es negativo
	neg eax					;negar eax
	mov bl, '-'				;guardar signo
	mov [signo], bl			;guardar signo
	jmp Resultado			;salta a resultado
	
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
	int 80h				;llamada al sistema
