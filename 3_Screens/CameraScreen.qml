import QtQuick 2.0
//import VLCQt 1.0

//import QtGraphicalEffects 1.15
import QtQuick.Controls 1.2
import QtMultimedia 5.0
import QtQuick 2.3

Item {
    id:root

    property bool loadChildrens: false
    onLoadChildrensChanged: {
        if(loadChildrens){
            cameraScreenParentControl=true
            loadingContainer.visible=true
            fileManager.onvifConnect(true)
            streamDelay.start()
        }
    }

    function quitNow(){
        quitDelay.stop()
        loadingContainer.visible=false
        fileManager.onvifConnect(false)
        window.cameraScreenParentControl=false
        playNow.stop()
        stackView.push(homeScreen)
    }

    Timer{
        id:quitDelay
        running:false
        repeat: false
        interval: 30000
        onTriggered: {
            quitNow()
        }
    }

    Timer{
        id:streamDelay
        running:false
        repeat: false
        interval: 5000
        onTriggered: {
            console.log('playing now')
            loadingContainer.visible=false
            playNow.source=_CONST._stream
            playNow.muted=true
            playNow.play()
            quitDelay.start()
            streamDelay.stop()
        }
    }

    MediaPlayer{
        id: playNow
    }

    Rectangle{
        id:outputContainer
        anchors{
            fill: parent
            margins:15
        }
        color:'transparent'
        VideoOutput {
            anchors.fill: parent
            source: playNow
            fillMode: VideoOutput.PreserveAspectFit
        }
    }

    MouseArea{
        anchors.fill:parent
        onClicked: quitNow()
    }
}
