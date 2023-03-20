import QtQuick
import QtQuick.Controls 2.5

Rectangle {
    id: secondaryFrame
    color: "white"
    radius: 5
    width: 300
    height: 250
    anchors.centerIn: parent
    property string textColor: "#535353"
    property string login: "login"
    property string password: "password"
    signal signedIn

    Column {
        anchors.fill: parent
        padding: 32
        spacing: 32

        TextField {
            id: loginTextField
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Логин")
            color: secondaryFrame.textColor
            Keys.onEnterPressed: checkCredentials()
            Keys.onReturnPressed: checkCredentials()
        }

        TextField {
            id: passwordTextField
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Пароль")
            color: secondaryFrame.textColor
            Keys.onEnterPressed: checkCredentials()
            Keys.onReturnPressed: checkCredentials()
        }

        Button {
            id: submitButton
            width: 200
            height: 40
            text: qsTr("Вход")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: checkCredentials()

            background: Rectangle {
                color: parent.down ? "#bbbbbb" : (parent.hovered ? "#d6d6d6" : "#f6f6f6")
            }
        }
    }

    ParallelAnimation{
        id: failAnimation

        SequentialAnimation {
            PropertyAnimation {
                targets: [loginTextField, passwordTextField]
                property: "color"
                to: "dark red"
                duration: 0
            }
            PropertyAnimation {
                targets: [loginTextField, passwordTextField]
                property: "color"
                to: secondaryFrame.textColor
                duration: 400
            }
        }
        SequentialAnimation {
            NumberAnimation {
                target: secondaryFrame
                property: "anchors.horizontalCenterOffset"
                to: -5
                duration: 50
            }
            NumberAnimation {
                target: secondaryFrame
                property: "anchors.horizontalCenterOffset"
                to: 5
                duration: 100
            }
            NumberAnimation {
                target: secondaryFrame
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
    }

    SequentialAnimation{
        id: successAnimation

        PropertyAnimation {
            targets: [loginTextField, passwordTextField, submitButton]
            property: "opacity"
            to: 0
            duration: 400
        }
        PropertyAnimation {
            target: secondaryFrame
            property: "opacity"
            to: 0
            duration: 600
        }

        onFinished: {
            signedIn()
        }
    }

    function checkCredentials() {
        if (login === loginTextField.text && password === passwordTextField.text)
            successAnimation.start()
        else
            failAnimation.start()
    }

    onSignedIn: {
        loader.sourceComponent = regForm
    }
}
