import QtQuick
import QtQuick.Controls 2.5

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: "Log in"
    color: "#4b0082"

    Rectangle {
        id: rect
        anchors.centerIn: parent
        width: 300
        height: 200
        visible: true
        color: "white"
        radius: 10

        state: "log_in"

        Timer {
            interval: 3000
            running: rect.state === "searching"

            onTriggered: rect.state = "complete"
        }

        Column {
            id: loginColumn
            anchors.topMargin: 50
            anchors.fill: parent
            spacing: 5
            visible: true

            TextField {
                id: login
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 10
                placeholderText: "Login"
            }

            TextField {
                id: password
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 10
                placeholderText: "Password"
            }

            Button {
                id: loginButton
                text: "Log in"
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 10
                height: 40

                onClicked: rect.state = "authorized"
            }
        }

        Column {
            id: authorizedColumn
            anchors.fill: parent
            anchors.topMargin: 50
            spacing: 5
            visible: false

            Button {
                id: searchButton
                text: "Start search"
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 50
                height: 50

                onClicked: rect.state = "searching"
            }
        }

        Column {
            id: searchingColumn
            anchors.fill: parent
            anchors.topMargin: 50
            spacing: 5
            visible: false

            BusyIndicator {
                anchors.horizontalCenter: parent.horizontalCenter
                running: rect.state === "searching"
            }
        }

        Column {
            id: completeColumn
            anchors.fill: parent
            anchors.topMargin: 50
            spacing: 5
            visible: false

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Search is complete!"
                font.pointSize: 15
                color: "black"
            }
        }

        states: [
            State {
                name: "authorized"

                PropertyChanges {
                    target: login
                    opacity: 0
                }

                PropertyChanges {
                    target: password
                    opacity: 0
                }

                PropertyChanges {
                    target: loginButton
                    opacity: 0
                }

                PropertyChanges {
                    target: authorizedColumn
                    visible: true
                }

                PropertyChanges {
                    target: loginColumn
                    visible: false
                }

                PropertyChanges {
                    target: root
                    title: "Authorized"
                }
            },

            State {
                name: "searching"

                PropertyChanges {
                    target: authorizedColumn
                    visible: false
                }

                PropertyChanges {
                    target: searchingColumn
                    visible: true
                }

                PropertyChanges {
                    target: loginColumn
                    visible: false
                }

                PropertyChanges {
                    target: rect
                    color: "grey"
                }

                PropertyChanges {
                    target: root
                    title: "Searching..."
                }
            },

            State {
                name: "complete"

                PropertyChanges {
                    target: loginColumn
                    visible: false
                }

                PropertyChanges {
                    target: completeColumn
                    visible: true
                }

                PropertyChanges {
                    target: rect
                    color: "white"
                }

                PropertyChanges {
                    target: root
                    title: "Done!"
                }
            }
        ]

        transitions: [
            Transition {
                from: "log_in"
                to: "authorized"

                PropertyAnimation {
                    property: "opacity"
                    duration: 2000
                    easing.type: Easing.OutExpo
                }

                PropertyAnimation {
                    property: "visible"
                    duration: 2000
                }
            },

            Transition {
                from: "authorized"
                to: "searching"


                ColorAnimation {
                    duration: 200
                    easing.type: Easing.InExpo
                }
            },

            Transition {
                from: "searching"
                to: "complete"


                ColorAnimation {
                    duration: 200
                    easing.type: Easing.OutExpo
                }
            }
        ]
    }
}
