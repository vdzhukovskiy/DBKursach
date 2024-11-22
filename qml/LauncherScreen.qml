import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0

Rectangle
{
    color: Constants.lightBackColor

    Label
    {
        text: qsTr("BUS ADMIN")
        anchors.bottom: connectButton.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin:50
        color: Constants.selectedBlueFore
        font.pixelSize: 150
        font.family: Constants.monoFontFamily
    }

    Rectangle
    {
        anchors.left: connectButton.right
        anchors.top: connectButton.top
        anchors.leftMargin: 20

        width: 300
        height: 400

        color: Constants.darkBackColor
        border.color: Constants.defaultBorderColor
        border.width: 2

        ColumnLayout
        {
            id: loginColumn

            property int textfieldHeight: 40
            property int textfieldFontSize: 18
            property int labelFontSize: 14

            anchors
            {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: 10
            }

            MyLabel
            {
                Layout.fillWidth: true

                text: qsTr("Host Name:")
            }

            DTextField
            {
                id: hostnameTextField

                Layout.fillWidth: true
                Layout.bottomMargin: 8
                Layout.preferredHeight: parent.textfieldHeight

                text: "damsel8s.beget.tech"
            }

            MyLabel
            {
                Layout.fillWidth: true

                text: qsTr("Database Name:")
            }

            DTextField
            {
                id: databaseNameTextField

                Layout.fillWidth: true
                Layout.bottomMargin: 8
                Layout.preferredHeight: parent.textfieldHeight

                text: "damsel8s_zhukkp"
            }

            MyLabel
            {
                Layout.fillWidth: true

                text: qsTr("User Name:")
            }

            DTextField
            {
                id: userNameTextField

                Layout.bottomMargin: 8
                Layout.fillWidth: true
                Layout.preferredHeight: parent.textfieldHeight
                text: "damsel8s_zhukkp"
            }

            MyLabel
            {
                Layout.fillWidth: true

                text: qsTr("Password:")
            }

            DTextField
            {
                id: passwordTextField

                Layout.fillWidth: true
                Layout.preferredHeight: parent.textfieldHeight

                text: "Admin123"
            }
        }
    }

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
            if(hostnameTextField.text && databaseNameTextField.text && userNameTextField.text && passwordTextField.text)
                DBConnector.addDatabase(hostnameTextField.text, databaseNameTextField.text, userNameTextField.text, passwordTextField.text)
        }

        Label
        {
            id: connectLabel
            text: qsTr("ПОДКЛЮЧЕНИЕ")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -50
            color: Constants.selectedBlueFore
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
            source: "qrc:/icons/qml/bus-selected.svg"
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
                    color: "white"
                }
                PropertyChanges
                {
                    target: connectImg
                    source: "qrc:/icons/qml/bus.svg"
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
