# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

# QML plugin to connect business logic with UI

qt_add_library(Logic STATIC)
qt6_add_qml_module(Logic
    URI Logic
    VERSION 1.0
    SOURCES
        MenuBarHandler.hpp
        MenuBarHandler.cpp
)
