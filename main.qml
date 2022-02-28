import QtQuick 2.3
import QtQuick.Controls 1.2
//import QtGraphicalEffects 1.15

import './1_Library/AppSetup/'
import './1_Library/Objects/'
import './2_Components/'
import './3_Screens/'
import './4_Javascript/Functions.js' as Javascript

import '.'

ApplicationWindow {
    id: window
    visible: true
    width: 475
    height: 260
    visibility: "FullScreen"
    title: qsTr("Smart Home v"+version)

    property var waterTankObj: WaterTank
    property var aquariumObj: Aquarium

    //  application settings
    property bool logEnable: true
    readonly property string version:'1.1'
    readonly property var _FONT: ProjectFonts
    readonly property var _STYLES: ProjectStyles
    readonly property var _CONST: Constants

    //  global functions
    readonly property var _JAVASCRIPT:Javascript
    readonly property var _COMPONENT_BEGIN:function(i){
        switch(i){
        case _CONST._homeScreen:

            break;
        case _CONST._cameraScreen:
            return function(){
                console.log('opening camera screeen ... ')
                cameraScreenParentControl=true
                stackView.push(cameraScreen)
            }
        }
    }

    //  application control
    property bool cameraScreenParentControl: false

    property string currentTime

    property string arduinoData
    onArduinoDataChanged:{
        var myArray=arduinoData.split('a');
        errorHandling(function(){
          aquariumObj.setValues(_JAVASCRIPT.splitSerialRead(myArray,_CONST._aquarium))
        },'set aquariumObj')
        errorHandling(function(){
          waterTankObj.setValues(_JAVASCRIPT.splitSerialRead(myArray,_CONST._waterTank))
        },'set waterTankObj')
    }

    Component.onCompleted: {
//        myLog('\nmain.qml Componenet Compvared')
    }

    function myLog(argument){
        fileManager.logRecorder(argument,logEnable)
    }

    function errorHandling(myFunc,errorString){
        try{
            myFunc()
        }catch(e){
            myLog(errorString)
            myLog(e)
        }
    }

    Timer{
        id:loopTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            currentTime=appClock.getCurrentTime()
            arduinoData=arduinoRead.readDataFromSerial()
        }
    }

    Rectangle{
        id:windowBackground
        color: 'black'
        anchors.fill: parent
    }

    MyHeader{
        id:header
        textColor: 'white'
        pressedColor: 'blue'
        headerMenus: ['Home','Test','Tela cheia','Tela normal','Sair']
        height: parent.height*0.05
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        onHeaderClicked: {
            switch(headerIndex){
            case 0:
                stackView.push(homeScreen)
                break
            case 1:
                stackView.push(testArea)
                break
            case 2: window.visibility = "FullScreen"
                break
            case 3: window.visibility = "Windowed"
                break
            case 4: Qt.quit()
                break
            }
        }
    }

    StackView{
        id:stackView
        anchors.fill: parent
        anchors.topMargin: header.height
        anchors.margins: 1
        clip: false
        initialItem: homeScreen
    }
    Component{
        id:homeScreen
        HomeScreen{}
    }
    Component{
        id:testArea
        TestArea{}
    }
    Component{
        id:cameraScreen
        CameraScreen{
            loadChildrens: window.cameraScreenParentControl
        }
    }

    Rectangle{
        id:loadingContainer
        color:'black'
        anchors.fill: parent
        opacity: 0.5
        visible: false
        Image {
            property PropertyAnimation rotate: PropertyAnimation {
                target: loading
                property: "rotation"
                from: 0 ; to: 360
                duration: 800
                loops: Animation.Infinite
                running: loadingContainer.visible
            }
            id: loading
            source: "qrc:/0_Archive/Images/loading.svg"
            fillMode: Image.PreserveAspectFit
            smooth: true
            width: height
            asynchronous: true
            mipmap: true
            anchors.fill:parent
            anchors.margins: parent.width*0.2
        }
    }

    onClosing: fileManager.onvifConnect(false)
}
