import QtQuick.Controls 1.2
import QtMultimedia 5.0
import QtQuick 2.3

Item {
    id:root
        Text {
            id: name
            anchors.fill: parent
            color: 'white'
            font.family: _FONT.system
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAnywhere
            text: arduinoData
                  +'\n'+
            JSON.stringify(waterTankObj.getObject())
                  +'\n'+
                  JSON.stringify(aquariumObj.getObject())
                  +'\n'
        }
}
