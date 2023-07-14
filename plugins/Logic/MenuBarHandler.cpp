// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

#include "MenuBarHandler.hpp"
#include <QtQuick/qquickitem.h>

#include <QDebug>

MenuBarHandler::MenuBarHandler(QQuickItem *parent) : QQuickItem(parent) {}

void MenuBarHandler::newProject() { qDebug() << "New Project clicked"; }
