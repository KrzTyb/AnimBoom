// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

import QtQuick
import QtQuick.Window

import Utils

Window {

    width: Constants.width
    height: Constants.height
    minimumHeight: 400
    minimumWidth: 400

    visible: true
    title: qsTr("AnimBoom Designer")

    MainView {
        anchors.fill: parent
    }
}
