#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngineQuick>
#include "weatherapi.h"
#include "localstorage.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    QtWebEngineQuick::initialize();

    QApplication app(argc, argv);
    qmlRegisterType<WeatherApi>("Weather", 1, 0, "WeatherApi");
    qmlRegisterType<LocalStorage>("Storage", 1,0,"JsonStorage");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("Taskspace", "Main");

    return app.exec();
}
