                .global remainder

                .text
@ remainder(numerator, denominator) -> remainder
remainder:

	push		{r4, lr}
	cmp		r0, r1			@compare and make sure n < d
	
	bne		1f			@only brach if not equal to 
	mov		r0, #0			@if equal to there is no remainder. Put 0 into r0 and return
	pop		{r4, pc}
	bgt		1f			@only want to branch if remainder is pos. safety net. should never have neg remainder
	pop		{r4, pc}

1:	clz		r3, r0			@find the number of leading zeros in denominator 
	clz		r4, r1			@find the number of leading zeros in numerator... clz not in class docs. found on infocenter.arm.com
	sub		r2, r4, r3		@subtract leading zeros in num and leading 0 in denom
	b		3f

2:
	cmp		r0, r1, lsl r2		@if numerator is gr or eq to denom shift left
	subge		r0, r0, r1, lsl r2	@num - denom lsl 2
	sub		r2, r2, #1		@shift = shift -1

3:
	cmp		r2, #0			@loop while shift is ge 0
	bge		2b	

	pop		{r4, pc}
