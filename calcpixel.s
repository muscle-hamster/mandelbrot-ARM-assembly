                .global calcPixel
		.equ	negativeOne, -1
                .text
@ calcPixel(maxiters, col, row) -> rgb
calcPixel:


	push		{ip, lr}
	fldd		d3, constant		@load 255 constant into d3
	fldd		d4, four		@load divisor 4 into d4
	fdivd		d3, d3, d4		@d3 = 255/4
	
	sub 		r1, r1, #128		@sub col-128
	vmov		s10, r1			@put r1 into s10
	fsitod		d0, s10			@convert s10 to float
	fdivd		d0, d0, d3		@divide d0 by d3
	sub		r2, r2, #128		@sub row - 128
	ldr		r3, =negativeOne	@load negative 1
	mul		r2, r2, r3		@multiply r2 by -1
	vmov		s10, r2			@convert to float
	fsitod		d1, s10	
	fdivd		d1, d1, d3		@finish math on equation (row - 128)/(255/4)

	bl		mandel
	bl		getColor

	pop		{ip,pc}


constant:	.double 255.0

four:		.double 4.0
