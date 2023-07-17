// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls

MenuBarItem {
    id: menuBarItem

    height: 30
    width: 70

    background: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        color: menuBarItem.highlighted ? "#383838" : "transparent"
        height: parent.height - 4
        opacity: enabled ? 1 : 0.3
        radius: 20
    }
    contentItem: Text {
        id: textItem

        color: "#ffffff"
        font.family: "Libre Franklin"
        font.pointSize: 9
        horizontalAlignment: Text.AlignHCenter
        opacity: enabled ? 1 : 0.3
        text: menuBarItem.text
        verticalAlignment: Text.AlignVCenter
    }
}
