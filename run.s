	.global run

	.equ    flags, 577
	.equ    mode, 0644

	.equ    sys_write, 4
	.equ    sys_open, 5
	.equ    sys_close, 6

	.equ    fail_open, 1
	.equ    fail_writeheader, 2
	.equ    fail_writerow, 3
	.equ    fail_close, 4

	.text

	@r4 = fd
	@r5 = bufsize
	@r9 = xsize
	@r10 = ysize
	@r11 = row size
	@r12 = col

	@ run() -> exit code
run:
	push	{r4, r5, r7, r8, r9, r10, r11, lr}
	ldr	r0, =filename
	ldr	r1, =flags
	ldr	r2, =mode
	mov	r7, #sys_open
	svc	#0
	mov	r4, r0
@---------------------------------------------------
	bgt	1f
@---------------------------------------------------	
	mov	r0, #fail_open
	pop	{r4, r5, r7, r8, r9, r10, r11, pc}
1:
	
	ldr	r0, =buffer
	ldr	r1, =xsize
	ldr	r1, [r1]
	ldr	r2, =ysize
	ldr	r2, [r2]
	bl	writeHeader
	mov	r2, r0
	ldr	r1, =buffer
	mov	r0, r4
	mov	r7, #sys_write
	svc	#0
@------------------------------------------------------
	cmp	r0, #0
	bge	2f
	mov	r0, #fail_writeheader
	pop	{r4, r5, r7, r8, r9, r10, r11, pc}


2:	@code to set up row loop
	ldr 	r10, =ysize
	ldr	r10, [r10]
	mov	r11, #0
	b	6f


3:	@code to set up column loop
	mov	r5, #0
	mov	r12, #0
	ldr	r9, =xsize
	ldr	r9, [r9]
	b	5f

4:	mov	r1, #0
	mov	r2, #0
	ldr	r0, =buffer
	add	r1, r12, lsl #8
	add	r2, r11, lsl #16
	add	r1, r1, r2
	add	r0, r0, r5
	bl	writeRGB
	add	r5, r5, r0
	mov	r1, #' '
	ldr	r0, =buffer
	strb	r1, [r0, r5]
	add	r12, r12, #1
	add	r5, r5, #1

5:	cmp	r12, r9
	blt	4b
	
	mov	r1, #'\n'
	sub	r2, r5, #1
	strb 	r1, [r0,r2]

	mov	r1, r0
	mov	r0, r4
	mov	r2, r5
	mov	r7, #sys_write
	svc	#0
	add	r11, r11, #1
	bge	6f

	mov	r0, #fail_writerow
	pop	{r4, r5, r7, r8, r9, r10, r11, pc}

6:	cmp	r11, r10
	blt	3b

7:
	mov	r0, r4
	mov	r7, #sys_close
	svc	#0

	cmp	r0, #0
	bge	8f
	mov	r0, #fail_close
	pop	{r4, r5, r7, r8, r9, r10, r11, pc}
8:	
	mov	r0, #0
	pop	{r4,r5,r7,r8,r9,r10,r11,pc}

		.bss
buffer:		.space 64*1024
