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
        crashTableQuery.query    = "SELECT
                                    i.id AS incident_id,
                                    b.license_plate AS bus_number,
                                    d.name AS driver_name,
                                    i.data AS incident_date,
                                    i.description,
                                    i.severity
                                    FROM
                                        Incidents i
                                    JOIN
                                        Buses b ON i.bus_id = b.id
                                    JOIN
                                        Drivers d ON i.driver_id = d.id;
                                    "
        scheduleTableQuery.query = "SELECT
                                    s.id AS schedule_id,
                                    r.route_number AS route_number,
                                    b.license_plate AS bus_number,
                                    d.name AS driver_name,
                                    s.departure_time,
                                    s.arrival_time,
                                    s.status
                                    FROM
                                        Schedules s
                                    JOIN
                                        Routes r ON s.route_id = r.id
                                    JOIN
                                        Buses b ON s.bus_id = b.id
                                    JOIN
                                        Drivers d ON s.driver_id = d.id;
                                    "
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

                            text: qsTr("РЕГИСТРАЦИЯ ИНЦИДЕНТА")
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
                        text: qsTr("Имя водителя, попавшего в инцидент:")
                    }

                    DTextField
                    {
                        id: driverName

                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        Layout.preferredHeight: 30
                        Layout.bottomMargin: 5
                        font.pixelSize: 18
                    }

                    MyLabel
                    {
                        text: qsTr("Номер автобуса, попавшего в инцидент:")
                    }

                    DTextField
                    {
                        id: busNumber

                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        Layout.preferredHeight: 30
                        Layout.bottomMargin: 5
                        font.pixelSize: 18
                    }

                    MyLabel
                    {
                        text: qsTr("Дата инцидента:")
                    }

                    DTextField
                    {
                        id: date

                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        Layout.preferredHeight: 30
                        Layout.bottomMargin: 5
                        font.pixelSize: 18
                    }

                    MyLabel
                    {
                        text: qsTr("Описание:")
                    }

                    DTextField
                    {
                        id: description

                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        Layout.preferredHeight: 30
                        Layout.bottomMargin: 5
                        font.pixelSize: 18
                    }

                    MyLabel
                    {
                        text: qsTr("Серьезность:")
                    }

                    ComboBox
                    {
                        id: severity

                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        Layout.preferredHeight: 30
                        Layout.bottomMargin: 15
                        font.pixelSize: 18

                        model:
                            [
                                "Низкий",
                                "Средний",
                                "Высокий"
                            ]
                    }

                    MyButton
                    {
                        Layout.fillWidth: true
                        Layout.leftMargin: 10
                        Layout.rightMargin: 10
                        Layout.preferredHeight: 40

                        text: qsTr("ЗАРЕГИСТРИРОВАТЬ")
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
