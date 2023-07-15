// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski
#pragma once

#include <QObject>
#include <QtQml/qqml.h>

#include <QString>

class MenuBarHandler : public QObject {
    // NOLINTNEXTLINE
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT
    Q_DISABLE_COPY(MenuBarHandler)

public:
    Q_PROPERTY(QString title MEMBER m_title)

    explicit MenuBarHandler(QObject *parent = nullptr);
    ~MenuBarHandler() override = default;

    Q_INVOKABLE static void newProject();

private:
    QString m_title;
};
