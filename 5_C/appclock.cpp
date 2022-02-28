#include "appclock.h"

AppClock::AppClock(QObject *parent) : QObject(parent)
{

}

QString AppClock::getCurrentTime()
{
    QTime time = QTime::currentTime();
    QString output = time.toString("hh:mm");
    return output;
}
