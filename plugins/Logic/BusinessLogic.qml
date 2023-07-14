// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

pragma Singleton
import QtQuick

Item {
    property alias menuBarHandler: menuBarHandler

    MenuBarHandler {
        id: menuBarHandler
    }
}
