import QtQuick 2.5
import QtQuick.Controls 2.5

Item {
    property string type
    property string paths
    Row {
        anchors.fill: parent
        ScrollView {
            width: parent.width * 0.75
            height: parent.height
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            contentHeight: text.height
            contentWidth: -1
            clip: true
            Text {
                id: text
                text: paths
                width: parent.width * 0.75
                wrapMode: Text.Wrap
                font.pixelSize: 14

            }
        }

        Button {
            id: btn
            text: "Open " + type
            width: parent.width * 0.25
            height: parent.height
            onClicked: type == "files" ? choiceFiles.open(
                                             ) : savedDirectory.open()
        }
    }
}
