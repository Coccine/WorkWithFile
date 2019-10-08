import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import Qt.labs.platform 1.1

Window {
    visible: true
    width: 400
    height: 480
    title: qsTr("Help")
    FileDialog {
        id: choiceFiles
        title: "Выберите файлы"
        fileMode: FileDialog.OpenFiles
        nameFilters: filter.text
        onAccepted: fileComp.paths = files.toString()
    }
    FolderDialog {
        id: savedDirectory
        title: "Выберите директорию для сохранения"
        onAccepted: dirComp.paths = folder.toString()
    }
    FileDialog {
        id: saveFiles
        title: "Сохранение"
        fileMode: FileDialog.SaveFile
        //currentFiles:
    }

    Timer {
        id: timer
    }

    Column {
        anchors.fill: parent
        ToolBar {
            ToolButton {
                text: "Справка"
                onClicked: programMenu.open()
            }

            Menu {
                id: programMenu
                MenuItem {
                    text: "О программе"
                }
            }
        }
        TextField {
            id: filter
            placeholderText: "Введите маску файлов"
            width: parent.width
            height: 30
            font.pixelSize: 16
            horizontalAlignment: TextField.AlignHCenter
        }
        Separator {
            width: parent.width
        }
        TextField {
            height: 30
            width: parent.width
            placeholderText: "Маска модификации файла"
            horizontalAlignment: TextField.AlignHCenter
            font.pixelSize: 16
            maximumLength: 16
        }
        Separator {
            width: parent.width
        }
        TextField {
            id: reloadTime
            height: 30
            width: parent.width
            font.pixelSize: 16
            placeholderText: "Переодичность опроса(сек)"
            horizontalAlignment: TextField.AlignHCenter
            validator: IntValidator {
                bottom: 0
                top: 999
            }
        }
        Separator {
            width: parent.width
        }
        Text {
            text: qsTr("Входные файлы:")
            font.pixelSize: 20
            horizontalAlignment: Text.horizontalCenter
            color: "lightblue"
        }
        Separator {
            width: parent.width
            height: 1
            _color: "lightblue"
        }
        PathComponent {
            id: fileComp
            type: "files"
            height: 50
            width: parent.width
        }
        Separator {
            width: parent.width
        }
        Text {
            text: qsTr("Выходные файлы:")
            font.pixelSize: 20
            horizontalAlignment: Text.horizontalCenter
            color: "lightblue"
        }
        Separator {
            width: parent.width
            height: 1
            _color: "lightblue"
        }
        PathComponent {
            id: dirComp
            type: "directory"
            height: 50
            width: parent.width
        }
        Separator {
            width: parent.width
        }

        Switch {
            height: 40
            text: "Удалить входные файлы"
        }
        Switch {
            height: 40
            width: parent.width
            text: "По таймеру"
        }
        Button {
            width: parent.width
            height: 30
            Text {
                anchors.centerIn: parent
                text: qsTr("Начать")
                color: "green"
                font.pixelSize: 20
            }
        }
    }
}
