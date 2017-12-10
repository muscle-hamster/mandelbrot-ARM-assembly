@ The code starting here is just to help you test your code in a
@ standalone program. It is not part of the assignment.

                .global _start
                .equ    sys_exit, 1

                .text
_start:
                @ load a test case for getColor
                mov     r0, #iters1
                bl      getColor

                mov     r7, #sys_exit
                svc     #0

                @ this is the default test case
                @ test this first: getColor should return 0x00000f,
                @ and the exit status code should be 15
                .equ    iters1, 32

                @ test this second: getColor should return 0x00001f,
                @ and the exit status code should be 31
                .equ    iters2, 123

                @ test this third: getColor should return 0x000000,
                @ and the exit status code should be 0
                .equ    iters3, 0
