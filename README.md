Financial register by Gabriel
Done on QtCreator with C++,QML and Javascript languages

Tested platform: Raspberry Pi 3
OS: Raspbian Jessie

First commit: 28/02/2022
First Qt project: start develop with Qt on march 2021
First project: was using Arduino-Firmata + MyOpenLab back to 2019

This is a reformulated version from previous projects

###################################################################################################
######################################## SOFTWARE PROPOSAL ########################################
###################################################################################################

    This is a Human Machine Interface that will show the data colected from the arduino througth
USB serial.

     Version 1.0: Can read water tank level value, water pressure pump state and aquarium
     temperature and number times that the feeder operates

###################################################################################################
######################################## SOFTWARE REQUIREMENTS ####################################
###################################################################################################

........................................Under construction.........................................

###################################################################################################
######################################## BUILD ENVIROMENT #########################################
###################################################################################################

Architeture: arm 32bits
QtCreator: 3.2.1
Qt: 5.3.2
GCC: 4.9.2

###################################################################################################
######################################## F0LDER STRUCTURE #########################################
###################################################################################################

0_Archive          => {Fonts, Images, Media, Scripts}
1_Library/AppSetup => {Constants, ProjectFonts, ProjectStyles}
1_Library/Objects  => {Aquarium, WaterTank}
2_Components       => {MyClock, MyGauge, MyHeader}
3_Screens          => {CameraScreen, HomeScreen, TestScreen}
4_Javascript       => {Functions}
5_C                => {appclock,arduinoread,filemanager}

###################################################################################################
######################################## HARDWARE STRUCTURE #######################################
###################################################################################################

........................................Under construction.........................................
