// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls

MenuBarItem {
    id: menuBarItem
    height: 30
    width: 70

    contentItem: Text {
        id: textItem
        text: menuBarItem.text

        opacity: enabled ? 1.0 : 0.3
        color: "#ffffff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 9
        font.family: "Libre Franklin"
    }

    background: Rectangle {
        height: parent.height - 4
        anchors.verticalCenter: parent.verticalCenter
        opacity: enabled ? 1 : 0.3
        color: menuBarItem.highlighted ? "#383838" : "transparent"
        radius: 20
    }
}
