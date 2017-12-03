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

	@ run() -> exit code
run:

	@ your code goes here
	@r4 = buffer
	@r5 = bufferlength
	@r6 = fd
	@r7 = system call
	@r8 = column
	@r9 = color
	@r10 = xSize
	@pseudo code for opening a file
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	ldr	r0, =filename						@how do I call filename from params
	ldr	r1, =flags		@defined in global variables
	ldr	r2, =mode		@defined in global variables
	mov	r7, #sys_open		@system call to open file
	svc	#0			@initiate system call
	cmp	r0, #0			@compare what is returned to 0. If it is less than 0 we need to return fail open
	mov	r6, #0
	mov	r6, r0
	bge	1f			@branch to next step if return is positive
	ldr	r0, =fail_open		@else return error code fail open
	pop	{r4, r5, r6, pc}	@pop stack


1:		@pseudo code for calling write header
	ldr	r0, =buffer						@load buffer
	ldr	r1, =xsize						@load address of xSize
	ldr	r1, [r1]						@load value of xSize
	ldr	r2, =ysize						@load address of ySize
	ldr	r2, [r2]						@load value of ySize
	bl	writeHeader						@branch to writeheader
	cmp	r0, #0							@compare r0 to #0 if neg num returned return error
	mov	r5, #0
	mov	r5, r0
	bge	3f							@branch if r0 >= 0
	ldr	r0, =fail_writeheader					@otherwise return error code
	mov	r6, #0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}


2:		@pseudo code for writing to a file
	mov	r0, r6							@move file descriptor into r0
	ldr	r1, =buffer						@load buffer into r1
	mov	r2, r5							@load buffer length into r5
	mov	r7, #sys_write						@load system write call into r7
	svc	#0							@run system load command
	cmp	r0, #0							@compare to make sure it ran right
	bge	3f							@branch if it ran right
	ldr	r0, =fail_writeheader					@return error if it returned wrong
	mov	r6, #0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}

3:		@code for writing a single row of pixels
	ldr	r4, =buffer						@loads buffer into r4
	add	r4, r5							@adds buffer and length
	mov	r0, r4							@moves buffer + length into r0
	mov	r1, #0							@clears out r1	
	add	r1, r9, lsl #8						@creates color... always use lsl #8 on column and put into r1
	bl	writeRGB					
	add	r5, r0							@add writeRGB length to length of function
	mov	r8, #' '						@puts space into r8
	strb	r8, [r4, r0]						@stores r8 into buffer
	add	r5, #1							@add one to length
	add	r9, #1							@add one to column
	b	LC							@branch to loop condition test

LC:		@loop condition check
	ldr	r10, = xsize						@load size into r10
	ldr	r10, [r10]						@convert from address to value
	cmp	r9, r10							@compares column with xSize
	blt	3b							@branches if less than
	mov	r8, #'\n'						@put '\n' in r8		
	strb	r8, [r4, r0]						@store in buffer[length - 1]
	bge	4f							@branch to write file

4:		@write color string to file
	mov	r0, r6							@move fd into r0
	ldr	r1, =buffer
	mov	r2, r5							@move length into r2
	ldr	r7, =sys_write				
	svc	#0
	cmp	r0, #0
	bge	5f
	ldr	r0, =fail_writerow
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
	
5:		@pseudo code for closing file
	mov	r0, r6							@load file descriptor into r0
	mov	r7, #sys_close						@load system close command into r7
	svc	#0							@call system close command
	cmp	r0, #0							@check to make sure it returned properly
	bge	6f							@branch if it did
	ldr	r0, =fail_close
	mov	r5, #0
	mov	r6, #0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}

6:
	mov	r5, #0
	mov	r6, #0
	mov	r7, #0
	mov	r0, #0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}

	.bss
buffer:	         .space 64*1024
