

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls
import Widgets
import Utils

Page {
    width: Constants.width
    height: Constants.height

    background: Rectangle {
        color: "#2f2f2f"
    }

    header: Rectangle {
        id: toolbar
        height: 30
        Image {
            source: "assets/toolbar/ToolbarBackground.png"
        }
        Row {
            anchors.fill: parent
            ToolbarButton {
                id: fileButton
                height: 26
                width: 70
                text: qsTr("File")
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolbarButton {
                id: editButton
                height: 26
                width: 70
                text: qsTr("Edit")
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolbarButton {
                id: helpButton
                height: 26
                width: 70
                text: qsTr("Help")
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Image {
        id: backgroundLogo
        anchors.centerIn: parent
        source: "assets/logo/logo.png"
        fillMode: Image.PreserveAspectFit
        opacity: 0.2
    }
}
