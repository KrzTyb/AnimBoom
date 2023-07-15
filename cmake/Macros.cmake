# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

function(_app_add_library)
    set(oneValueArgs TARGET_NAME)
    set(multiValueArgs INCLUDE_DIRS SOURCES DEPENDENCIES TESTS TYPE)
    set(options "")
    cmake_parse_arguments(APP_ADD_LIBRARY_ARG "${options}" "${oneValueArgs}"
                          "${multiValueArgs}" ${ARGN})

    qt_add_library(${APP_ADD_LIBRARY_ARG_TARGET_NAME} ${APP_ADD_LIBRARY_ARG_TYPE} ${APP_ADD_LIBRARY_ARG_SOURCES})

    target_include_directories(${APP_ADD_LIBRARY_ARG_TARGET_NAME}
        ${APP_ADD_LIBRARY_ARG_INCLUDE_DIRS}
    )

    target_link_libraries(${APP_ADD_LIBRARY_ARG_TARGET_NAME}
        ${APP_ADD_LIBRARY_ARG_DEPENDENCIES}
    )

    if(ENABLE_TESTS MATCHES ON AND NOT "${APP_ADD_LIBRARY_ARG_TESTS}" STREQUAL "")
        set(TEST_TARGET "Test${APP_ADD_LIBRARY_ARG_TARGET_NAME}")

        qt_add_executable(${TEST_TARGET} ${APP_ADD_LIBRARY_ARG_TESTS})
        target_link_libraries(${TEST_TARGET} PRIVATE ${APP_ADD_LIBRARY_ARG_TARGET_NAME} GTest::gtest_main GTest::gmock)

        gtest_discover_tests(${TEST_TARGET})

    endif()

endfunction(_app_add_library)

function(app_add_static_library)
    _app_add_library(${ARGN} TYPE STATIC)
endfunction(app_add_static_library)

function(app_add_shared_library)
    _app_add_library(${ARGN} TYPE SHARED)
endfunction(app_add_shared_library)

function(app_add_interface_library)
    _app_add_library(${ARGN} TYPE INTERFACE)
endfunction(app_add_interface_library)

# Add current source / binary dir to QML imports
macro(append_qml_import_path)
    set(QML_IMPORT_PATH ${QML_IMPORT_PATH} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} CACHE STRING "" FORCE)
endmacro(append_qml_import_path)
