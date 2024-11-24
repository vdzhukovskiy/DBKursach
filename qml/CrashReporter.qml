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

    SqlQueryModel
    {
        id: tableQuery
    }

    onLoaded:
    {
        tableQuery.query = "SELECT * FROM Incidents"
        crashTable.queryModel = tableQuery
        crashTable.headerModel = tableQuery.userRoleNames
    }

    MyTable
    {
        id: crashTable

        anchors
        {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        anchors.topMargin: 10
        anchors.leftMargin: 40
        anchors.rightMargin: 40
    }
}
