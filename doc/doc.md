Color
=====

To add colors, you must re-write `getColor` to convert the number of
iterations required into a color. I have provided a sample palette
to use for this project in `palette.s`. When generating your own
images, you should experiment with different palettes to customize
your images.

`getColor` has the same function signature as before: it accepts a
number of iterations as its only parameter, and it returns an RGB
value. Before, it converted the number of iterations into a shade of
gray, where the number of iterations was directly mapped to the
intensity of the pixel.

Using a color palette, the number of iterations is used as an index
into a list of colors. One iteration translates into the first color
in the palette, two iterations into the second color, etc. When
`getColor` runs out of colors in the palette, it wraps around and
starts over with the first color again.

Zero iterations is the sentinel value we used to indicate that the
Mandelbrot calculation never exceeded the bailout value. `getColor`
should check for this as a special case, and return the value of
`black` as defined in `palette.s`. `black` is defined as zero (the
color black), and is named `black`, but you can change this color as
part of the palette. For convenience, the instructions will refer to
this color as black, even though you could change it to something
else.

For all other iteration values, it should look up a color using:

* `colorIndex = (iterations - 1) % palette_size`

Use the `remainder` function you wrote in the previous step to make
this calculation.

Once you have computed the color index, you should load the
corresponding color from the palette. Remember the each color value
is 32 bits (4 bytes), so you must account for that when looking up
values inside the palette.
