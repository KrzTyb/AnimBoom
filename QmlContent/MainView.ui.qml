/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
import QtQuick 6.5
import Assets
import Utils
import "Widgets"

Rectangle {
    color: "#2f2f2f"
    height: Constants.height
    width: Constants.width

    AppMenuBar {
    }
    Image {
        id: backgroundLogo

        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        opacity: 0.2
        source: Assets.logoImage
    }
}
