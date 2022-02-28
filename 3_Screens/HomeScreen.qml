import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
//import QtQuick.Extras 1.4
import QtMultimedia 5.0
import QtQuick 2.3

import '../2_Components'

Item {
    property var shortcutsImg: ['','','qrc:/0_Archive/Images/camera.svg']
    property var shortcutsLink: ['', '',_COMPONENT_BEGIN(_CONST._cameraScreen)]
    property var sidePanelShortcutsTextConfig:[waterTankObj.currentPmpState(_CONST.textObject),aquariumObj.feederCounterOutput(_CONST.textObject),aquariumObj.currentTemperatureValue(_CONST.textObject)]
//    property var sidePanelShortcutsColorConfig:[waterTankObj.currentPmpState(_CONST.colorObject),aquariumObj.feederCounterOutput(_CONST.colorObject),aquariumObj.currentTemperatureValue(_CONST.colorObject)]
    property var sidePanelShortcutsColorConfig:[waterTankObj.currentPmpState(_CONST.colorObject),'lightgreen','lightgreen']

    id: root

    Rectangle{
        id:myClockContainer
        color: 'transparent'
        anchors{
            fill:parent
            bottomMargin: parent.height*0.3
            rightMargin: parent.width*0.3
        }
        MyClock{
            id:myClock
            setHour: currentTime
            setFont: _FONT.clock.name
            setGradient: _STYLES.gradientBackground
            textColor:'white'
            backRadius: 20
            backBorderColor: 'black'
            anchors.fill: parent
        }
    }

    Rectangle{
        id:bottomPanel
        radius: 8
        border.width: 4
        gradient: _STYLES.gradientBackground
        anchors.fill: parent
        anchors{
            topMargin: parent.height*0.7
            rightMargin: parent.width*0.3
        }
        Row{
            id:row
            spacing: 10
            anchors{
                fill:parent
                topMargin: spacing
                bottomMargin: spacing
                leftMargin: spacing
                rightMargin: spacing*2
            }
            Repeater{
                id:repeater
                model:3
                anchors{
                    right: parent.right
                    rightMargin: row.spacing
                    top:parent.top
                    bottom:parent.bottom
                }
                Rectangle{
                    property string currentColor: (containerClicked) ? 'grey' : 'transparent'
                    property bool containerClicked:false
                    height: row.height
                    width: (row.width/3)-(repeater.model)
                    color:currentColor
                    border.width: 2
                    border.color: 'black'
                    radius: 10
                    Image {
                        id: img
                        anchors{
                            fill: parent
                            margins:5
                        }
                        source: shortcutsImg[index]
                        clip: false
                        asynchronous: false
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: containerClicked=!containerClicked
                        onReleased:{
                            containerClicked=!containerClicked
                            console.log('index '+index+' clicked!')
                            shortcutsLink[index]()
                        }
                    }
                }
            }
        }

    }

    Rectangle{
        id:sidePanel
        color: 'transparent'
        radius: 8
        border.width: 4
        anchors{
            top:parent.top
            bottom:parent.bottom
            right:parent.right
            left:myClockContainer.right
        }

        Rectangle{
            id:background
            rotation: 90
            gradient: _STYLES.gradientBackground
            width: parent.height
            height: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: gaugeContainer
            anchors.fill: parent
            anchors{
                topMargin: 4
                bottomMargin: 4
                leftMargin: 4
                rightMargin: 4
            }
            color: "transparent"
            Rectangle{
                 id: gaugeLevel
                 anchors.fill: parent
                 color:'transparent'
                 clip:true
                 anchors{
                     topMargin: 5
                     bottomMargin: 5
                     leftMargin: parent.width*0.58 //parent.width*0.5//0.62
                     rightMargin: 5
                 }
                 MyGauge{
                     anchors.fill:parent
                     myValue: waterTankObj.waterLevel()
                 }
            }

//            Gauge {
//                id: gaugeLevel
//                enabled: false
//                rotation: 0
//                value: waterTankObj.waterLevel()
//                z: 0
//                smooth: false
//                minimumValue: 0
//                maximumValue: 1000
//                minorTickmarkCount:3
//                tickmarkStepSize:100
//                orientation: Qt.Vertical
//                font.bold: true;
//                font.pixelSize: 12
//                clip: true
//                anchors.fill: parent
//                anchors{
//                    topMargin: 5
//                    bottomMargin: 5
//                    leftMargin: parent.width*0.5//0.62
//                    rightMargin: 5
//                }
//                // Must be sorted in descending order
//                property var steps: [
//                    {start:1023, color: "blue"},
//                    //                {start:1023/2, color: "lightyellow"},
//                    //                {start:1023/4, color: "red"},
//                ]
//                style: GaugeStyle {
//                    foreground: Item {

//                        clip: true
//                        Rectangle
//                        {
//                            width: parent.width
//                            opacity: 0.8
//                            z: 1
//                            anchors.top: parent.top
//                            height: (1-(gaugeLevel.value-gaugeLevel.minimumValue)/(gaugeLevel.maximumValue-gaugeLevel.minimumValue))*parent.height
//                        }
//                        Repeater
//                        {
//                            model: control.steps
//                            Rectangle
//                            {
//                                color: modelData.color
//                                width: 100
//                                y: (1-(modelData.start-gaugeLevel.minimumValue)/(gaugeLevel.maximumValue-gaugeLevel.minimumValue))*parent.height
//                                height: parent.height
//                            }
//                        }
//                    }
//                    valueBar: Item {
//                        implicitWidth: 100
//                    }
//                    tickmark: Item {
//                        implicitHeight: 1
//                        implicitWidth: 10

//                        Rectangle {
//                            color: "black"
//                            anchors.fill: parent; anchors.leftMargin: 3; anchors.rightMargin: 3
//                        }
//                    }
//                    minorTickmark: Item {
//                        implicitWidth: 8; implicitHeight: 10
//                        Rectangle {
//                            color: "black"
//                            anchors.fill: parent; anchors.leftMargin: 3; anchors.rightMargin: 3
//                        }
//                    }
//                }
//            }

        }

        Rectangle{
            anchors.fill: parent
            anchors.rightMargin: gaugeLevel.width
            color:'transparent'
            Column{
                id:rootColumn
                anchors.fill: parent
                anchors.margins: 10
                spacing:5
                Repeater{
                    id:sidePanelRepeater
                    model:3
                    width: parent.width
                    height: (parent.height/3)
                    Rectangle{
                        width: rootColumn.width
                        height: width//(parent.height/repeater.model)-repeater.model
                        color: sidePanelShortcutsColorConfig[index]
                        radius: 8
                        Text {
                            anchors.fill:parent
                            text: sidePanelShortcutsTextConfig[index]
                            color: "black"
                            fontSizeMode: "Fit"
                            textFormat: Text.PlainText
                            font.family: _FONT.system.name
                            font.pixelSize: parent.width*0.70
                            clip: true
                            //padding:5
                            anchors.margins:5
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
        }
        //        Rectangle{
        //            id:pumpStateContainer
        //            width: parent.width*0.4
        //            height: width
        //            radius: 8
        //            color: waterTankObj.currentPmpState(_CONST.colorObject)
        //            anchors{
        //                top: parent.top
        //                left: parent.left
        //                topMargin: 15
        //                leftMargin: 8
        //            }
        //            Text {
        //                id: pumpState
        //                text: waterTankObj.currentPmpState(_CONST.textObject)
        //                color: "white"
        //                fontSizeMode: "Fit"
        //                textFormat: Text.PlainText
        //                font.family: _FONT.system.name
        //                font.pixelSize: parent.width*0.70
        //                clip: true
        //                anchors.fill: parent
        //                padding:10
        //                verticalAlignment: Text.AlignVCenter
        //                horizontalAlignment: Text.AlignHCenter
        //            }
        //        }

        //        Rectangle{
        //            id:rec_aquario_status
        //            width: parent.width/2
        //            height: parent.width/2
        //            radius: 8
        //            anchors{
        //                top: pumpStateContainer.bottom
        //                left: parent.left
        //                topMargin: 8
        //                leftMargin: 8
        //            }
        //            Text {
        //                id: name_aquario_status
        //                anchors.fill: parent
        //                font.pixelSize: parent.width*0.3
        //                verticalAlignment: Text.AlignVCenter
        //                textFormat: Text.PlainText
        //                clip: true
        //                horizontalAlignment: Text.AlignHCenter
        //                color: "white"
        //            }
        //        }

        //        Rectangle{
        //            id:rec_aquario_contagem
        //            width: parent.width/2
        //            height: parent.width/2
        //            radius: 8
        //            border.color: "red"
        //            anchors{
        //                top: rec_aquario_status.bottom
        //                left: parent.left
        //                topMargin: 8
        //                leftMargin: 8
        //            }
        //            Text {
        //                id: name_aquario_contagem
        //                anchors.fill: parent
        //                font.pixelSize: parent.width*0.5
        //                verticalAlignment: Text.AlignVCenter
        //                textFormat: Text.PlainText
        //                clip: true
        //                horizontalAlignment: Text.AlignHCenter
        //                color: "black"
        //            }
        //        }

        MouseArea{
            id:quit_area
            width: 30
            height: 30
            anchors.fill: parent
            anchors{
                topMargin: parent.height*0.92
                bottomMargin: 2
                leftMargin: 2
                rightMargin: parent.width*0.8
            }

            Rectangle{
                id:rec_quit
                width: 30
                anchors.fill: parent
                radius: 20
                border.width: 2
                color: "red"
                Text {
                    id: name
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    textFormat: Text.PlainText
                    clip: true
                    font.pixelSize: parent.width*0.5
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("X")
                }
            }
            onClicked: Qt.quit()
        }

        MouseArea{
            id:fullscreearea
            width: quit_area.width
            height: quit_area.height
            anchors{
                left: quit_area.right
                bottom: parent.bottom
                leftMargin: 5
                bottomMargin: 2
            }

            Rectangle{
                id:rec_fullscreearea
                width: 30
                anchors.fill: parent
                radius: 20
                border.width: 2
                color: "blue"
                Text {
                    id: name_fullscreearea
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    textFormat: Text.PlainText
                    clip: true
                    font.pixelSize: parent.width*0.5
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("_")
                }
            }
            onClicked: window.visibility = "Windowed"
        }

    }
}

