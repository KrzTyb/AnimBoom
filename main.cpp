#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <vector>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.loadFromModule("AnimBoom", "Main");

  return QGuiApplication::exec();
}
