import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0
import com.querymodel 1.0

Window
{
    width: 1920
    height: 1080
    visible: true
    title: qsTr("BusPark Watcher")

    StackLayout
    {
        id: stack

        anchors.fill: parent

        currentIndex: 0

        LauncherScreen
        {

        }

        Page
        {
            header: Rectangle
            {
                implicitHeight: 100
                // implicitWidth: parent.width

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

                            // Layout.verticalCenter: parent.verticalCenter
                            Layout.leftMargin: 20

                            implicitWidth: 60
                            implicitHeight: 60
                            text: ""

                            Image
                            {
                                anchors.centerIn: parent
                                height: 24
                                width: 24
                                fillMode: Image.PreserveAspectFit
                                source: "qrc:/icons/qml/arrow-u-up-left-svgrepo-com.svg"
                            }
                            onClicked:
                            {
                                stack.currentIndex = 0
                            }
                        }
                    }

                }
            }

            Item
            {
                anchors.fill: parent
                RowLayout
                {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle
                    {
                        id: controlRect

                        // Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 200

                        color: Constants.defaultBorderColor

                        Rectangle
                        {
                            anchors.fill: parent
                            anchors.rightMargin: 2

                            color: Constants.darkBackColor

                            ColumnLayout
                            {
                                anchors.fill: parent
                                anchors.margins: 10
                                ComboBox
                                {
                                    id: tablesComboBox
                                    // Layout.fillWidth: true
                                    // Layout.fillHeight: true

                                    onCurrentTextChanged:
                                    {
                                        if(!currentText.length)
                                            return;
                                        queryModel.query = "SELECT * FROM " + currentText
                                        sqlTable.tableModel = queryModel
                                        sqlTable.headerModel = queryModel.userRoleNames
                                    }
                                }

                                Label
                                {
                                    text: qsTr("WHERE")
                                    color: "white"
                                    font.pixelSize: 16
                                    font.family: Constants.monoFontFamily
                                }

                                ComboBox
                                {
                                    id: columnsComboBox
                                    // Layout.fillWidth: true
                                    // Layout.fillHeight: true
                                    model: sqlTable.headerModel
                                }

                                Label
                                {
                                    text: qsTr("LIKE")
                                    color: "white"
                                    font.pixelSize: 16
                                    font.family: Constants.monoFontFamily
                                }

                                TextField
                                {
                                    id: searchTextField
                                    color: "white"
                                    font.pixelSize: 16
                                    font.family: Constants.monoFontFamily
                                    background: Rectangle
                                    {
                                        color: Constants.lightBackColor
                                    }

                                    onEditingFinished:
                                    {
                                        if(text.length)
                                            queryModel.query = "SELECT * FROM " + tablesComboBox.currentText +
                                                    " WHERE " + columnsComboBox.currentText + " LIKE " + searchTextField.text
                                        else
                                            queryModel.query = "SELECT * FROM " + tablesComboBox.currentText
                                    }
                                }

                                Item
                                {
                                    id: spacer
                                    Layout.fillHeight: true
                                }
                            }
                        }
                    }

                    Rectangle
                    {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        color: Constants.lightBackColor
                        MyTable
                        {
                            id: sqlTable
                            anchors.fill: parent
                            anchors.margins: 10

                            queryModel: SqlQueryModel
                            {
                                id: queryModel
                            }
                        }
                    }

                }
            }

            Connections
            {
                target: DBConnector
                function onConnected()
                {
                    tablesComboBox.model = DBConnector.tables()

                    // queryModel.query = "SELECT * FROM Buses"
                    // sqlTable.tableModel = queryModel
                    // sqlTable.headerModel = queryModel.userRoleNames


                    stack.currentIndex = 1
                }
            }
        }
    }

}
