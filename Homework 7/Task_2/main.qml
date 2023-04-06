import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 700
    height: 400
    visible: true
    title: qsTr("DataList Example")

    function getFriendsText(friends) {
        var resString = ""
        for (const friend of friends)
            resString += friend + ", "

        return resString.slice(0, -2);
    }

    ListView {
        anchors.fill: parent
        model: mdl
        spacing: 2

        delegate: SwipeView {
            width: parent.width
            height: 50
            Item {
                Row {
                    anchors.fill: parent
                    spacing: 2

                    Rectangle {
                        width: 70
                        height: parent.height
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: rowId
                        }
                    }

                    Rectangle {
                        width: 100
                        height: parent.height
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: name
                        }
                    }

                    Rectangle {
                        width: 100
                        height: parent.height
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: surname
                        }
                    }
                }
            }

            Item {
                Rectangle {
                    width: 150
                    height: parent.height
                    border.width: 1

                    Text {
                        anchors.fill: parent
                        text: "Friends: " + getFriendsText(friends)
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        header: Row {
            width: parent.width
            height: 50
            spacing: 2

            Rectangle {
                width: 70
                height: parent.height
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "rowId"
                }
            }

            Rectangle {
                width: 100
                height: parent.height
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "name"
                }
            }

            Rectangle {
                width: 100
                height: parent.height
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "surname"
                }
            }
        }
    }
}
