import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    readonly property bool debugOn:false

    property real myValue: slider.value*myMaxValue
    onMyValueChanged: levelAnimation.running=true

    property real myMinValue:0
    property real myMaxValue: 1000

    property string myBackgroundColor:'pink'
    property string myLevelColor:'blue'

    property int myTickQuantity: 5
    property var myTickLegend: [100,75,50,25,0]

    property NumberAnimation levelAnimation:
        NumberAnimation {
        target: levelValue
        property: "height"
        duration: 600
        easing.type: Easing.InOutQuad
        from: levelValue.height
        to: getLevelValue(myValue,myMinValue,myMaxValue)
    }



    function getLevelValue(inputValue,inputMinValue,inputMaxValue){
        var output=(inputValue - inputMinValue) * (levelRoot.height - 0) / (inputMaxValue - inputMinValue) + 0;
        return output
    }

    function setAlignment(index){
        switch(index){
        case 0:return 18
        case 1:return 130
        case 2:return 150
        case 3:return 150
        case 4:return 150
        }
    }

    Component.onCompleted: levelValue.height=getLevelValue(myValue,myMinValue,myMaxValue)

    id:root
    height: 600
    width: 200

    Rectangle{
        id:levelRoot
        color:myBackgroundColor
        anchors.fill: parent
        anchors.leftMargin: 44
        Rectangle{
            property real currentValue:height
            property real nextValue

            id:levelValue
            color:myLevelColor
            anchors{
                bottom:parent.bottom
                left:parent.left
                right:parent.right
            }
        }

    }

    Rectangle{
        id:tickMarkRoot
        color:'transparent'
        anchors.fill: parent
        anchors.rightMargin: levelRoot.width
        Column{
            id:column
            anchors.fill: parent
            Repeater{
                id:repeater
                model:myTickQuantity
                Rectangle{
                    height: setAlignment(index)
                    width: tickMarkRoot.width
                    color:'transparent'
                    border.width: (debugOn) ? 1:0
                    Text {
                        id:text
                        //                    anchors.fill: parentw
                        width: tickMarkRoot.width
                        anchors.fill:parent
                        text: myTickLegend[index]+'% - '
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignBottom
                    }}
            }}
    }

    Rectangle{
        id:debugRec
        color:'transparent'
        anchors.fill:parent
        visible:debugOn
        Text{
            anchors.fill: parent
            horizontalAlignment: Qt.AlignRight
            text: "Level: "+getLevelValue(myValue,myMinValue,myMaxValue)+'\n'+
                  'levelRoot.height: '+levelRoot.height
                  +'\nmyValue: '+myValue
                  +'\nmyMinValue: '+myMinValue
                  +'\nmyMaxValue: '+myMaxValue
                  +'\nslider: '+slider.value
        }
        Slider {
            id: slider
            value: 0.25
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

}
