// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

import QtQuick
import QtQuick.Window
import Utils

Window {
    height: Constants.height
    minimumHeight: 400
    minimumWidth: 400
    title: qsTr("AnimBoom Designer")
    visible: true
    width: Constants.width

    MainView {
        anchors.fill: parent
    }
}
