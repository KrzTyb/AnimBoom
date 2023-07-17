// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import Logic

AppMenuBarForm {
    id: appMenuBar

    Connections {
        function onTriggered(source: QtObject) {
            MenuBarHandler.newProject();
        }

        target: appMenuBar.newProjectAction
    }
}
