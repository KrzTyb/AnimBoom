// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

import QtQuick
import QtQuick.Window

Window {
    height: mainView.height
    minimumHeight: 400
    minimumWidth: 400
    title: qsTr("AnimBoom Designer")
    visible: true
    width: mainView.width

    MainView {
        id: mainView

    }
}
