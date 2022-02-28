#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "5_C/appclock.h"
#include "5_C/arduinoread.h"
#include "5_C/filemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ArduinoRead *m_ArduinoRead =new ArduinoRead();
    engine.rootContext()->setContextProperty("arduinoRead",m_ArduinoRead);

    fileManager *m_fileManager =new fileManager();
    engine.rootContext()->setContextProperty("fileManager",m_fileManager);

    AppClock *m_appclock =new AppClock();
    engine.rootContext()->setContextProperty("appClock",m_appclock);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
