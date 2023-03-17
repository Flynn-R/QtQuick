import QtQuick
import QtQuick.Controls 2.5

Rectangle {
    id: rect
    width: 500
    height: width
    radius: 10

    Column {
        spacing: 10

        TextField {
            id: login
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Login"
        }

        TextField {
            id: password
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        Button {
            id: auth
            text: "Sign in"
        }
    }
}
