import QtQuick 2.0

Item {
    property string setHour: "13:50"    
    property var splitter: function(i){
        var input=setHour.split(':');
        var array=['--',':','--']
        if(input.length>0){
        var firstN,secondN
        if(input[0].length===1)firstN='0'+input[0]
        else firstN=input[0]
        if(input[1].length===1)secondN='0'+input[1]
        else secondN=input[1]
        array=[firstN,':',secondN];
        }
        return array[i]
    }

    property bool hourBlinker: false

    property string setFont
    property string textColor: 'orange'

    property string backColor: 'blue'
    property int backRadius: 6
    property int backBorderWidth: 2
    property string backBorderColor: 'green'
    property var setGradient

    id: root
    width: 500
    height: 500

    Timer{
        id:blink
        interval: 1000
        running: true
        repeat: true
        onTriggered:hourBlinker=!hourBlinker
    }

    Rectangle{
        id: clockTextContainer
        radius: backRadius
        anchors.fill: parent
        anchors.margins:10
        border.width: backBorderWidth
        border.color: backBorderColor
        gradient: setGradient
        Row{
            id:row
            anchors.fill: parent
            Repeater{
                model: 3
                anchors{
                    top:parent.top
                    bottom:parent.bottom
                }
                Rectangle{
                    property var setSize:function(i){
                        if(i===1) return clockTextContainer.width*0.05
                        return clockTextContainer.width*0.475
                    }
                    height: parent.height
                    color: 'transparent'
                    width:setSize(index)
                    Text {
                        property var blinkPoints: function(){
                            if(index===1){
                                if(hourBlinker)return true
                                else return false
                            }
                        }
                        property var setTextSize:function(i){
                            if(i===1) return parent.width*8
                            return parent.width*0.75
                        }
                        color: textColor
                        visible: blinkPoints()
                        text: splitter(index)
                        font.family: setFont
                        font.pixelSize: setTextSize(index)
//                        verticalAlignment: row.verticalCenter
//                        horizontalAlignment: row.horizontalCenter
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.fill: parent
                    }
                }
            }
        }
    }
}
