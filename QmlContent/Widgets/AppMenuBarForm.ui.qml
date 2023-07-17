// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls
import "../Delegates"
import Assets

MenuBar {
    id: menuBar

    property alias newProjectAction: newProjectAction

    height: 30

    background: Image {
        height: menuBar.height + 10 // Add 10 for shadow
        source: Assets.toolbarBackgroundImage
    }
    delegate: MenuBarDelegate {
    }

    AppMenu {
        title: qsTr("File")

        Action {
            id: newProjectAction

            shortcut: "Ctrl+N"
            text: qsTr("New project")
        }
        Action {
            shortcut: "Ctrl+Shift+N"
            text: qsTr("New window")
        }
        AppMenu {
            title: qsTr("Open Recent")

            Action {
                text: qsTr("Some project")
            }
        }
        AppMenuSeparator {
        }
        Action {
            text: qsTr("Exit")
        }
    }
    AppMenu {
        title: qsTr("Edit")

        Action {
            shortcut: "Ctrl+Z"
            text: qsTr("Undo")
        }
        Action {
            shortcut: "Ctrl+Y"
            text: qsTr("Redo")
        }
        AppMenuSeparator {
        }
        Action {
            shortcut: "Ctrl+X"
            text: qsTr("Cut")
        }
        Action {
            shortcut: "Ctrl+C"
            text: qsTr("Copy")
        }
        Action {
            shortcut: "Ctrl+V"
            text: qsTr("Paste")
        }
    }
    AppMenu {
        title: qsTr("Help")

        Action {
            text: qsTr("About")
        }
    }
}
