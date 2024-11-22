import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0
import com.querymodel 1.0

Rectangle
{
    id: root

    property var queryModel
    property var headerModel
    property var tableModel: queryModel
    color: Constants.lightBackColor

    Row
    {
        id: horizontalHeader

        anchors.left: dbTable.left
        anchors.top: parent.top
        height: 40
        Repeater
        {
            model: root.headerModel
            Rectangle
            {
                required property string modelData
                implicitHeight: 40
                implicitWidth: root.width / headerModel.length
                color: Constants.lightBackColor
                border.color: Constants.defaultBorderColor
                border.width: 1

                Text
                {
                    anchors.centerIn: parent
                    text: parent.modelData
                    color: "white"
                    font.family: Constants.monoFontFamily
                }
            }
        }
    }

    TableView
    {
        id: dbTable

        model: root.tableModel
        anchors.left: parent.left
        anchors.top: horizontalHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds

        selectionModel: ItemSelectionModel{}

        delegate: Rectangle
        {
            required property bool selected
            required property bool current
            implicitHeight: 40
            implicitWidth: root.width / headerModel.length
            color: dbTable.currentRow === row ? Constants.selectedBlueBack : Constants.darkBackColor
            border.color: Constants.defaultBorderColor
            border.width:  current ? 2 : 1
            clip: true


            Text
            {
                anchors.centerIn: parent
                text: model[queryModel.userRoleNames[column]]
                color: "white"
                font.family: Constants.monoFontFamily
            }
        }
    }
}
