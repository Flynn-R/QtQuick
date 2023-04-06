import QtQuick
import QtQuick.Controls 2.5

Rectangle {
    id: result
    width: primaryFrame.width * 2 / 3
    height: primaryFrame.height
    anchors.centerIn: parent
    color: "white"
    property string res

    ScrollView {
        anchors.fill: parent
        height: resultText
        contentWidth: availableWidth
        contentHeight: availableHeight

        Text {
            id: resultText
            font.pointSize: 13
        }

        Button {
            id: back
            text: "Назад"
            width: parent.width - 15
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: resultText.bottom
            anchors.topMargin: 15

            onClicked: loader.sourceComponent = regForm
        }
    }

    Component.onCompleted: resultText.text = res
}
