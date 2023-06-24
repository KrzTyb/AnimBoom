# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski

qt_add_library(ui STATIC)
qt_add_qml_module(ui
    URI ui
    VERSION 1.0
    QML_FILES
        Main.qml
        MainView.qml
        MainViewForm.ui.qml
    RESOURCE_PREFIX
        /
)


qt_add_resources(ui "config"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)
