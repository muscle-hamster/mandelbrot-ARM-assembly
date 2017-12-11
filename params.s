                .global filename
                .global xcenter, ycenter, mag
                .global xsize, ysize, iters

                .data
filename:       .asciz  "fractal.ppm"

                .balign 8
xcenter:        .double -0.743643135
ycenter:        .double 0.131825963
mag:            .double 91152.0
xsize:          .word   128
ysize:          .word   200
iters:          .word   1000
