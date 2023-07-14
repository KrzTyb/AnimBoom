// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
#pragma once

#include <QtQuick/QQuickItem>

class MenuBarHandler : public QQuickItem {
    // NOLINTNEXTLINE
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(MenuBarHandler)
public:
    explicit MenuBarHandler(QQuickItem *parent = nullptr);
    ~MenuBarHandler() override = default;

    Q_INVOKABLE static void newProject();
};
