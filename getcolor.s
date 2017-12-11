                .global getColor

                .text
@ getColor(iters) -> rgb
getColor:
	push		{ip, lr}

	cmp		r0, #0
	bne		1f
	ldr		r0, =black
	ldr		r0, [r0]		@get value from r0
	pop		{ip, pc}

1:
	sub		r0, r0, #1		@get iterations -1
	ldr		r1, =palette_size	@get pallet size
	ldr		r1, [r1]		@load pallet size value into r1
	bl		remainder		@call remainder


	ldr		r1, =palette		@load palette into r1
	ldr		r2, [r1, r0, lsl #2]	@=palette(color*4)
	mov		r0, r2

	pop		{ip, pc}
