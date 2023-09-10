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
