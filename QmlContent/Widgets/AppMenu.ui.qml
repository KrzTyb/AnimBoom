// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

import QtQuick
import QtQuick.Controls
import "../Delegates"

Menu {
    bottomPadding: 2
    leftPadding: 2
    rightPadding: 2
    title: ""
    topPadding: 2
    width: 296

    background: Rectangle {
        color: "#232323"

        Rectangle {
            anchors.fill: parent
            border.color: "#FF000000"
            border.width: 2
            color: "#00ffffff"
            opacity: 0.45
        }
    }
    delegate: MenuDelegate {
    }
}
