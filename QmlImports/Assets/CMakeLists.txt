# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

qt6_add_library(Assets STATIC)

set_source_files_properties(Assets.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt6_add_qml_module(Assets
    URI "Assets"
    VERSION 1.0
    QML_FILES
        Assets.qml

    RESOURCES
        content/logo/logo.png
        content/ArrowRight.png
        content/ToolbarBackground.png
        content/fonts/LibreFranklin/LibreFranklin-Medium.ttf
)
