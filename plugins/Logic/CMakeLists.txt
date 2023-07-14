# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

# QML plugin to connect business logic with UI

set_source_files_properties(BusinessLogic.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_library(Logic STATIC)
qt6_add_qml_module(Logic
    URI "Logic"
    VERSION 1.0
    RESOURCE_PREFIX
        /
    QML_FILES
        BusinessLogic.qml
    SOURCES
        MenuBarHandler.hpp
        MenuBarHandler.cpp
)

set(QML_IMPORT_PATH ${QML_IMPORT_PATH} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} CACHE STRING "" FORCE)
