			.global itoa

			.equ div10_magic, 0xcccccccd

			.text
@ itoa(buffer, n) -> number of bytes writte

itoa:
			push {r4,r5,r6,lr}
			@r0: buffer
			@r1: n
			@r2: length of output
			@r3: division magic number
			@r4: digit
			@r5: new n
			ldr  	 r3, =div10_magic
			mov	 r2, #0
1:	
			@do a division by 10
			umull 	 r4, r5, r3, r1			@multiply by magic number
			mov 	 r5, r5, lsr #3			@shift: new_n is in r5
			add	 r4,r5,r5,lsl #2		@compute new_n * 5
			sub 	 r4,r1,r4,lsl #1		@remainder = n - new_n *5*2
			add	 r4, r4, #'0'
			strb	 r4, [r0,r2]			@^convert to digit
			add	 r2, r2, #1			@^store in buffer
			subs	 r1, r5, #0			@^length ++
			bgt	 1b				@^n = newn and compare with 0

			@r3 =f i
			@r4 = j
			@r1 = temp_a
			@r5 = temp_b
			mov	 r3, #0				@i = 0
			sub 	 r4, r2, #1				@j = len(buffer -1)
			b 	 3f				@goto test
2:								@do operation as long as condition (3) is met
			ldrb	 r1, [r0, r3]				@buffer[i] >> temp_a
			ldrb	 r5, [r0, r4]				@buffer[j] >> temp_b
			strb	 r1, [r0, r4]				@temp_a >> buffer[j]
			strb	 r5, [r0, r3]				@temb_b >> buffer[i]	
			add      r3, r3, #1                             @i ++
	                sub      r4, r4, #1                             @j --
3:								@test
			cmp	 r3, r4 				@if i<j
			blt	 2b						@i++
										@j--
			@ return number of bytes written
			mov	 r0, r2
			pop	 {r4, r5, r6, pc}
