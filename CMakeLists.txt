# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

cmake_minimum_required(VERSION 3.22)

project(AnimBoom VERSION 0.1 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/Options.cmake)

# TODO: Change it to target_compile_options
if(MSVC)
    add_compile_options(/W3 /WX)
else()
    add_compile_options(-Wall -Wextra -Werror)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmake/FindPackages.cmake)

# Compile toolkit
include(FetchContent)
FetchContent_Declare(
    Corrosion
    GIT_REPOSITORY https://github.com/corrosion-rs/corrosion.git
    GIT_TAG v0.4.1
)
FetchContent_MakeAvailable(Corrosion)
corrosion_import_crate(MANIFEST_PATH animboom-toolkit/Cargo.toml)

if (${ENABLE_TESTS})
    include(${CMAKE_CURRENT_LIST_DIR}/cmake/Testing.cmake)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmake/Macros.cmake)

qt_standard_project_setup(REQUIRES 6.5)

add_subdirectory(modules)
add_subdirectory(ui)

qt_add_executable(AnimBoomDesigner
    main.cpp
)

target_link_libraries(AnimBoomDesigner
    PRIVATE
        Qt6::Quick
        uiplugin
        animboom-toolkit
)

add_subdirectory(assets)

set_target_properties(AnimBoomDesigner PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER animboom.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS AnimBoomDesigner
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
