import QtQuick
import QtQuick.Controls 2.5

Window {
    width: 640
    height: 480
    visible: true
    title: "Books"

    ListModel {
        id: books

        ListElement {
            iconPath: "qrc:/HolyBible.jpg"
            name: "Holy Bible"
            genre: "Manga"
            author: "-"
        }

        ListElement {
            iconPath: "qrc:/Chainsawman.jpg"
            name: "Chainsaw Man"
            genre: "Lifestyle"
            author: "Tatsuki Fujimoto"
        }

        ListElement {
            iconPath: "qrc:/Buzova.jpg"
            name: "Delo v shpil'ke"
            genre: "Religion"
            author: "Olga Buzova"
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        model: books
        spacing: 5

        header: Rectangle {
            width: parent.width
            height: 30
            color: "orange"

            Text {
                font.weight: Font.Bold
                font.pointSize: 25
                font.family: "Helvetica"
                color: "blue"
                anchors.centerIn: parent
                text: "Private collection from Ernest Halimov"
            }
        }

        footer: Rectangle {
            width: parent.width
            height: 20
            color: "black"

            Text {
                color: "white"
                anchors.centerIn: parent
                text: "Developer - Pierre Dunn"
            }
        }

        section.delegate: Rectangle {
            width: parent.width
            height: 30
            color: "pink"

            Text {
                anchors.centerIn: parent
                text: section
                color: "green"
                font.weight: Font.Bold
            }
        }

        section.property: "genre"

        delegate: Rectangle {
            width: parent.width
            height: image.sourceSize.height + 50
            radius: 5
            border.width: 1
            border.color: "cyan"
            color: "yellow"

            Column {
                anchors.fill: parent
                spacing: 20

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20

                    Image {
                        id: image
                        source: iconPath
                    }

                    Text {
                        font.pointSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                        text: name
                        color: "green"
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20

                    Text {
                        font.pointSize: 15
                        text: "Genre: " + genre
                        color: "green"
                    }

                    Text {
                        font.pointSize: 15
                        text: "Author: " + author
                        color: "green"
                    }
                }
            }
        }
    }
}
