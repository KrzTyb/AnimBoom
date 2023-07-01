// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls
import Utils

MenuItem {
    id: menuItem
    implicitWidth: 296
    implicitHeight: 30

    background: Rectangle {
        id: background
        color: menuItem.highlighted ? "#383838" : "#232323"
        anchors.fill: parent
        radius: 1
        border.color: "#00000000"

        Rectangle {
            id: contour
            color: "#00ffffff"
            anchors.fill: parent
        }
    }

    arrow: Image {
        x: parent.width - width - 4
        anchors.verticalCenter: parent.verticalCenter
        width: 7
        height: 7
        visible: menuItem.subMenu

        source: "assets/ArrowRight.png"
    }

    indicator: null

    Text {
        id: shortcutTextItem
        x: parent.width - 15 - width
        width: 120
        height: parent.height
        text: menuItem.action && menuItem.action.shortcut ? menuItem.action.shortcut : ""
        visible: text.length > 0 ? true : false

        opacity: enabled ? 1.0 : 0.3
        color: "#FFFFFF"
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 9
        font.family: "Libre Franklin"
    }

    contentItem: Text {
        id: infoText
        width: 130
        height: parent.height
        text: menuItem.text

        opacity: enabled ? 1.0 : 0.3
        color: "#FFFFFF"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        font.pointSize: 9
        font.family: "Libre Franklin"
    }
}
