# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski



qt6_add_library(Content STATIC)
qt6_add_qml_module(Content
    URI Content
    VERSION 1.0
    QML_FILES
        App.qml
        MainView.qml

    RESOURCES
        assets/logo/logo.png
)
