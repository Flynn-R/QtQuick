import QtQuick
import QtQuick.Controls 2.5

Window {
    width: 640
    height: 480
    visible: true
    title: "Квадрат Малевича"

        MouseArea {
            width: parent.width * 2 / 3
            height: parent.height * 2 / 3

            Rectangle {
                id: rect
                anchors.fill: parent
                color: getRandomColor()

                function getRandomColor() {
                    var max = 16777216
                    return Math.floor(Math.random() * max).toString(16)
                }
            }

            onClicked: {
                if (pressedButtons === Qt.LeftButton)
                    rect.c
            }
        }
}
