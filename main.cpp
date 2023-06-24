// SPDX-License-Identifier: GPL-3.0-only
/*
 * AnimBoom Designer application
 *
 * Copyright (C) 2023 Krzysztof Tyburski
 *
 * The contents of this file may be used under the GNU General Public License
 * Version 3.
 */

#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[]) {

  QGuiApplication app(argc, argv);

  QGuiApplication::setWindowIcon(QIcon(":/assets/logo/logo.ico"));

  QQmlApplicationEngine engine;
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.loadFromModule("ui", "Main");

  return QGuiApplication::exec();
}
