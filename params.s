                .global filename, xsize, ysize, iters
                .data

filename:       .asciz  "fractal.ppm"

                .balign
xsize:          .word   7
ysize:          .word   7
iters:          .word   255
