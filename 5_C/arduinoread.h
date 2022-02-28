#ifndef ARDUINOREAD_H
#define ARDUINOREAD_H

#include "QtSerialPort/QSerialPortInfo"
#include "QtSerialPort/QSerialPort"
#include <QByteArray>
#include <QPixmap>
#include <QObject>
#include <QDebug>
#include <string>
#include <QDebug>
#include <QTime>
#include <QTimer>
#include <QtMath>

class ArduinoRead : public QObject
{
    Q_OBJECT
public:
    explicit ArduinoRead(QObject *parent = 0);
    Q_INVOKABLE QString readDataFromSerial();

signals:

public slots:

private:
    QSerialPort *arduino;
    static const quint16 arduino_uno_vendor_id = 6790;
    static const quint16 arduino_uno_product_id = 29987;
    QString arduino_port_name;
//    float entrada;
    bool arduino_is_available;
    QByteArray serialData;
    QString serialBuffer;
    int filtro;
    QStringList bufferSplit_anterior;
    int n_loop=0;
};

#endif // ARDUINOREAD_H
