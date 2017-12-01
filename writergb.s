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

	mov	r8, #0			@clear whats in register 8
	add	r8, r5			@move passed in RGB value from r5 to r8 for manipulation
	mov	r7, #0			@clear r7 to prepare for the mask
	add	r7, #0xFF		@here is the mask. Needs to be lsr to get desired color
	and	r8, r7, r8, lsr #16	@here we are applying the mask to the original color to get the red value
	mov	r0, r4			@move buffer into r0 as first parameter for itoa.s
	mov	r1, r8			@move masked RGB value into r1 as second parameter for itoa. this is the value that will be converted from integer to ASCII
	bl	itoa			@call itoa
	add	r6, r0			@clear r6 to allow us to keep an accurate count of whats been added to buffer
	mov	r8, #0			@clear r8
	mov	r8, #' '		@add ascii value for space into r8
	strb	r8, [r4, r6]		@store r8 at end of buffer
	add	r6, #1			@add one to the buffer count
	mov 	r8, #0			@clear r8
	mov	r8, r5			@move new copy of passed in RGB value to r8
	and	r8, r7, r8, lsr #8	@apply mask for green value
	mov	r0, r4			@move r4 into position to be used as itoa parameter
	add	r0, r0, r6		@add lenght of count to buffer so itoa returns in correct position
	mov	r1, r8			@push masked green value into r1 as second parameter in itoa
	bl 	itoa
	add	r6, r0			@add to buffer count
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
	mov	r8, #0			@clear r8 before termination of program to avoid future errors
	mov	r7, #0			@clear r7 before termination of program to avoid future errors
	
	mov r0, r6			@move count into r0 to be returned as buffer count
	pop {r4, r5, r6, pc}		@pop r4, r5, r6 off of stack restore to original values
	
