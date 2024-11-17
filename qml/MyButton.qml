import QtQuick 2.0
import QtQuick.Controls 2.0

Button
{
    id: control

    property color backgroundColor: Constants.darkBackColor
    property color borderColor: Constants.defaultBorderColor

    text: qsTr("Button")

    contentItem: Text
    {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle
    {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: control.pressed ? Qt.lighter(control.backgroundColor, 1.1) :
                                   control.hovered ? Qt.lighter(control.backgroundColor, 1.3) : control.backgroundColor
        border.color: control.borderColor

        border.width: 1
        radius: 2
    }
}
