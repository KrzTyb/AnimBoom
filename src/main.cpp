// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2023 Krzysztof Tyburski

#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

#include "toolkit/animboomtoolkit.h"

void set_qt_environment();

int main(int argc, char *argv[]) {

    set_qt_environment();

    qDebug() << "Toolkit version: " << ABT_get_version();

    QGuiApplication app(argc, argv);

    QGuiApplication::setWindowIcon(QIcon(":/qml/assets/logo/logo.ico"));

    QQmlApplicationEngine engine;

    const QUrl url{QStringLiteral("qrc:/qml/main.qml")};

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if ((obj == nullptr) && url == objUrl) {
                QCoreApplication::exit(-1);
            }
        },
        Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return QGuiApplication::exec();
}

void set_qt_environment() {
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "1");
    qputenv("QT_ENABLE_HIGHDPI_SCALING", "0");
    qputenv("QT_LOGGING_RULES", "qt.qml.connections=false");
    qputenv("QT_QUICK_CONTROLS_CONF", ":/qtquickcontrols2.conf");
    qputenv("QML_COMPAT_RESOLVE_URLS_ON_ASSIGNMENT", "1");
}
