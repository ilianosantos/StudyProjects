str2nat:
    push lr
    push r4
    push r5
    push r6
    push r7
    mov r4, r0
    mov r5, r1
    mov r2, #0
    mov r3, #0
    mov r6, #0
str2nat_loop:
    mov r7, #0
    cmp r3, r7
    bne str2nat_return
    mov r7, #'\0'
    ldrb r0, [r4, r6] 
    cmp r0, r7
    beq str2nat_return
    bl char2nat
str2nat_if:
    mov r7, #NAN & 0xFF
    movt r7, #(NAN >> 8) & 0xFF
    cmp r0, r7
    bne str2nat_else
    mov r2, r7
    mov r3, #1
    b str2nat_add
str2nat_else:
    mov r7, #0
    str r0, [r6, r7] ;valor do r6 e r7 é igual após chamada à rotina multiply
    bl multiply_while
    ldr r7, [r6, r7] ;recupera-se o valor anteriormente guardado
    add r2, r0, r7
    b str2nat_add
str2nat_add:
    add r6, r6, #1
    b str2nat_loop
str2nat_return:
    pop r7
    pop r6
    pop r5
    pop r4
    pop pc
multiply_while:
    cmp r3, r7 ;sempre que r3 estiver no else será sempre 0
    bhs while_end
    add r2, r2, r1
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
