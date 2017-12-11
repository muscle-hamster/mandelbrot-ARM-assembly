#include "gtest/gtest.h"
#include <inttypes.h>

extern "C" int calcPixel(int maxiters, int column, int row, int xsize, int ysize, double xcenter, double ycenter, double mag);
extern "C" int regwrapper(int maxiters, int column, int row, int xsize, int ysize, double xcenter, double ycenter, double mag);
extern "C" int (*target_function)(int maxiters, int column, int row, int xsize, int ysize, double xcenter, double ycenter, double mag);
extern "C" int bad_register;

TEST(dynamicimage, calcPixel1) {
    target_function = calcPixel;

    int rgb = regwrapper(1000, 394, 193, 407, 405, -0.743643135, 0.131825963, 40786.41);
    EXPECT_EQ(0x7f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 66, 355, 176, 652, -0.743643135, 0.131825963, 75967.85);
    EXPECT_EQ(0x00009f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 259, 106, 415, 424, -0.743643135, 0.131825963, 78266.43);
    EXPECT_EQ(0x00005f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 509, 239, 950, 1040, -0.743643135, 0.131825963, 49402.58);
    EXPECT_EQ(0xcf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 373, 133, 470, 838, -0.743643135, 0.131825963, 68538.21);
    EXPECT_EQ(0x0000ef, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 674, 237, 813, 925, -0.743643135, 0.131825963, 58666.88);
    EXPECT_EQ(0x00004f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 502, 159, 895, 870, -0.743643135, 0.131825963, 15246.57);
    EXPECT_EQ(0xdf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 213, 191, 413, 931, -0.743643135, 0.131825963, 77637.79);
    EXPECT_EQ(0xcf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 148, 97, 981, 1061, -0.743643135, 0.131825963, 43329.01);
    EXPECT_EQ(0x0000df, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 133, 42, 702, 659, -0.743643135, 0.131825963, 83774.52);
    EXPECT_EQ(0x00004f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 45, 526, 315, 653, -0.743643135, 0.131825963, 79515.70);
    EXPECT_EQ(0x0000cf, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 54, 211, 101, 699, -0.743643135, 0.131825963, 12359.66);
    EXPECT_EQ(0x00002f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 237, 240, 472, 786, -0.743643135, 0.131825963, 31166.85);
    EXPECT_EQ(0x4f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 278, 203, 458, 854, -0.743643135, 0.131825963, 95606.05);
    EXPECT_EQ(0xaf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 370, 322, 632, 412, -0.743643135, 0.131825963, 26043.60);
    EXPECT_EQ(0x00003f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 11, 964, 103, 978, -0.743643135, 0.131825963, 78351.65);
    EXPECT_EQ(0xbf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 349, 68, 351, 672, -0.743643135, 0.131825963, 59624.35);
    EXPECT_EQ(0x00004f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 251, 19, 680, 129, -0.743643135, 0.131825963, 40918.53);
    EXPECT_EQ(0x00009f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 508, 73, 758, 603, -0.743643135, 0.131825963, 55386.87);
    EXPECT_EQ(0x0000af, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 307, 297, 797, 408, -0.743643135, 0.131825963, 92310.75);
    EXPECT_EQ(0x9f0000, rgb);
    EXPECT_EQ(0, bad_register);
}

TEST(dynamicimage, calcPixel2) {
    target_function = calcPixel;

    int rgb = regwrapper(1000, 200, 25, 666, 725, 0.39054198046, 0.60298978011, 553436265.35);
    EXPECT_EQ(0x00009f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 60, 344, 1039, 392, 0.39054198046, 0.60298978011, 414655836.60);
    EXPECT_EQ(0x6f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 275, 229, 384, 507, 0.39054198046, 0.60298978011, 161295858.05);
    EXPECT_EQ(0x0000cf, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 572, 247, 718, 528, 0.39054198046, 0.60298978011, 119462064.77);
    EXPECT_EQ(0x6f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 66, 105, 788, 206, 0.39054198046, 0.60298978011, 912137553.06);
    EXPECT_EQ(0x00009f, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 54, 480, 120, 504, 0.39054198046, 0.60298978011, 191746400.04);
    EXPECT_EQ(0xff0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 711, 435, 806, 483, 0.39054198046, 0.60298978011, 363514028.18);
    EXPECT_EQ(0x8f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 169, 19, 304, 128, 0.39054198046, 0.60298978011, 1037857.14);
    EXPECT_EQ(0x3f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 494, 512, 537, 844, 0.39054198046, 0.60298978011, 629028689.30);
    EXPECT_EQ(0x2f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 133, 135, 315, 615, 0.39054198046, 0.60298978011, 485456353.88);
    EXPECT_EQ(0xaf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 480, 248, 580, 1045, 0.39054198046, 0.60298978011, 291659699.20);
    EXPECT_EQ(0x8f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 156, 129, 929, 242, 0.39054198046, 0.60298978011, 526861743.85);
    EXPECT_EQ(0xbf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 307, 40, 351, 941, 0.39054198046, 0.60298978011, 858338278.01);
    EXPECT_EQ(0xcf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 404, 38, 1065, 906, 0.39054198046, 0.60298978011, 402634216.03);
    EXPECT_EQ(0x6f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 134, 289, 969, 840, 0.39054198046, 0.60298978011, 59220431.64);
    EXPECT_EQ(0x7f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 333, 31, 458, 131, 0.39054198046, 0.60298978011, 258275161.29);
    EXPECT_EQ(0x7f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 941, 69, 943, 261, 0.39054198046, 0.60298978011, 952775482.25);
    EXPECT_EQ(0xff0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 162, 124, 667, 151, 0.39054198046, 0.60298978011, 465582105.50);
    EXPECT_EQ(0xbf0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 148, 794, 531, 1084, 0.39054198046, 0.60298978011, 130247128.50);
    EXPECT_EQ(0x0f0000, rgb);
    EXPECT_EQ(0, bad_register);

    rgb = regwrapper(1000, 575, 89, 862, 541, 0.39054198046, 0.60298978011, 190865902.56);
    EXPECT_EQ(0x8f0000, rgb);
    EXPECT_EQ(0, bad_register);
}
