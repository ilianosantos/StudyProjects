; Ficheiro:  tp4.S
; Descricao: Programa de suporte a realizacao do 4º trabalho prático.
; Autor:     Iliano Santos, Hélio Moura, Romário Dias
; Data:      09-06-2023
    
	.equ OUTPORT_INIT_VAL, 0xFF			; Valor inicial para o porto de saída
    .equ SYSCLK_FREQ, 0x09				; Intervalo de contagem do circuito pTC
    .equ INPORT_ADDRESS, 0xFF80			; Endereco do porto de entrada
	.equ OUTPORT_ADDRESS, 0xFFC0		; Endereco do porto de saida
	.equ CPSR_BIT_I, 0b010000			; Mascara para o bit I do registo CPSR

    .equ STACK_SIZE, 64					; Tamanho da pilha 

	.equ PTC_ADDRESS, 0xFF78            ; Endereco do circuito pTC 
	.equ PTC_TCR, 0						; Deslocamento do registo TCR do pTC
	.equ PTC_TMR, 2						; Deslocamento do registo TMR do pTC
	.equ PTC_TC,  4						; Deslocamento do registo TC do pTC
	.equ PTC_TIR, 6						; Deslocamento do registo TIR do pTC

	.equ STIMULUS_MASK, 1  				; Mascara para o LED O0(STIMULUS) da placa SDP16 -- 0b00000001
	.equ RESULT_MASK, 0xFE				; Valor inicial para o resultado -- 0b11111110

	.equ DELAY_TIME, 500				; Tempo de espera, em milissegundos, até executar uma nova iteração
	.equ PTC_CMD_START, 0				; Comando para iniciar a contagem no pTC
	.equ PTC_CMD_STOP, 1				; Comando para parar a contagem no pTC

    .section startup
	b _start
	ldr	pc, isr_addr

_start:
	ldr	sp, tos_addr

	ldr	pc, main_addr
;-------------------------------------
tos_addr:
	.word	tos
main_addr:
	.word	main
isr_addr:
	.word	isr
;-------------------------------------
    .text
main:
	mov r0, #OUTPORT_INIT_VAL
	bl outport_init
	;-------------------------------------------
    bl inport_read						; ler o valor do porto de entrada
	asr r1, r0, #1						; deslocar um bit para a direita para detectar carry
	bcs main							; se carry = 1, regressa ao main

	mov	r0, #SYSCLK_FREQ
	bl	ptc_init
	mrs	r0, cpsr
	mov	r1, #CPSR_BIT_I 				; habilita ou desabilita interrupções
	orr	r0, r0, r1
	msr	cpsr, r0
main_loop:
	bl condition_test					; executa o teste de medição de tempo de reação
	b main_loop							; fim da iteração do loop
;-------------------------------------
condition_test:
	push lr
	push r4
	push r5
condition:
	mov r0, #OUTPORT_INIT_VAL
	bl outport_init
read_inport_value:
	bl inport_read
	lsr r4, r0, #4						; deslocar quatro bits para a direita para obter o índice do array em memória para TIME
	lsr r1, r0, #1						; deslocar um bit para a direita para detectar carry (USER)
	bcc read_inport_value				; se carry = 0, regressa ao condition

	ldr r5, array_addr					; obter tempo de espera
	lsl r4, r4, #1
	ldr r4, [r5, r4]					; obter o valor do TIME, através do seu índice
	b do_test
	;-------------------------------------
array_addr:
	.word array
do_test:
	mov r0, #RESULT_MASK
	bl outport_clear_bits				; colocar o valor 0x00 no porto de saída RESULT
	mov r0, #STIMULUS_MASK
	bl outport_set_bits					; colocar o valor 0x01 no porto de saída STIMULUS
	bl sysclk_get_ticks
	mov	r5, r0							; guarda-se o instante em que iniciou-se o teste
if_time_not_over:						; se o tempo não tiver acabado, continua a contar
	bl inport_read
	lsr r1, r0, #1						; deslocar um bit para a direita para detectar carry (USER)
	bcc condition						; se carry = 0, regressa ao condition

	bl sysclk_get_ticks
	sub r0, r0, r5						; intervalo entre o instante atual do temporizador e o instante no momento em que o stimulus foi ativo
	cmp r0, r4							; se esse intervalo for menor que o TIME
	blo if_time_not_over

time_over:
	mov r0, #STIMULUS_MASK
	bl outport_clear_bits				; colocar o valor 0x00 no porto de saída STIMULUS	
	bl sysclk_get_ticks
	mov	r5, r0							; guardar o instante em que o stimulus é desativado
