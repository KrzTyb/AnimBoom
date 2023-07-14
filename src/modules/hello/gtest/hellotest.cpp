// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

#include <gmock/gmock.h>
#include <gtest/gtest.h>

// Demonstrate some basic assertions.
TEST(HelloAnimBoom, BasicAssertions) {
    // Expect two strings not to be equal.
    EXPECT_STRNE("hello", "AnimBoom");
    // Expect equality.
    EXPECT_EQ(7 * 6, 42);
}
