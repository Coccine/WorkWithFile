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

    Timer {
        id: timer
        repeat: true
        onTriggered: {
            filei.openAndModification(choiceFiles.files, modeMask.text,
                                      switchRemove.position,
                                      savedDirectory.folder.toString())
        }
    }
    Timer {
        id: timerChecker
        running: reloadTime.text != "" && fileComp.paths != "" ? true : false
        repeat: true
        interval: parseInt(reloadTime.text) * 1000
        onTriggered: {
            filei.fileExists(choiceFiles.files)
        }
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
            id: modeMask
            height: 30
            width: parent.width
            placeholderText: "Введите маску модификации файла(HEX)"
            horizontalAlignment: TextField.AlignHCenter
            font.pixelSize: 16
            maximumLength: 16
            validator: RegExpValidator {
                regExp: /[0-9A-F]+/
            }
        }
        Separator {
            width: parent.width
        }
        TextField {
            id: reloadTime
            height: 30
            width: parent.width
            font.pixelSize: 14
            placeholderText: "Периодичность опроса наличия входного файла(сек)"
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
            id: switchRemove
            height: 40
            text: "Удалить входные файлы"
        }

        Row {
            height: 40
            width: parent.width
            Switch {
                height: parent.height
                width: parent.width * 0.4
                text: "По таймеру(ceк)"
                onPositionChanged: startBtn.visible = !startBtn.visible
            }
            SpinBox {
                id: timerInterval
                height: parent.height
                width: parent.width * 0.3
                from: 1
                visible: !startBtn.visible
            }
            Button {
                height: parent.height
                width: parent.width * 0.3
                text: "Ок"
                visible: !startBtn.visible
                onClicked: {
                    timer.interval = timerInterval.value * 1000
                    timer.start()
                }
            }
        }
        Separator {
            _color: "green"
            height: 2
        }

        Button {
            id: startBtn
            width: parent.width
            height: 30
            Text {
                anchors.centerIn: parent
                text: qsTr("Начать")
                color: "green"
                font.pixelSize: 20
            }
            onClicked: {
                filei.openAndModification(choiceFiles.files, modeMask.text,
                                          switchRemove.position,
                                          savedDirectory.folder.toString())
            }
        }
    }
    Connections {
        target: filei
    }
}
