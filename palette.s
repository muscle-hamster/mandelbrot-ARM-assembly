                .global palette, palette_size, black

                .data
palette:
                @ reds
                .word   0x0f0000
                .word   0x1f0000
                .word   0x2f0000
                .word   0x3f0000
                .word   0x4f0000
                .word   0x5f0000
                .word   0x6f0000
                .word   0x7f0000
                .word   0x8f0000
                .word   0x9f0000
                .word   0xaf0000
                .word   0xbf0000
                .word   0xcf0000
                .word   0xdf0000
                .word   0xef0000
                .word   0xff0000
                .word   0xef0000
                .word   0xdf0000
                .word   0xcf0000
                .word   0xbf0000
                .word   0xaf0000
                .word   0x9f0000
                .word   0x8f0000
                .word   0x7f0000
                .word   0x6f0000
                .word   0x5f0000
                .word   0x4f0000
                .word   0x3f0000
                .word   0x2f0000
                .word   0x1f0000
                .word   0x0f0000

                @ blues
                .word   0x00000f
                .word   0x00001f
                .word   0x00002f
                .word   0x00003f
                .word   0x00004f
                .word   0x00005f
                .word   0x00006f
                .word   0x00007f
                .word   0x00008f
                .word   0x00009f
                .word   0x0000af
                .word   0x0000bf
                .word   0x0000cf
                .word   0x0000df
                .word   0x0000ef
                .word   0x0000ff
                .word   0x0000ef
                .word   0x0000df
                .word   0x0000cf
                .word   0x0000bf
                .word   0x0000af
                .word   0x00009f
                .word   0x00008f
                .word   0x00007f
                .word   0x00006f
                .word   0x00005f
                .word   0x00004f
                .word   0x00003f
                .word   0x00002f
                .word   0x00001f
                .word   0x00000f

palette_size:   .word   (.-palette) / 4

black:          .word   0
