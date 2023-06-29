# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

qt6_add_library(ui STATIC)
qt6_add_qml_module(ui
    URI "ui"
    VERSION 1.0
    RESOURCE_PREFIX
        /
    QML_FILES
        App.qml
        MainView.qml
        MainViewForm.ui.qml
    RESOURCES
        assets/logo/logo.ico
        assets/logo/logo.png
        assets/toolbar/ToolbarBackground.png
)

add_subdirectory(Utils)
add_subdirectory(Widgets)


target_link_libraries(ui PRIVATE
    Widgetsplugin
    Utilsplugin
)
