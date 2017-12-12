                .global calcPixel
		
                .text
	@ calcPixel(maxiters, col, row) -> rgb
	@ Notes for registers
calcPixel:


	push		{r4, r5, r6, lr}
	ldr		r4, [sp, #16]		@y from stck
	fldd		d3, two			@load 255 constant into d3
	
	cmp		r3, r4			@find the minimum	
	movle		r5, r3
	movgt		r5, r4
	
	sub 		r5, r5, #1		@minimum size -1.. calc denom (mag * (minsize -1))
	vmov		s13, r5			@put r5-1 into s13
	fsitod		d6, s13			@convert s13 to float
	fmuld		d6, d6, d2		@magnification * (minimum_size -1)
	
	vmov		s9, r3			@xsize to float / 2
	fsitod		d4, s9
	fdivd		d4, d4, d3		@divide d4 by d3
	
	vmov		s11, r4			@convert to float... y size same as x
	fsitod		d5, s11	
	fdivd		d5, d5, d3		@float / 2
	
	vmov		s15, r1
	fsitod		d7, s15
	fsubd		d7, d7, d4		@sub d4 from float
	
	vmov		s17, r2
	fsitod		d8, s17
	fsubd		d8, d8, d5		@subtract d5 from float
	
	fdivd		d7, d7, d6		@divide d7 by d6 to find x center
	fdivd		d8, d8, d6
	
	faddd		d0, d0, d7
	fsubd		d1, d1, d8

	bl		mandel
	bl		getColor

	pop		{r4, r5, r6, pc}



two:		.double 2.0
