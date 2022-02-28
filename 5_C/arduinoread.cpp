#include "arduinoread.h"

ArduinoRead::ArduinoRead(QObject *parent) : QObject(parent)
{
    arduino_is_available=false;
    arduino_port_name="";
    arduino = new QSerialPort;
    serialBuffer="";

    qDebug() << "Number of available ports:" << QSerialPortInfo::availablePorts().length();
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        qDebug() <<"Has vendor ID:"<< serialPortInfo.hasVendorIdentifier();
        if(serialPortInfo.hasVendorIdentifier()){
            qDebug()<<"Vendor ID:"<< serialPortInfo.vendorIdentifier();
        }
    }
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        qDebug() <<"Has product ID:"<< serialPortInfo.hasProductIdentifier();
        if(serialPortInfo.hasProductIdentifier()){
            qDebug()<<"Product ID:"<< serialPortInfo.productIdentifier();
        }
    }
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        if(serialPortInfo.hasVendorIdentifier() && serialPortInfo.hasProductIdentifier()){
            if(serialPortInfo.vendorIdentifier() == arduino_uno_vendor_id){
                if(serialPortInfo.productIdentifier()==arduino_uno_product_id){
                    //arduino_port_name=serialPortInfo.portName();
                    //                    arduino_port_name="/dev/ttyUSB0";
                    arduino_is_available=true;
                }
            }
        }
    }

    if(arduino_is_available){
        arduino = new QSerialPort;
        arduino_port_name="/dev/ttyUSB1";
        //        arduino_port_name="/dev/ttyUSB0";
        arduino->setPortName(arduino_port_name);
        arduino->open(QSerialPort::ReadWrite);
        arduino->setBaudRate(QSerialPort::Baud9600);
        arduino->setDataBits(QSerialPort::Data8);
        arduino->setParity(QSerialPort::NoParity);
        arduino->setStopBits(QSerialPort::OneStop);
        arduino->setFlowControl(QSerialPort::NoFlowControl);
        //        QObject::connect(arduino,SIGNAL(readyRead()),this,SLOT(readSerial()));
    }
}

QString ArduinoRead::readDataFromSerial()
{
    serialData = arduino->readAll();
    return  QString(serialData);
//    return  QString::fromStdString(serialData.toStdString());
}
