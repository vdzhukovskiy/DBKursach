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
                    }
                    Connections
                    {
                        target: DBConnector
                        function onConnected()
                        {
                            tablesComboBox.model = DBConnector.tables()
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
                                    " WHERE CONVERT(" + columnsComboBox.currentText + ", char) = " + searchTextField.text
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

            deletable: true

            queryModel: SqlQueryModel
            {
                id: queryModel
            }

            onDeleteRow:
            {
                DBConnector.deleteRow(index, tablesComboBox.currentText)
            }
        }
    }
}
