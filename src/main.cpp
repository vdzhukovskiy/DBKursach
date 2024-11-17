#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

#include "dbconnector.h"

void register_types()
{
    qmlRegisterSingletonInstance("com.dbconnector", 1, 0, "DBConnector", &DbConnector::instance());
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    register_types();
    const QUrl url(u"qrc:/DBKursach/qml/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);


    return app.exec();
}
