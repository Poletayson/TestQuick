#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <recordlist.h>
#include <dataaccessor.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    DataAccessor *da = new DataAccessor ();
    QAbstractListModel *records = new RecordsList (da);
    QAbstractListModel *plans = new PlansList (da);

    engine.rootContext()->setContextProperty("records", records);
    engine.rootContext()->setContextProperty("plans", plans);
    engine.load(url);

    return app.exec();
}
