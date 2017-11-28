                .global writeRGB

                .text
@ writeRGB(buffer, rgb) -> number of bytes written
writeRGB:

	push {r4, r5, r6, lr}
	@r0: buffer			@buffer of writeRGB
	@r1: RGB value			@second parameter of write header

	@move parameters into non-scratch registers
	@r4: new buffer moved from r0
	@r5: new RGB value being passed in from write RGB
	@r6: length of output
	
	mov 	r4, r0
	mov 	r5, r1
	mov	r6, #0
	b	1f

1:	
	@writes single RGB value to buffer
	@starting with red value

	@r7 mask for RGB value
	@r8 temporary working register to mask value and move back into r5

	mov	r8, #0
	add	r8, r5
	mov	r7, #0
	add	r7, #0xFF		@here is the mask. Needs to be lsr to get desired color
	and	r8, r7, r8, lsr #16	@here we are applying the mask to the original color to get the red value
	mov	r0, r4
	mov	r1, r8
	bl	itoa
	add	r6, r0
	mov	r8, #0
	mov	r8, #' '
	strb	r8, [r4, r6]
	add	r6, #1
	mov 	r8, #0
	mov	r8, r5
	and	r8, r7, r8, lsr #8
	mov	r0, r4
	add	r0, r0, r6
	mov	r1, r8
	bl 	itoa
	add	r6, r0
	mov	r8, #0
	mov	r8, #' '
	strb	r8, [r4, r6]
	add	r6, #1
	mov	r8, #0
	mov	r8, r5
	and	r8, r7, r8
	mov	r0, r4
	add	r0, r0, r6
	mov	r1, r8
	bl	itoa
	add	r6, r0
	mov	r8, #0
	mov	r7, #0
	
	mov r0, r6
	pop {r4, r5, r6, pc}
	
