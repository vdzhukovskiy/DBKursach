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
        {}

        DBusAdmin
        {
            onReturnToMainMenu: stack.currentIndex = 0
        }

        Connections
        {
            target: DBConnector
            function onConnected()
            {
                stack.currentIndex = 1
            }
        }
    }
}
