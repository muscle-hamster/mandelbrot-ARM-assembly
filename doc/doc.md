Dynamic Mandelbrot
==================

In this step you will update your Mandelbrot fractal generator to
create images of any size, zoomed in at any location.

`params.s` has been updated for you to include more parameters:

*   filename: the name of the output file to create. You will change
    your code to get this parameter here instead of wherever you had
    it before.
*   xcenter: this is a 64-bit float value specifying the center
    point of the image to create.
*   ycenter: this is a 64-bit float value specifying the center
    point of the image to create.
*   mag: the magnification level to apply when generating the image.
*   xsize: the size of the image to create, in pixels. You will
    change your code to use this value instead of having it
    hard-coded as 256.
*   ysize: the size of the image to create, in pixels. You will
    change your code to use this value instead of having it
    hard-coded as 256.
*   iters: the maximum number of iterations to apply when computing
    a pixel. You will change your code to use this value instead of
    having it hard-coded.

You may change the values in order to generate different images, but
do not change the *names* of any of these parameters.


Changing the image size
-----------------------

Everything defined in `params.s` is exported as a global variable.
It would be nice to accept these parameters as command-line options,
but parsing them would be a lot of work. To simplify things, we hard
code them as global variables. However, you should treat them as
though they were local variables in your `run` function, and pass
them as needed to other functions.

With this step completed, you should be able to generate a valid
`fractal.ppm` file whose size is dictated by `params.s`.


Using the stack for arguments
-----------------------------

When a function has more than four integer arguments, additional
parameters must be passed in on the stack. For example, calling a
function `sum` that takes five arguments might look like:

``` asm
mov     r0, #50
push    {r0,r1}
mov     r0, #10
mov     r1, #20
mov     r2, #30
mov     r3, #40
bl      sum
add     sp, sp, #8
```

In this example, we put the fifth parameter (#50) onto the stack
first, then load the other four values into r0–r3. Because the stack
must always have an even number of elements, we push an addition
junk value after r0 (r1 in this case).

After the function call completes, we throw away the values on the
stack by adding 8 to the stack pointer. We could pop them off
instead, but then we would have to pop them into some registers.
Since we do not actually care about those values any more, we just
discard them instead.

The following would be another way of accomplishing the same thing:

``` asm
sub     sp, sp, #8
mov     r0, #50
str     r0, [sp]
mov     r0, #10
mov     r1, #20
mov     r2, #30
mov     r3, #40
bl      sum
add     sp, sp, #8
```

If we had seven integer parameters so three of them needed to go on
the stack, we could use:

``` asm
sub     sp, sp, #16     @ always keep sp a multiple of 8
mov     r0, #50
str     r0, [sp]
mov     r0, #60
str     r0, [sp,#4]
mov     r0, #70
str     r0, [sp,#8]
```

and then load the first four parameters in r0–r3 as usual.

The function that is being called can access those values by loading
them directly from the stack. Note that it must also account for any
changes it makes to the stack. For example:

``` asm
sum:
        push    {ip,lr}         @ pushing 8 bytes onto the stack
        add     r0, r0, r1      @ get the sum of r0 through r3
        add     r2, r2, r3
        add     r0, r0, r2
        ldr     r1, [sp, #8]    @ parameter number 5
        ldr     r2, [sp, #12]   @ parameter number 6
        ldr     r3, [sp, #16]   @ parameter number 7
        add     r1, r1, r2
        add     r1, r1, r3
        add     r0, r0, r1
        pop     {ip,pc}
```

Since `sum` starts by pushing 8 bytes onto the stack (two
registers), it has effectively subtracted 8 from the stack pointer
it was given. Since its fifth parameter was the first item on the
stack when it was called, that fifth parameter is now 8 bytes past
the beginning of the stack. Likewise, the sixth parameter is 12
bytes past the beginning, and the seventh parameter is 16 bytes past
the beginning. After the push instruction, the stack looks like:

    | ...           |
    +---------------+
    | parameter 7   |
    +---------------+
    | parameter 6   |
    +---------------+
    | parameter 5   |
    +---------------+
    | saved lr reg  |
    +---------------+
    | saved ip reg  |
    +---------------+ <--- sp points here

where each box is 4 bytes in size.


Changing the center and zoom level
----------------------------------

The major change for this step is in `calcPixel`. Before, it acted
as a function:

* `calcPixel(maxiters, column, row)` → `rgb`

You must modify it to accept additional parameters:

* `calcPixel(maxiters, column, row, xsize, ysize, xcenter, ycenter, magnification)` → `rgb`

Recall that the first four integers parameters are passed in the
integer registers (5 are needed here), and float parameters are
passed in the d registers, starting with d0. Since there are more
integer parameters than will fit in the first four integer
registers, you must pass the fifth integer parameter on the stack as
described above.

Modify your `run` function to pass the correct parameters to
`calcPixel`. Note that only column and row will change from pixel to
pixel, but you must pass all of the other parameters in with each
call.

Update `calcPixel` to compute the X and Y values to be passed along
to your `mandel` function. Here are the formulas to compute them:

* `x = xcenter + (column - xsize/2.0) / (magnification * (minsize - 1))`
* `y = ycenter - (row - ysize/2.0) / (magnification * (minsize - 1))`

We will talk in class about how these formulas are derived.

Some of these values are integers, and some are floats. It is okay
to compute `minsize - 1` using integer instructions, but all other
math operations (include `xsize/2.0` and `ysize/2.0` should be
performed using floating point instructions, after converting the
integer values into floats as necessary.

`minsize` refers to the smaller of xsize and ysize. The
magnification of the image is based on the largest square that fits
completely in the generated image, and then additional bars will be
rendered on the top and bottom or left and right sides, depending on
whether the image has portrait or landscape dimensions.

Note that both X and Y require division by the same value:
`(magnification * (minsize - 1))`. Compute it once, and use it twice
when computing X and Y.

In general, the results of a computation using finite-precision
floats will be more accurate this way. Computing a single large
value and dividing it by another single large value is better than
computing a small value, dividing it by a large value (giving a very
small value with round errors), and then multiplying it by something
large. The general strategy is to avoid having any intermediate
results where significant precision is lost to rounding errors.
Sometimes re-arranging the order of computations can yield more
accurate results. Mandelbrot fractals are one place where we push up
against the limits of 64-bit floats, so it is worth worrying about
these issues.

If you plan it carefully, it is pretty straightforward to compute
the required values and then call `mandel` and `getColor` as before.
