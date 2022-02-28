#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QCoreApplication>
#include <QTextStream>
#include <QProcess>
#include <QObject>
#include <QDebug>
#include <QFile>
#include <QDir>

class fileManager : public QObject
{
    Q_OBJECT
public:
    explicit fileManager(QObject *parent = 0);

    Q_INVOKABLE void logRecorder(QString dataRecord,bool active);

    Q_INVOKABLE void onvifConnect(bool control);
signals:

public slots:

private:
    QString dataStoragePath;
    QStringList arguments;
    QString installationPath;

    QProcess *internalProcess;

    void generateScripts();
    QString rtspStart();
    QString rtspStop();
};

#endif // FILEMANAGER_H
