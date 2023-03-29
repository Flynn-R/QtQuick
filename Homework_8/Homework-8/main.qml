import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Dialogs

Window {
    width: 640
    height: 480
    visible: true
    title: "Hello World"

    Button {
        text: "Push me"
        anchors.centerIn: parent
        width: 100
        height: 50

        onClicked: dialog.open()
    }

    Dialog {
        id: dialog
        title: "And then just touch me"
        anchors.centerIn: parent
        standardButtons: Dialog.Ok

        Text {
            anchors.fill: parent
            text: "Till I get my satisfaction"
        }
    }
}
