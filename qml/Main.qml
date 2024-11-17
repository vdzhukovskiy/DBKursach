import QtQuick 2.0
import QtQuick.Controls 2.0

import com.dbconnector 1.0

Window
{
    width: 1920
    height: 1080
    visible: true
    title: qsTr("BusPark Watcher")
    Page
    {
        anchors.fill: parent

        Rectangle
        {
            anchors.fill: parent

            color: Constants.darkBackColor

            MyButton
            {
                id: connectButton

                anchors.centerIn: parent

                implicitHeight: parent.height / 2
                implicitWidth: parent.width / 4
                state: "default"

                text: ""
                // borderColor: hovered ? Constants.selectedBlueFore : Constants.defaultBorderColor
                borderColor: Constants.defaultBorderColor

                onClicked:
                {
                    DBConnector.addDatabase()
                }

                Label
                {
                    id: connectLabel
                    text: qsTr("ПОДКЛЮЧЕНИЕ")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -50
                    // color: connectButton.hovered ? Constants.selectedBlueFore : "white"
                    color: "white"
                    font.pixelSize: 30
                    font.family: "Mono Font Family"
                }

                Image
                {
                    id: connectImg
                    anchors.centerIn: parent

                    height: parent.height - 10
                    width: parent.width - 10
                    fillMode: Image.PreserveAspectFit
                    // source: connectButton.hovered ? "qrc:/icons/qml/bus-selected.svg" : "qrc:/icons/qml/bus.svg"
                    source: "qrc:/icons/qml/bus.svg"
                }

                states:
                [
                    // State
                    // {
                    //     name: "default"
                    //     PropertyChanges
                    //     {
                    //         target: connectButton
                    //         borderColor: Constants.defaultBorderColor
                    //         backgroundColor: Constants.darkBackColor
                    //     }
                    //     PropertyChanges
                    //     {
                    //         target: connectLabel
                    //         color: "white"
                    //     }
                    //     PropertyChanges
                    //     {
                    //         target: connectImg
                    //         source: "qrc:/icons/qml/bus.svg"
                    //     }
                    // },
                    State
                    {
                        name: "hovered"
                        when: connectButton.hovered
                        PropertyChanges
                        {
                            target: connectButton
                            borderColor: Constants.selectedBlueFore
                            backgroundColor: "#172c3e"
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
    }
}
