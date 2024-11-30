import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0

TextField
{
    id: userNameTextField

    property color backgroundColor: Constants.lightBackColor

    color: "white"
    font.pixelSize: 16
    font.family: Constants.monoFontFamily
    background: Rectangle
    {
        color: backgroundColor
        border.color: Constants.defaultBorderColor
        border.width: 1
        radius: 2
    }
}
