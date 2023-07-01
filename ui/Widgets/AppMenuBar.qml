// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

import QtQuick
import QtQuick.Controls
import Delegates

MenuBar {
    height: 30
    AppMenu {
        title: qsTr("File")

        Action { text: qsTr("New project"); shortcut: "Ctrl+N"}
        Action { text: qsTr("New window"); shortcut: "Ctrl+Shift+N"}
        AppMenu {
            title: qsTr("Open Recent")
            Action { text: qsTr("Some project");}
        }

        AppMenuSeparator {}

        Action { text: qsTr("Exit");}
    }

    AppMenu {
        title: qsTr("Edit")

        Action { text: qsTr("Undo"); shortcut: "Ctrl+Z"}
        Action { text: qsTr("Redo"); shortcut: "Ctrl+Y"}

        AppMenuSeparator {}

        Action { text: qsTr("Cut"); shortcut: "Ctrl+X"}
        Action { text: qsTr("Copy"); shortcut: "Ctrl+C"}
        Action { text: qsTr("Paste"); shortcut: "Ctrl+V"}
    }

    AppMenu {
        title: qsTr("Help")

        Action { text: qsTr("About");}
    }

    delegate: MenuBarDelegate {}

    background: Image {
        height: parent.height + 10 // Add 10 for shadow
        source: "assets/toolbar/ToolbarBackground.png"
    }
}
