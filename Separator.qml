import QtQuick 2.0

Item {
    height: 2
    property string _color: "black"
    Rectangle{
        height: parent.height
        width: parent.width
        color: _color
        anchors.leftMargin: 5
        anchors.rightMargin: 5
    }
}
