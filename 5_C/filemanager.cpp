#include "filemanager.h"

fileManager::fileManager(QObject *parent) : QObject(parent),internalProcess(new QProcess(this))
{
    installationPath = QCoreApplication::applicationDirPath();
    dataStoragePath="/tmp";
    arguments<<" ";
    qDebug()<<installationPath;

    generateScripts();
}

void fileManager::logRecorder(QString dataRecord, bool active)
{
    //qDebug()<<"log file updated!";

    if(active){
        //        QString recordMoment;

        time_t     now = time(0);
        struct tm  tstruct;
        char       buf[80];
        tstruct = *localtime(&now);
        strftime(buf, sizeof(buf), "%Y-%m-%d.%X", &tstruct);
        QString filename = dataStoragePath+"/smart_home.log";
        QFile file(filename);
        if (file.open(QIODevice::Append)) {
            QTextStream stream(&file);
            //            stream<< buf << ": " << dataRecord << Qt::endl;
            stream<<" " << dataRecord << "\n";
        }
    }
}

void fileManager::onvifConnect(bool control)
{
    QString command;
    if(control){
        command=installationPath+"/RTSPStream.sh";
        qDebug()<<"Start recording ...";
        qDebug()<<command;
    }else{
        command=installationPath+"/RTSPStop.sh";
        qDebug()<<"Stop recording ...";
        qDebug()<<command;
    }
    if (!QProcess::startDetached("/bin/sh", QStringList{command}))
        qDebug() << "Failed to run";
//    internalProcess->start(command,arguments);
}

void fileManager::generateScripts()
{
    QChar comma='"';
    QString recordCommand="cvlc --no-audio rtsp://admin:Onvif1921680190@192.168.0.190:554/onvif1 --sout=";
    recordCommand.append(comma);
    recordCommand.append("#standard{mux=");
    recordCommand.append(comma);
    recordCommand.append("ffmpeg");
    recordCommand.append(comma);
    recordCommand.append(",access=");
    recordCommand.append(comma);
    recordCommand.append("file");
    recordCommand.append(comma);
    recordCommand.append(",dst=");
    recordCommand.append(comma);
    recordCommand.append("/tmp/output_file.ts");
    recordCommand.append(comma);
    recordCommand.append("}");
    recordCommand.append(comma);
    recordCommand.append(" --no-sout-audio");

    qDebug()<<"recordCommand:"<<"\n"<<recordCommand;
    //    +comma+"ffmpeg"+comma+",access="+comma+"file"+comma+",dst="
    //            +comma+"/mnt/Temporário/output_file.ts"+comma+"}"+comma+" --no-sout-audio"+comma;

    QString killCommand="killall vlc";
    QString quitCommand="exit";
    QString filename = installationPath+"/RTSPStream.sh";
    QFile recordFile(filename);
    recordFile.remove();
    if (recordFile.open(QIODevice::Append)) {
        QTextStream stream(&recordFile);
        stream << "#/bin/bash" << "\n";
        stream << "#" << "\n";
        stream << recordCommand << "\n";
        stream << quitCommand << "\n";
    }

    filename = installationPath+"/RTSPStop.sh";
    QFile stopFile(filename);
    stopFile.remove();
    if (stopFile.open(QIODevice::Append)) {
        QTextStream stream(&stopFile);
        stream << "#/bin/bash" << "\n";
        stream << "#" << "\n";
        stream << killCommand << "\n";
        stream << quitCommand << "\n";
    }
}
