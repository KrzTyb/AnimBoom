// SPDX-License-Identifier: GPL-3.0-only
/*
 * Unit tests for AnimBoom Designer.
 *
 * Copyright (C) 2023 Krzysztof Tyburski
 *
 * The contents of this file may be used under the GNU General Public License
 * Version 3.
 */

#include <gmock/gmock.h>
#include <gtest/gtest.h>

// Demonstrate some basic assertions.
TEST(HelloAnimBoom, BasicAssertions) {
  // Expect two strings not to be equal.
  EXPECT_STRNE("hello", "AnimBoom");
  // Expect equality.
  EXPECT_EQ(7 * 6, 42);
}
