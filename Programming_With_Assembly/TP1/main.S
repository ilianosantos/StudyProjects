; -----------------------------------------------------------------------------
; Ficheiro:   main.S
; Descricao:  Codigo do 1º trabalho prático de AC.
; Autor:      Romário Dias, Iliano Santos
; Disciplina: Arquitetura de Computadores
; Turma:      26 D
; Data:       27-03-2023
; -----------------------------------------------------------------------------
	.equ ERROR_SIZE, 0xFF
	;2. alínea b) Uma definação para NAN é a seguinte:
	.equ NAN, 65535 ; alternativamente .equ NAN, 0xFFFF 
	.equ STACK_SIZE, 64
	.section startup
	b start
	b .
start:
	ldr sp, tos_addr ;top of stack(tos)
	mov r0, pc
	add lr, r0, #4
	ldr pc, main_addr
	b .

tos_addr:
	.word tos
main_addr:
	.word main
;2ºsegmento
	.text
main:
	push lr
    push r4 ;r4 = error
	mov r4, #0
	ldr r1, error_addr
    str r4, [r1]
test_1:
	ldr r0, tst_str0_addr
    ldr r0, [r0]
	mov r1, #2
	bl str2nat
	ldr r1, tst_results_addr
	ldr r1, [r1, #0]
	cmp r0, r1
	beq test_2
	mov r2, #1
	orr r4, r4, r2
    ldr r1, error_addr
    str r4, [r1]
test_2:
	ldr r0, tst_str1_addr
    ldr r0, [r0]
	mov r1, #8
	bl str2nat
	ldr r1, tst_results_addr
	ldr r1, [r1, #2]
	cmp r0, r1
	beq test_3
	mov r2, #2
	orr r4, r4, r2
    ldr r1, error_addr
    str r4, [r1]
test_3:
	ldr r0, tst_str2_addr
    ldr r0, [r0]
	mov r1, #16
	bl str2nat
	ldr r1, tst_results_addr
	ldr r1, [r1, #4]
	cmp r0, r1
	beq main_return
	mov r2, #4
	orr r4, r4, r2
	ldr r1, error_addr
    str r4, [r1]
main_return:
    mov r0, r4
    pop r4
	pop pc

tst_str0_addr:
	.word tst_str0
tst_str1_addr:
	.word tst_str1
tst_str2_addr:
	.word tst_str2
tst_results_addr:
	.word tst_results
error_addr:
	.word error
;------------------------------
; r0/r4 = numeral [0]
; r1/r5 = radix 
; r2 = number
; r3 = error
; r6 = idx
; r7 = tmp

str2nat:
    push lr
    push r4
    push r5
    push r6
    push r7
    push r8
    mov r4, r0
    mov r5, r1
    mov r2, #0
    mov r3, #0
    mov r6, #0
str2nat_loop:
    mov r8, #0
    cmp r3, r8
    bne str2nat_return
    mov r8, #'\0'
    ldrb r0, [r4, r6] 
    cmp r0, r8
    beq str2nat_return
    bl char2nat
    mov r7, r0
str2nat_if:
    mov r8, #NAN & 0xFF
    movt r8, #(NAN >> 8) & 0xFF
    cmp r7, r8 
    bne str2nat_else
    mov r2, r8
    mov r3, #1
    b str2nat_add
str2nat_else:
    mov r8, #0
    bl multiply_while
    add r2, r0, r8 ; r0 retorno da rotina multiply
    b str2nat_add
str2nat_add:
    add r6, r6, #1
    b str2nat_loop
str2nat_return:
    mov r2, r7
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4
    pop pc
multiply_while:
    cmp r3, r8 
    bhs while_end
    add r0, r2, r1
    sub r1, r1, #1
    b multiply_while
while_end:
    mov r0, r2
    mov pc, lr
;------------------------------
; r0 = char symbol 
; r1 = uint16_t radix
; r2 = NAN
; r4, r5 = temp
char2nat:
    push r4
    push r5
number:
    mov r2, #NAN & 0xFF
    movt r2, #(NAN >> 8) & 0xFF
    mov r4, #'0'
    mov r5, #'9'
    cmp r0, r4
    blo else_if_condition
if:
    cmp r5, r0
    blo else_if_condition
    sub r2, r0, r4 
    b   if_2
else_if_condition:
    mov r4, #'A'
    mov r5, #'F'
    cmp r0, r4
    blo if_2
else_if:
    cmp r5, r0
    blo if_2
    sub r0, r0, r4
    add r2, r0, #10 
if_2:
    mov r4, #16
    cmp r4, r1
    bhs if2_2
    b number_NAN
if2_2:
    cmp r2, r1
    blo char2nat_return
number_NAN:
    mov r2, #NAN & 0xFF
    movt r2, #(NAN >> 8) & 0xFF
char2nat_return:
    mov r0, r2
    pop r5
    pop r4
    mov pc, lr

;3ºsegmento
	.data
tst_results:
	.word 11, 457, 39439
tst_str0:
	.asciz "01011"
tst_str1:
	.asciz "709"
tst_str2:
	.asciz "9A0F"
;4ºsegmento
	.bss
error:
	.space ERROR_SIZE 
;5ºsegmento
	.stack
stack_bottom:
    .space STACK_SIZE
tos:
    


/**
	Resposta às perguntas de enunciado do 1º trabalho prático
	1. alínea a)
O programa que implementa esta rotina multiply executa 9 instruções.
Considerando que estamos atrabalhar no âmbito de uma arquitetura de 16
bits, que é o caso do processador P16, sabendo que cada instrução ocupa
16 bits de memória, isto é, 2 bytes. Portanto, concluímos que esta
implementação ocupa 18 bytes, pois 9 x 2 = 18 .
	1. alínea b)
Na nossa opinião, esta afirmação é falsa, pois é preferível que usemos o 
registo r2, ao invés do r4, porque precisamos armazenar o conteúdo
o registo r4 implica acesso à memória, o que tornaria o programa 
mais lento. Utilizando o registo r2, e sabendo que precisamos 
desse valor, não é necessário fazer push para o stack, tornando o
programa mais eficiente.
	2. alínea a)
O valor da constante NAN é 65535 (FFFF na base 16), pois é o maior valor
representável a 16 bits, no domínio dos números inteiros relativos.
	2. alínea b)
Para a constante NAN, é necessário reservar 16 bits na memória, 
porque a constante é um inteiro sem sinal codificado a 16 bits
*/
