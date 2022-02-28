function sortArray(inputArray,startRange,endRange){
    var i=-1
    var outputArray=inputArray.filter(function(value){
        i++
        if(i>=startRange && i<=endRange)return true
        return false
    })
    return outputArray
}

function splitSerialRead(myArray,myObj){
    var outputArray
    var success=errorHandling(function(){
        if(Array.isArray(myArray) || myArray.length>0){
            switch(myObj){
            case _CONST._aquarium:
                if(myArray[aquariumObj.startIndex]===aquariumObj.defaulStartKey)
                    outputArray=sortArray(myArray,aquariumObj.startIndex,aquariumObj.endIndex)
                break
            case _CONST._waterTank:
                if(myArray[waterTankObj.startIndex]===waterTankObj.defaulStartKey)
                    outputArray=sortArray(myArray,waterTankObj.startIndex,waterTankObj.endIndex)
                break
            default:
                outputArray=['']
            }
        }else return 0
    },'splitSerialRead()[Javascript/Functions.js]')
    return outputArray
}