user_clear:
	bl inport_read
	lsr r1, r0, #1						; deslocar um bit para a direita para detectar se não há carry (USER)
	bcs user_clear						; avaliar se o valor do USER mudou para 0

	bl sysclk_get_ticks
	sub r0, r0, r5
show_result:
	lsl r0, r0, #1						; deslocar um bit para a esquerda para colocar o valor do porto de saída RESULT e deixar o stimulus a zero
	bl outport_write					; escrita no porto de saída e consequente resultado
delay_seconds:
	bl sysclk_get_ticks
	mov r5, r0							; criar uma cópia desse tempo para depos utilizar para verificar o delay
    mov r0, #DELAY_TIME & 0xFF
    movt r0, #(DELAY_TIME >> 8) & 0xFF
	add r5, r5, r0						; instante onde user foi desativo a somar com o valor do DELAY TIME
show_result_by_delay_s:					; espera 5 segundos
	bl sysclk_get_ticks
	cmp r0, r5							; verifica-se o valor atual valor corrente do temporizador para saber ultrapassou o delay
	blo show_result_by_delay_s						
	pop r5
	pop r4
	pop pc
;-------------------------------------
isr:
	push r0
	push r1
	ldr r1, PTC_ADDR
	strb r1, [r1, #PTC_TIR]				; escrita para limpar pedido de interrupção
	ldr	r0, sysclk_addr_isr
	ldr r1, [r0]
	add	r1, r1, #1
	str r1, [r0]
	pop	r1
	pop	r0
	movs pc, lr
;-------------------------------------
sysclk_addr_isr:
	.word sysclk
;-------------------------------------
ptc_start:
    ldr r0, PTC_ADDR
    mov r1, #PTC_CMD_START
    strb r1, [ r0, #PTC_TCR ]
    mov pc, lr
;-------------------------------------
ptc_init:
	push lr
	push r0
	push r1
	push r4
	mov r4, r0
	bl ptc_stop
	ldr	r1, PTC_ADDR
	strb r4, [r1, #PTC_TMR]				; escrita para definir o valor do match register
	strb r4, [r1, #PTC_TIR]				; escrita para limpar pedido de interrupção
	bl ptc_start
	pop r4
	pop r1
	pop r0
	pop pc
;-------------------------------------
ptc_stop:
	ldr	r0, PTC_ADDR
	mov	r1, #PTC_CMD_STOP
	strb	r1, [r0, #PTC_TCR]
	mov	pc, lr
;-------------------------------------
ptc_get_value:
	ldr	r1, PTC_ADDR
	ldrb r0, [r1, #PTC_TC]
	mov	pc, lr
;-------------------------------------
PTC_ADDR:
	.word PTC_ADDRESS
;-------------------------------------
inport_read:
	ldr	r1, inport_addr
	ldrb r0, [r1]
	mov	pc, lr

inport_addr:
	.word	INPORT_ADDRESS
;-------------------------------------
outport_init:
	push	lr
	ldr	r1, outport_img_addr
	strb	r0, [r1]
	bl	outport_write
	pop	pc
;-------------------------------------
outport_write:
	ldr	r1, outport_addr
	strb r0, [r1, #0]
	mov	pc, lr
;-------------------------------------
outport_addr:
	.word OUTPORT_ADDRESS
;-------------------------------------
outport_set_bits:
	push lr
	ldr	r1, outport_img_addr
	ldrb r2, [r1, #0]
	orr	r0, r2, r0
	strb r0, [r1, #0]
	bl outport_write
	pop	pc
;-------------------------------------
outport_clear_bits:
	push lr
	ldr	r1, outport_img_addr
	ldrb	r2, [r1, #0]
	mvn	r0, r0
	and	r0, r2, r0
	strb	r0, [r1]
	bl	outport_write
	pop	pc
;-------------------------------------
outport_img_addr:
	.word outport_img
sysclk_get_ticks:
	ldr	r0, sysclk_addr
	ldr	r0, [r0]
	mov pc, lr

sysclk_addr:
	.word	sysclk

; Seccao:    data
; Descricao: Guarda as variáveis globais com um valor inicial definido
;
	.data
array:
	.word 100, 100, 200, 300, 400, 500, 600, 700, 800, 900, 900, 900, 900, 900, 900, 900

; Seccao:    bss
; Descricao: Guarda as variáveis globais sem valor inicial definido
;
	.bss
sysclk:
	.space	2
outport_img:
	.space	1
	.align
; Seccao:    stack
; Descricao: Implementa a pilha com o tamanho definido pelo símbolo STACK_SIZE
;
	.stack
	.space	STACK_SIZE
tos:
