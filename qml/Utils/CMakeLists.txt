# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

qt6_add_library(Utils STATIC)

set_source_files_properties(Constants.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(FontContainer.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt6_add_qml_module(Utils
    URI "Utils"
    VERSION 1.0
    QML_FILES
        Constants.qml
        FontContainer.qml
    RESOURCES
        fonts/LibreFranklin/LibreFranklin-Medium.ttf
)
