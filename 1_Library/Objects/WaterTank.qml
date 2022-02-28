pragma Singleton

import QtQuick 2.0

QtObject {
    //  default communication values
    readonly property string defaulStartKey: '153'
    readonly property string defaulEndKey: '253'
    readonly property int startIndex: 1
    readonly property int endIndex: 7

    //  default colors and texts presentation
    readonly property int pmpOff: 0
    readonly property int pmpOn: 1
    readonly property int filterOn: 2
    readonly property int autoOn: 3

    //  received structure
    property int startKey
    property int pressureSensor
    property int pumpState
    property int flowState
    property int failure
    property int comm
    property int endKey

    //  set values
    property var setValues: function(inputString){
        if(inputString.length===7){
            startKey=inputString[0]
            pressureSensor=inputString[1]
            pumpState=inputString[2]
            flowState=inputString[3]
            failure=inputString[4]
            comm=inputString[5]
            endKey=inputString[6]
        }
    }

    //  return values
    property var waterLevel: function(){
        var in_min=40;
        var in_max=87;
        var out_min=0;
        var out_max=52;

        var waterHeight = (pressureSensor - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
        var volume;

        if (waterHeight < 22)
            volume = (13273 * waterHeight) / 1000 // 3217 -> pi * raio1 ²

        if ((waterHeight >= 22) && (waterHeight <= 40))
            volume = ((15837 * (waterHeight - 22)) / 1000) + 292 // 292 -> Volume do anel inferior

        if (waterHeight > 40)
            volume = ((17 * (waterHeight - 40)) + 292 + 427)

        if (volume > 1000)volume = 1000
        if (volume < 0)volume = 0

        return volume
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
        var myObject= new Object
        myObject["startKey"]=startKey
        myObject["pressureSensor"]=pressureSensor
        myObject["pumpState"]=pumpState
        myObject["flowState"]=flowState
        myObject["failure"]=failure
        myObject["comm"]=comm
        myObject["endKey"]=endKey
        return myObject
    }

}


//"a153a
//82
//0a
//0a
//0a
//0a
//253

//a
//149a79a16a-6a0a-6a79a0a1a1a249
//a
//153a0a199a828.96a299a"

