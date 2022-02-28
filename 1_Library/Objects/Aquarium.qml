pragma Singleton

import QtQuick 2.0

QtObject {
    //  default communication values
    readonly property string defaulStartKey: '149'
    readonly property string defaulEndKey: '249'
    readonly property int startIndex: 8
    readonly property int endIndex: 18

    //  default colors and texts presentation
    readonly property int pmpOff: 0
    readonly property int pmpOn: 1
    readonly property int filterOn: 2
    readonly property int autoOn: 3

    //  received structure
    property int startKey
    property int luminosity
    property int feederCounter
    property int minTemperature
    property int maxTemperature
    property int currentTemperature
    property int timeToFeed
    property bool fanState
    property bool lightState
    property bool airPmpState
    property int endKey

    //  Default setpoints
    readonly property int _feederAlarm: 20

    //  set values
    property var setValues: function(inputString){
        if(inputString.length===11){
            startKey=inputString[0]
            luminosity=inputString[1]
            feederCounter=inputString[2]
            minTemperature=inputString[3]
            maxTemperature=inputString[4]
            currentTemperature=inputString[5]
            timeToFeed=inputString[6]
            fanState=inputString[7]
            lightState=inputString[8]
            airPmpState=inputString[9]
            endKey=inputString[10]
        }
    }

    //  return values
    property var feederCounterOutput: function(objType){
//        if(objType){
//            if(feederCounter>_feederAlarm){

//            }else return
//        } else return feederCounter+'x'
        return feederCounter+'x'
    }

//    Timer{
//        id:counterColorLoop
//        interval: 1000
//        running: false
//        repeat: true
//        onTriggered: {
//        }
//    }

    property var currentTemperatureValue: function(objType){
//        if(objType){
//            return
//        }
        var formatter=(currentTemperature/100).toFixed(2);
        return formatter+'°C'
    }

    property var currentPmpState: function(objType){
        var output
        switch(pumpState){
        case 0:
            output=(objType) ? 'lightgreen' : 'OFF'
            break
        case 1:
            output=(objType) ? 'red' : 'ON'
            break
        case 2:
            output=(objType) ? 'yellow' : 'FIL'
            break
        case 3:
            output=(objType) ? 'orange' : 'AUTO'
            break
        }
        return output
    }

    property var values: ({})

    property var getObject: function(){
        var myObject= new Object;
        myObject["startKey"]=startKey
        myObject["luminosity"]=luminosity
        myObject["feederCounter"]=feederCounter
        myObject["minTemperature"]=minTemperature
        myObject["maxTemperature"]=maxTemperature
        myObject["currentTemperature"]=currentTemperature
        myObject["timeToFeed"]=timeToFeed
        myObject["fanState"]=fanState
        myObject["lightState"]=lightState
        myObject["airPmpState"]=airPmpState
        myObject["endKey"]=endKey
        return myObject
    }

}
