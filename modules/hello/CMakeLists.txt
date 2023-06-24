app_add_static_library(
    TARGET_NAME
        Hello

    INCLUDE_DIRS
        PUBLIC
            include
        PRIVATE
            src

    SOURCES
        src/hello.cpp

    DEPENDENCIES
        PUBLIC

    TESTS
        gtest/hellotest.cpp
)
