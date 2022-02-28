pragma Singleton

import QtQuick 2.0

QtObject {
    property FontLoader clock: FontLoader {
        source: "qrc:/0_Archive/Files/Fonts/digital-7.ttf"
        name:"digital-7"
    }
    property FontLoader system: FontLoader {
        source: "qrc:/0_Archive/Fonts/Roboto-Light.ttf"
        name:"Roboto-Light"
    }
}
