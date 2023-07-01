// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

import QtQuick
import QtQuick.Controls
import Delegates

Menu {
    title: ""
    width: 296
    leftPadding: 2
    rightPadding: 2
    topPadding: 2
    bottomPadding: 2

    delegate: MenuDelegate {}

    background: Rectangle {
        color: "#232323"

        Rectangle {
            color: "#00ffffff"
            anchors.fill: parent
            border.color: "#FF000000"
            border.width: 2
            opacity: 0.45
        }
    }
}
