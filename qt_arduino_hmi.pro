#TEMPLATE = app

QT += quick qml serialport core gui widgets multimedia
CONFIG += c++11

SOURCES += main.cpp \
    5_C/appclock.cpp \
    5_C/arduinoread.cpp \
    5_C/filemanager.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    README.md \
    0_Archive/Fonts/digital-7 (italic).ttf \
    0_Archive/Fonts/digital-7 (mono italic).ttf \
    0_Archive/Fonts/digital-7 (mono).ttf

HEADERS += \
    5_C/appclock.h \
    5_C/arduinoread.h \
    5_C/filemanager.h
