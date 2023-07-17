// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

pragma Singleton
import QtQuick

QtObject {
    readonly property url arrowRightImage: Qt.resolvedUrl("content/ArrowRight.png")
    readonly property FontLoader libreFranklinMedium: FontLoader {
        source: "content/fonts/LibreFranklin/LibreFranklin-Medium.ttf"
    }
    readonly property url logoImage: Qt.resolvedUrl("content/logo/logo.png")
    readonly property url toolbarBackgroundImage: Qt.resolvedUrl("content/ToolbarBackground.png")
}
