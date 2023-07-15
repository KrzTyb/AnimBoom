# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

qt6_add_library(Delegates STATIC)

qt6_add_qml_module(Delegates
    URI Delegates
    VERSION 1.0
    QML_FILES
        MenuDelegate.qml
        MenuBarDelegate.qml
    RESOURCES
        assets/ArrowRight.png
)
