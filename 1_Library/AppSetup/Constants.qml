pragma Singleton

import QtQuick 2.0

QtObject {
    //  object types id
    readonly property int textObject:0
    readonly property int colorObject:1

    //    Screen ids
    readonly property int _homeScreen:0
    readonly property int _cameraScreen:1

    //  Objects ids
    readonly property int _aquarium:0
    readonly property int _waterTank:1

    //  External files
    readonly property string _stream:'file:///tmp/output_file.ts'
}
