#ifndef APPCLOCK_H
#define APPCLOCK_H

#include <QObject>
#include <QTime>

class AppClock : public QObject
{
    Q_OBJECT
public:
    explicit AppClock(QObject *parent = 0);

    Q_INVOKABLE QString getCurrentTime();

signals:

};

#endif // APPCLOCK_H
