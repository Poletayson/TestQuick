#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <recordlist.h>
#include <dataaccessor.h>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


//    QQuickView view;
    DataAccessor da;
    QAbstractListModel *records = new Records;
    QAbstractListModel *plans = new Plans;
    //records.add("Хлеб");
//    view.rootContext()->setContextProperty("records", &records);    //set records model
//     view.setSource(QUrl (QStringLiteral("qrc:/main.qml")));
//     view.show();


    engine.rootContext()->setContextProperty("records", records);
    engine.rootContext()->setContextProperty("plans", plans);
    engine.load(url);

    return app.exec();
}
