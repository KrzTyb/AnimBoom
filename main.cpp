// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

#include "toolkit/animboomtoolkit.h"

int main(int argc, char *argv[]) {

  qDebug() << "Toolkit version: " << ABT_get_version();

  QGuiApplication app(argc, argv);

  QGuiApplication::setWindowIcon(QIcon(":/assets/logo/logo.ico"));

  QQmlApplicationEngine engine;
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.loadFromModule("ui", "Main");

  return QGuiApplication::exec();
}
