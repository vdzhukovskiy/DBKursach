import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0
import com.querymodel 1.0

Rectangle
{
    id: root

    signal loaded()

    color: Constants.lightBackColor

    onLoaded:
    {
        crashTableQuery.query = "SELECT * FROM Incidents"
        scheduleTableQuery.query = "SELECT * FROM Schedules"
    }

    RowLayout
    {
        anchors.fill: parent

        spacing: 0

        Rectangle
        {
            id: controlRect

            Layout.fillHeight: true
            Layout.preferredWidth: 400

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


                }
            }
        }

        Rectangle
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: Constants.lightBackColor

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 5

                MyTable
                {
                    id: crashTable

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    SqlQueryModel
                    {
                        id: crashTableQuery

                        onQueryChanged:
                        {
                            crashTable.queryModel = crashTableQuery
                            crashTable.headerModel = crashTableQuery.userRoleNames
                        }
                    }
                }

                MyTable
                {
                    id: scheduleTable

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    SqlQueryModel
                    {
                        id: scheduleTableQuery

                        onQueryChanged:
                        {
                            scheduleTable.queryModel = scheduleTableQuery
                            scheduleTable.headerModel = scheduleTableQuery.userRoleNames
                        }
                    }
                }
            }
        }
    }
}
