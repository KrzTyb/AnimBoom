# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

cmake_minimum_required(VERSION 3.22)

project(AnimBoomDesigner VERSION 0.1 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_AUTOMOC ON)
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
corrosion_set_env_vars(animboom-toolkit TOOLKIT_BINDINGS_PATH=${CMAKE_CURRENT_BINARY_DIR}/include/toolkit)

if (${ENABLE_TESTS})
    include(${CMAKE_CURRENT_LIST_DIR}/cmake/Testing.cmake)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmake/Macros.cmake)

qt6_standard_project_setup(REQUIRES 6.5)

qt6_add_executable(${CMAKE_PROJECT_NAME}
    src/main.cpp
)

qt6_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

qt6_add_qml_module(${CMAKE_PROJECT_NAME}
    URI "Main"
    VERSION 1.0
    NO_PLUGIN
    RESOURCE_PREFIX
        /
    QML_FILES
        main.qml
)

add_subdirectory(ui)
add_subdirectory(src)

target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        uiplugin
        animboom-toolkit
)

target_include_directories(${CMAKE_PROJECT_NAME}
    PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/include
)

install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
