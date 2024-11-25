import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

import com.dbconnector 1.0

TextField
{
    id: userNameTextField

    color: "white"
    font.pixelSize: 16
    font.family: Constants.monoFontFamily
    background: Rectangle
    {
        color: Constants.lightBackColor
        border.color: Constants.defaultBorderColor
        border.width: 1
        radius: 2
    }
}
