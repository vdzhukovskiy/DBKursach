import QtQuick 2.0
import QtQuick.Controls 2.0

import com.dbconnector 1.0

Rectangle
{
    color: Constants.lightBackColor

    MyButton
    {
        id: connectButton

        anchors.centerIn: parent

        implicitHeight: parent.height / 2
        implicitWidth: parent.width / 4
        state: "default"

        text: ""
        borderColor: Constants.defaultBorderColor

        onClicked:
        {
            DBConnector.addDatabase()
        }

        Label
        {
            text: qsTr("BUS ADMIN")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -400
            color: "white"
            font.pixelSize: 150
            font.family: Constants.monoFontFamily
        }

        Label
        {
            id: connectLabel
            text: qsTr("ПОДКЛЮЧЕНИЕ")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -50
            color: "white"
            font.pixelSize: 30
            font.family: Constants.monoFontFamily
        }

        Image
        {
            id: connectImg
            anchors.centerIn: parent

            height: parent.height - 10
            width: parent.width - 10
            fillMode: Image.PreserveAspectFit
            source: "qrc:/icons/qml/bus.svg"
        }

        states:
            [
            State
            {
                name: "hovered"
                when: connectButton.hovered
                PropertyChanges
                {
                    target: connectButton
                    borderColor: Constants.selectedBlueFore
                    backgroundColor: Constants.selectedBlueBack
                }
                PropertyChanges
                {
                    target: connectLabel
                    color: Constants.selectedBlueFore
                }
                PropertyChanges
                {
                    target: connectImg
                    source: "qrc:/icons/qml/bus-selected.svg"
                }
            }
        ]
        transitions: Transition
        {
            ColorAnimation
            {
                duration: 150
            }
        }
    }
}
