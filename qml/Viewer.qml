import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0
import com.querymodel 1.0

RowLayout
{
    spacing: 0

    Rectangle
    {
        id: controlRect

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

                    Layout.fillWidth: true

                    onCurrentTextChanged:
                    {
                        if(!currentText.length)
                            return;
                        queryModel.query = "SELECT * FROM " + currentText
                        sqlTable.queryModel = queryModel
                        sqlTable.headerModel = queryModel.userRoleNames
                        insertRow.updateInsert()
                    }
                    Connections
                    {
                        target: DBConnector
                        function onConnected()
                        {
                            tablesComboBox.model = DBConnector.tables()
                        }
                        function onUpdateTable()
                        {
                            queryModel.query = ""
                            queryModel.query = "SELECT * FROM " + tablesComboBox.currentText
                            sqlTable.queryModel = queryModel
                            sqlTable.headerModel = queryModel.userRoleNames
                        }
                    }
                }

                MyLabel
                {
                    Layout.fillWidth: true

                    text: qsTr("WHERE")
                    color: "white"
                    font.pixelSize: 16
                    font.family: Constants.monoFontFamily
                }

                ComboBox
                {
                    id: columnsComboBox

                    Layout.fillWidth: true

                    model: sqlTable.headerModel
                }

                MyLabel
                {
                    Layout.fillWidth: true

                    text: qsTr("LIKE")
                    color: "white"
                    font.pixelSize: 16
                    font.family: Constants.monoFontFamily
                }

                DTextField
                {
                    id: searchTextField

                    Layout.fillWidth: true

                    color: "white"

                    onEditingFinished:
                    {
                        if(text.length)
                            queryModel.query = "SELECT * FROM " + tablesComboBox.currentText +
                                               " WHERE " + columnsComboBox.currentText + " LIKE '%" + searchTextField.text + "%'"
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

        ColumnLayout
        {
            anchors.fill: parent
            anchors.margins: 10

            MyTable
            {
                id: sqlTable

                Layout.fillWidth: true
                Layout.fillHeight: true

                deletable: true

                queryModel: SqlQueryModel
                {
                    id: queryModel
                }

                onDeleteRow:
                {
                    DBConnector.deleteRow(rowNum, tablesComboBox.currentText)
                }
            }

            Item
            {
                id: insertRow

                function updateInsert()
                {
                    tfRepeater.model = queryModel.userRoleNames.length > 0 ? queryModel.userRoleNames.length - 1 : 0
                    insertRLayout.itemWidth = sqlTable.width / queryModel.userRoleNames.length
                }

                Layout.fillWidth: true
                Layout.preferredHeight: 40

                RowLayout
                {
                    id: insertRLayout

                    property int itemWidth: 0

                    anchors.fill: parent

                    spacing: 0

                    MyButton
                    {
                        Layout.preferredWidth: insertRLayout.itemWidth
                        Layout.preferredHeight: 40

                        backgroundColor: Constants.darkBackColor

                        onPressed:
                        {
                            var values = []
                            for(let i = 0; i < tfRepeater.model; i++)
                            {
                                if(!tfRepeater.itemAt(i).text.length)
                                    return
                                values.push(tfRepeater.itemAt(i).text)
                            }
                            DBConnector.insertRow(tablesComboBox.currentText, values)

                            for(let i = 0; i < tfRepeater.model; i++)
                            {
                                tfRepeater.itemAt(i).text = ""
                            }
                        }

                        text: qsTr("Добавить запись")
                    }

                    Repeater
                    {
                        id: tfRepeater

                        DTextField
                        {
                            Layout.preferredWidth: insertRLayout.itemWidth
                            Layout.preferredHeight: 40
                            width: insertRLayout.itemWidth
                            height: 40

                            backgroundColor: Constants.darkBackColor
                        }
                    }
                }
            }
        }
    }
}
