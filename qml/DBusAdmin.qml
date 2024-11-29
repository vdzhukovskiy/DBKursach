import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0
import com.querymodel 1.0

Page
{
    id: root

    signal returnToMainMenu()

    header: Rectangle
    {
        implicitHeight: 100

        color: Constants.defaultBorderColor
        Rectangle
        {
            anchors.fill: parent
            anchors.bottomMargin: 5
            color: Constants.lightBackColor

            RowLayout
            {
                anchors.fill: parent

                MyButton
                {
                    id: returnButton

                    Layout.leftMargin: 15

                    implicitWidth: Constants.headerItemHeight
                    implicitHeight: Constants.headerItemHeight
                    text: ""

                    Image
                    {
                        anchors.centerIn: parent
                        height: 24
                        width: 24
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/icons/qml/arrow-u-up-left-svgrepo-com.svg"
                    }

                    onClicked: root.returnToMainMenu()
                }

                MyButton
                {
                    id: viewerButton

                    Layout.leftMargin: 10

                    implicitWidth: 150
                    implicitHeight: Constants.headerItemHeight
                    backgroundColor: Constants.darkBackColor
                    text: ""

                    RowLayout
                    {
                        anchors.centerIn: parent

                        spacing: 5

                        Image
                        {
                            height: 20
                            width: 20
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/icons/qml/view.svg"
                        }

                        MyLabel
                        {
                            text: qsTr("ОБЗОР")
                            font.pixelSize: 20
                        }
                    }

                    onClicked:
                    {
                        pageStack.currentIndex = 0
                    }
                }

                MyButton
                {
                    id: crashButton

                    Layout.leftMargin: 10

                    implicitWidth: 250
                    implicitHeight: Constants.headerItemHeight
                    backgroundColor: Constants.darkBackColor
                    text: ""

                    RowLayout
                    {
                        anchors.centerIn: parent

                        spacing: 5


                        Image
                        {
                            height: 24
                            width: 24
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/icons/qml/crash.svg"
                        }

                        MyLabel
                        {
                            width: 50
                            wrapMode: Text.WordWrap
                            text: qsTr("Зарегистрировать\n       инцидент")

                            font.pixelSize: 16
                        }
                    }

                    onClicked:
                    {
                        pageStack.currentIndex = 1
                        crashReporter.loaded()
                    }
                }

                MyButton
                {
                    id: timetableButton

                    Layout.leftMargin: 10

                    implicitWidth: 200
                    implicitHeight: Constants.headerItemHeight
                    backgroundColor: Constants.darkBackColor
                    text: ""

                    RowLayout
                    {
                        anchors.centerIn: parent

                        spacing: 5


                        Image
                        {
                            height: 24
                            width: 24
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/icons/qml/calendar.svg"
                        }

                        MyLabel
                        {
                            width: 50
                            wrapMode: Text.WordWrap
                            text: qsTr("Расписание \n водителя")

                            font.pixelSize: 16
                        }
                    }

                    onClicked:
                    {
                        pageStack.currentIndex = 2
                        driversTimetable.loaded()
                    }
                }

                Item
                {
                    Layout.fillWidth: true
                }
            }
        }
    }

    Item
    {
        anchors.fill: parent

        StackLayout
        {
            id: pageStack

            anchors.fill: parent                    

            Viewer
            {}

            CrashReporter
            {
                id: crashReporter
            }

            DriversTimetable
            {
                id: driversTimetable
            }
        }
    }
}
