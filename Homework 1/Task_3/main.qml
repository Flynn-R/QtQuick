import QtQuick
import QtQuick.Controls 2.5
import Calculator 0.1

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Площадь треугольника")

    Column {
        anchors.centerIn: parent
        spacing: 2

        Row {
            spacing: 2

            Label {
                text: "A = ("
                color: "black"
            }

            TextField {
                id: _a
                width: 50
            }

            Label {
                text: ")"
                color: "black"
            }
        }

        Row {
            spacing: 2

            Label {
                text: "B = ("
                color: "black"
            }

            TextField {
                id: _b
                width: 50
            }

            Label {
                text: ")"
                color: "black"
            }
        }

        Row {
            spacing: 2

            Label {
                text: "C = ("
                color: "black"
            }

            TextField {
                id: _c
                width: 50
            }

            Label {
                text: ")"
                color: "black"
            }
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            id: _calculate
            text: "Вычислить"

            onClicked: {
                _result.text =  _calculator.execByCoord(_a.text, _b.text, _c.text)
            }
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            id: _result
            color: "black"
        }

        Calculator {
            id: _calculator
        }
    }
}
