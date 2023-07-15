// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick
import QtQuick.Controls
import Widgets
import Utils

Page {
    height: Constants.height
    width: Constants.width

    background: Rectangle {
        color: "#2f2f2f"
    }
    header: AppMenuBar {
    }

    Image {
        id: backgroundLogo

        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        opacity: 0.2
        source: "assets/logo/logo.png"
    }
}
