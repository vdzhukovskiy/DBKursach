import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0
import com.querymodel 1.0

Rectangle
{
    signal loaded()

    onLoaded:
    {
        drivers.model = DBConnector.driverNames()
    }

    SplitView
    {
        anchors.fill: parent

        handle: Rectangle
        {
            implicitWidth: 6
            implicitHeight: 4

            color: Constants.defaultBorderColor
        }

        spacing: 0

        Rectangle
        {
            id: controlRect

            SplitView.fillHeight: true
            SplitView.preferredWidth: 400
            SplitView.minimumWidth: 375

            color: Constants.defaultBorderColor

            Rectangle
            {
                anchors.fill: parent

                color: Constants.darkBackColor

                Rectangle
                {
                    id: headerRect

                    anchors
                    {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }

                    height: 41
                    color: Constants.defaultBorderColor

                    Rectangle
                    {
                        anchors.fill: parent
                        anchors.bottomMargin: 1

                        color: Constants.darkBackColor

                        MyLabel
                        {
                            anchors.centerIn: parent

                            text: qsTr("РАСПИСАНИЕ")
                            font.pixelSize: 25
                        }
                    }
                }

                ColumnLayout
                {
                    anchors
                    {
                        top: headerRect.bottom
                        left: parent.left
                        right: parent.right
                        margins: 10
                    }
                    spacing: 5

                    MyLabel
                    {
                        text: qsTr("Водитель:")
                    }

                    ComboBox
                    {
                        id: drivers

                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        Layout.preferredHeight: 30
                        Layout.bottomMargin: 15
                        font.pixelSize: 18

                        onCurrentTextChanged:
                        {
                            if(!currentText.length)
                                return
                            scheduleQuery.query = "CALL GetDriverSchedules('" + currentText + "');"
                        }
                    }
                }
                Connections
                {
                    target: DBConnector

                    function onUpdateTable()
                    {
                        loaded()
                    }
                }
            }
        }

        Rectangle
        {
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            SplitView.minimumWidth: parent.width / 3

            color: Constants.lightBackColor

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 5

                MyTable
                {
                    id: scheduleTable

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    SqlQueryModel
                    {
                        id: scheduleQuery

                        onQueryChanged:
                        {
                            scheduleTable.queryModel = scheduleQuery
                            scheduleTable.headerModel = scheduleQuery.userRoleNames
                        }
                    }
                }
            }
        }
    }
}
