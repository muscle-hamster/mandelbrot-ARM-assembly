#include "gtest/gtest.h"

extern "C" int getColor(int iters);
extern "C" int regwrapper(int iters);
extern "C" int (*target_function)(int iters);
extern "C" int bad_register;

TEST(getColor, all) {
    target_function = getColor;

    // 0 -> black
    int n = regwrapper(0);
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);

    // reds
    n = regwrapper(1);
    EXPECT_EQ(0x0f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(2);
    EXPECT_EQ(0x1f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(16);
    EXPECT_EQ(0xff0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(31);
    EXPECT_EQ(0x0f0000, n);
    EXPECT_EQ(0, bad_register);

    // blues
    n = regwrapper(32);
    EXPECT_EQ(0x00000f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(33);
    EXPECT_EQ(0x00001f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(47);
    EXPECT_EQ(0x0000ff, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(61);
    EXPECT_EQ(0x00001f, n);
    EXPECT_EQ(0, bad_register);

    // overflow back into reds
    n = regwrapper(63);
    EXPECT_EQ(0x0f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(64);
    EXPECT_EQ(0x1f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(78);
    EXPECT_EQ(0xff0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(93);
    EXPECT_EQ(0x0f0000, n);
    EXPECT_EQ(0, bad_register);

    // and into blues again
    n = regwrapper(94);
    EXPECT_EQ(0x00000f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(95);
    EXPECT_EQ(0x00001f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(109);
    EXPECT_EQ(0x0000ff, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(123);
    EXPECT_EQ(0x00001f, n);
    EXPECT_EQ(0, bad_register);

    // and again
    n = regwrapper(125);
    EXPECT_EQ(0x0f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(126);
    EXPECT_EQ(0x1f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(140);
    EXPECT_EQ(0xff0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(155);
    EXPECT_EQ(0x0f0000, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(156);
    EXPECT_EQ(0x00000f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(157);
    EXPECT_EQ(0x00001f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(171);
    EXPECT_EQ(0x0000ff, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(185);
    EXPECT_EQ(0x00001f, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(413);
    EXPECT_EQ(0x00009f, n);
    EXPECT_EQ(0, bad_register);
}
