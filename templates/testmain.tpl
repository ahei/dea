/* -*- C++ -*- */

// Time-stamp: <2015-05-29 19:32:20 Friday by ahei>

/**
 * @file runtest.cpp
 * @author ahei
 */

#include <gtest/gtest.h>

int main(int argc, char *argv[])
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
