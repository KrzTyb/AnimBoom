// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls
import Utils

MenuItem {
    id: menuItem

    implicitHeight: 30
    implicitWidth: 296
    indicator: null

    arrow: Image {
        anchors.verticalCenter: parent.verticalCenter
        height: 7
        source: "assets/ArrowRight.png"
        visible: menuItem.subMenu
        width: 7
        x: parent.width - width - 4
    }
    background: Rectangle {
        id: background

        anchors.fill: parent
        border.color: "#00000000"
        color: menuItem.highlighted ? "#383838" : "#232323"
        radius: 1

        Rectangle {
            id: contour

            anchors.fill: parent
            color: "#00ffffff"
        }
    }
    contentItem: Text {
        id: infoText

        color: "#FFFFFF"
        font.family: "Libre Franklin"
        font.pointSize: 9
        height: parent.height
        horizontalAlignment: Text.AlignLeft
        opacity: enabled ? 1 : 0.3
        text: menuItem.text
        verticalAlignment: Text.AlignVCenter
        width: 130
    }

    Text {
        id: shortcutTextItem

        color: "#FFFFFF"
        font.family: "Libre Franklin"
        font.pointSize: 9
        height: parent.height
        horizontalAlignment: Text.AlignRight
        opacity: enabled ? 1 : 0.3
        text: menuItem.action && menuItem.action.shortcut ? menuItem.action.shortcut : ""
        verticalAlignment: Text.AlignVCenter
        visible: text.length > 0 ? true : false
        width: 120
        x: parent.width - 15 - width
    }
}
