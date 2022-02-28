import QtQuick 2.3

Item {
    signal headerClicked(int headerIndex)
    property var headerMenus: ['item 1','item 2','item 3','item 4','item 5']

    property string textColor: 'black'
    property string pressedColor:'white'

    property bool clicked: false

    id: root
    height: 100
    width: 600

    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        Row{
            anchors.fill: parent
            //            spacing: 10
            Repeater{
                height: parent.height
                width: root.width/5
                model: 5
                Rectangle{
                    border.color: 'grey'
                    border.width: 1
                    height: parent.height
                    color: 'transparent'
                    width: root.width/5
                    Text {
                        id: name
                        text: headerMenus[index]
                        color: textColor
                        anchors.fill: parent
                        anchors.margins: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{}
                        onPressed: {
                            name.color=pressedColor
                        }
                        onReleased: {
                            name.color=textColor
                            root.headerClicked(index)
                        }
                    }
                }
            }
        }
    }
}
