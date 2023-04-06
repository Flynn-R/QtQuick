import QtQuick
import QtQuick.LocalStorage 2.15
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels
import "DBFuncs.js" as DBFuncs

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("DB Example")
    property int cellHorizontalSpacing: 10
    property var db

    TableModel {
        id: tableModel
        TableModelColumn { display: "ID" }
        TableModelColumn { display: "Name" }
        TableModelColumn { display: "Mass" }
    }

    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("Database")
        try {
            db.transaction((tx) => {DBFuncs.createTable(tx, 0)})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Sol", "1")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Mecrury", "1.651E-7")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Venus", "0.000002447")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Earth", "0.000003003")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Mars", "3.213E-7")})

            db.transaction((tx) => {DBFuncs.createTable(tx, 1)})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 1, "Local Interstellar Cloud", "~10E6")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 1, "Sagittarius A*", "4.154E6")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 1, "M72", "1.68E5")})

            db.transaction((tx) => {DBFuncs.createTable(tx, 2)})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 2, "Andromeda Galaxy", "1.5E12")})
//            db.transaction((tx) => {DBFuncs.addRecord(tx, 2, "Triangulum Galaxy", "5E10")})

            db.transaction((tx) => {DBFuncs.readTable(tx, tableChange.currentIndex, table.model)})
        } catch (err) {
            console.log(err)
        }
    }

    ComboBox {
        id: tableChange
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 5
        width: parent.width - 15
        height: 30
        model: ["Solar System", "Milky Way", "Local Group"]

        onCurrentTextChanged: {
            try {
                db.transaction((tx) => { DBFuncs.readTable(tx, tableChange.currentIndex, table.model) })
            } catch (err) {
                console.log(err)
            }
        }

        RotationAnimator {
            id: opened
            target: canvas
            from: 0
            to: 90
            duration: 500
            direction: RotationAnimation.Shortest
        }

        RotationAnimator {
            id: closed
            target: canvas
            from: 90
            to: 0
            duration: 500
            direction: RotationAnimation.Shortest
        }

        delegate: ItemDelegate {
            width: tableChange.width
            contentItem: Text {
                text: tableChange.textRole
                    ? (Array.isArray(tableChange.model) ? modelData[tableChange.textRole] : model[tableChange.textRole])
                    : modelData
                font: tableChange.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            highlighted: tableChange.highlightedIndex === index
        }

        indicator: Canvas {
            id: canvas
            x: tableChange.width - width - tableChange.rightPadding
            y: tableChange.topPadding + (tableChange.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            Connections {
                target: tableChange
                function onPressedChanged() { canvas.requestPaint(); }
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = tableChange.pressed ? "white" : "black";
                context.fill();
            }
        }

        contentItem: Text {
            leftPadding: 5
            rightPadding: tableChange.indicator.width + tableChange.spacing

            text: tableChange.displayText
            font: tableChange.font
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 40
            border.width: tableChange.visualFocus ? 2 : 1
            radius: 5
        }

        popup: Popup {
            y: tableChange.height - 1
            width: tableChange.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: tableChange.popup.visible ? tableChange.delegateModel : null
                currentIndex: tableChange.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }

                onCurrentItemChanged: {
                    tableChange.currentIndex = currentIndex
                }
            }

            background: Rectangle {
                border.color: "black"
                radius: 5
            }

            onOpened: opened.start()
            onClosed: closed.start()
        }
    }

    TableView {
        id: table
        anchors.top: tableChange.bottom
        anchors.margins: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: contentHeight
        columnSpacing: 1
        rowSpacing: 1
        model: tableModel

        delegate: Rectangle {
            implicitWidth: Math.max(100, cellHorizontalSpacing + innerText.width + cellHorizontalSpacing)
            implicitHeight: 50
            border.width: 1

            Text {
                id: innerText
                text: display
                anchors.centerIn: parent
            }
        }
    }

    Button {
        id: addRecord
        width: 100
        height: 35
        anchors.left: parent.left
        anchors.top: table.bottom
        anchors.margins: 5
        text: "Add record"

        onClicked: addDialog.open()
    }

    Button {
        id: editRecord
        width: 100
        height: 35
        anchors.right: parent.right
        anchors.top: table.bottom
        anchors.margins: 5
        text: "Edit record"

        onClicked: editDialog.open()
    }

    Dialog {
        id: addDialog
        anchors.centerIn: parent
        title: "Add row"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Column {
            anchors.fill: parent
            spacing: 5

            TextField {
                id: addName
                placeholderText: "Name"
            }

            TextField {
                id: addMass
                placeholderText: "Mass (solar masses)"
            }
        }

        onAccepted: {
            try {
                db.transaction((tx) => {
                    var resObj = DBFuncs.addRecord(tx, tableChange.currentIndex, addName.text, addMass.text)
                    if (resObj.rowsAffected !== 0)
                        tableModel.appendRow({ID: resObj.insertId, Name: addName.text, Mass: addMass.text})
                })
            } catch (err) {
                console.log(err)
            }
            addName.clear()
            addMass.clear()
        }
    }

    Dialog {
        id: editDialog
        anchors.centerIn: parent
        title: "Edit row"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Column {
            anchors.fill: parent
            spacing: 5

            TextField {
                id: editID
                placeholderText: "ID"
            }

            TextField {
                id: editName
                placeholderText: "New name"
            }

            TextField {
                id: editMass
                placeholderText: "New mass (solar masses)"
            }
        }

        onAccepted: {
            try {
                db.transaction((tx) => {DBFuncs.editTable(tx, tableChange.currentIndex, editID.text, editName.text, editMass.text)})
                db.transaction((tx) => {DBFuncs.readTable(tx, tableChange.currentIndex, table.model)})
            } catch (err) {
                console.log(err)
            }
            editID.clear()
            editName.clear()
            editMass.clear()
        }
    }
}
