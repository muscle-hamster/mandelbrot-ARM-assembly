                .global mandel

                .text

@ mandel(maxiters, x, y) -> iters
mandel:
	fldd		d7, four		@load 4.0 into d0 -> four created at bottom
	mov		r1, r0			@move max iterations into r1
	mov		r0, #1			@move max iterations 1 into r0
	fcpyd		d2, d0			@copy x into a
	fcpyd		d3, d1			@copy y into b

1:	@forever loop
	fcpyd		d4, d2			@copy a into d4 to prepare to square
	fmuld		d4, d4, d4		@multiply a by a into d4
	fcpyd		d5, d3			@copy b into d5 to prepare to square
	fmuld		d5, d5, d5		@multiply b by b in b^2
	faddd		d6, d4, d5		@add a^2 and b^2
	fcmpd		d6, d7			@compare to see if a^2 + b^2 >= 4
	fmstat					@set flags
	blt		2f
	mov		pc, lr

2:	add		r0, r0, #1		@increment iterations
	cmp		r0, r1			@compare to see if iterations is more than max iters
	ble		3f
	mov		r0, #0			@move #0 into r0
	mov		pc, lr

3:	faddd		d2, d2, d2		@computing 2a
	fmuld		d3, d3, d2		@multiplying 2a x b
	faddd		d3, d3, d1		@add y into equation
	fsubd		d2, d4, d5		@sub a2 & b2
	faddd		d2, d2, d0		@add x
	b		1b

four:	.double 4.0
