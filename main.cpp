#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <workwithfile.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //qmlRegisterType<WorkWithFile>("CustomFileClass", 1,0, "FileI");
    WorkWithFile wwf;
    engine.rootContext()->setContextProperty("filei", &wwf);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
