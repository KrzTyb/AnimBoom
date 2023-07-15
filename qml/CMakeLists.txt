# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

qt6_add_qml_module(Gui STATIC
    URI qml
    VERSION 1.0
    NO_PLUGIN
    RESOURCE_PREFIX
        /
    IMPORT_PATH
        ${CMAKE_CURRENT_BINARY_DIR}
    QML_FILES
        main.qml
)

add_subdirectory(Utils)
add_subdirectory(Logic)
add_subdirectory(Delegates)
add_subdirectory(Widgets)
add_subdirectory(Content)

target_link_libraries(Gui
    PRIVATE
        Utilsplugin
        Logicplugin
        Contentplugin
        Delegatesplugin
        Widgetsplugin
)

append_qml_import_path()
