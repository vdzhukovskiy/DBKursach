import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

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

        StackLayout
        {
            id: stack

            anchors.fill: parent

            currentIndex: 0

            LauncherScreen
            {

            }

            Rectangle
            {

                color: Constants.darkBackColor

                TableView {
                    id: dbTable
                    anchors.fill: parent
                    // model: DBConnector.getTable("Drivers")

                    delegate: Rectangle {
                        width: dbTable.width / 3
                        height: 40
                        border.color: "black"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: modelData // `modelData` содержит данные текущей ячейки
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
                stack.currentIndex = 1
                let model = DBConnector.getTable("Drivers");
                if (model) {
                    console.log("Model initialized:", model);
                    console.log("Available roles:", model.roleNames());
                    dbTable.model = model;
                } else {
                    console.error("Failed to initialize model.");
                }
            }
        }
    }
}
