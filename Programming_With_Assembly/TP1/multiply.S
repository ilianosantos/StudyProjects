multiply:
	mov r2, #0
while:
	mov r3, #0
	cmp r3, r1
	bhs while_end
	add r2, r2, r0
	sub r1, r1, #1
	b while
while_end:
	mov r0, r2
	mov pc, lr
