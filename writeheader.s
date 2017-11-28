                .global writeHeader

                .text
@ writeHeader(buffer, x, y) -> number of bytes written
writeHeader:
	push {r4, r5, r6, r7, r11, lr}
	@r0: buffer		@buffer of writeheader
	@r1: xValue		@xValue of writeheader
	@r2: yValue		@yValue of writeheader

	@move parameters to non-scratch registers
	@r4 = buffer
	@r5 = xValue
	@r6 = yValue
	@r7 = length of output
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	mov	r7, #0
	b	1f

1:
	@writes P3\n to buffer
	add	r8, #'P'		@pushes 'P' into r8
	str	r8, [r4, r7]		@stores the value from r8 to the place r4+r7 in buffer
	add	r7, #1			@using r7 as the count... adds one to r7 so we can keep track of the memory position
	mov	r8, #0			@clears r8
	add	r8, #'3'		@push 3 into r8
	strb	r8, [r4, r7]		@stores 3 into buffer
	add	r7, #1			@adds 1 to the count to add to buffer
	mov	r8, #0			@clears r8
	add	r8, #'\n'		@adds \n into r8
	strb	r8, [r4, r7]		@stores r8 to buffer
	mov	r8, #0			@clears r8
	add	r7, #1			@adds 1 to count
	b	2f			@goes to next step

2:
	@writes xValue to header
	add	r0, r4, r7		@copies buffer + count to r0 as first parameter for itoa
	mov	r1, r5			@adds x value to r1 as second parameter for itoa
	bl	itoa			@calls itoa
	add	r7, r0			@adds the length of the buffer to the count
	add	r8, #' '
	strb	r8, [r4, r7]
	mov	r8, #0			@clears r8
	add	r7, #1			@adds one to buffer length
	b	3f			@goes to next step

3:
	@writes yValue to header
	add	r0, r4, r7
	mov	r1, r6
	bl	itoa
	add	r7, r0
	add	r8, #'\n'
	strb	r8, [r4, r7]
	mov	r8, #0
	add	r7, #1
	b	4f

4:
	@writes 255 (max_color_value) to header
	mov	r8, #'2'
	str	r8, [r4, r7]
	add	r7, #1
	mov	r8, #'5'
	str	r8, [r4, r7]
	add	r7, #1
	mov	r8, #'5'
	str	r8, [r4, r7]
	add	r7, #1
	mov	r8, #'\n'
	str	r8, [r4, r7]
	add	r7, #1
	mov	r8, #0
	@return number of bytes written
	mov	r0, r7
	pop	{r4, r5, r6, r7, r11, pc}
	
	
