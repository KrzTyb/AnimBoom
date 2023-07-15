// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

#include "MenuBarHandler.hpp"

#include <QDebug>

MenuBarHandler::MenuBarHandler(QObject *parent) : QObject(parent) {}

void MenuBarHandler::newProject() { qDebug() << "New Project clicked"; }
