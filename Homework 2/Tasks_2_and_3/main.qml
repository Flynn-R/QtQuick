import QtQuick
import QtQuick.Controls 2.5

Window {
    width: 640
    height: 480
    visible: true
    title: "Аниме"

    Rectangle {
        id: rect
        anchors.centerIn: parent
        width: parent.width * 2 / 3
        height: parent.height * 2 / 3
        color: getRandomColor()

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: {
                if (mouse.button === Qt.LeftButton)
                    parent.color = parent.getRandomColor()
                else if (mouse.button === Qt.RightButton)
                    rotate.start()
            }

            onDoubleClicked: {
                parent.height = parent.width
                parent.radius = parent.height / 2
            }
        }

        RotationAnimator {
            id: rotate
            target: rect
            from: 0
            to: 360
            duration: 5000
            easing.type: Easing.InOutQuad
        }

        function getRandomColor() {
            var max = 16777216
            return "#" + Math.floor(Math.random() * max).toString(16)
        }
    }
}
