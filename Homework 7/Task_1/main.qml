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
            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Sol", "1")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Mecrury", "1.651E-7")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Venus", "0.000002447")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Earth", "0.000003003")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 0, "Mars", "3.213E-7")})

            db.transaction((tx) => {DBFuncs.createTable(tx, 1)})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 1, "Local Interstellar Cloud", "~10E6")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 1, "Sagittarius A*", "4.154E6")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 1, "M72", "1.68E5")})

            db.transaction((tx) => {DBFuncs.createTable(tx, 2)})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 2, "Andromeda Galaxy", "1.5E12")})
            db.transaction((tx) => {DBFuncs.addRecord(tx, 2, "Triangulum Galaxy", "5E10")})

            db.transaction((tx) => {DBFuncs.readTable(tx, tableChange.currentIndex, table.model)})
        } catch (err) {
            console.log(err)
        }
    }

    ComboBox {
        id: tableChange
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 5
        width: parent.width
        height: 30
        model: ["Solar System", "Milky Way", "Local Group"]

        onCurrentTextChanged: {
            try {
                db.transaction((tx) => { DBFuncs.readTable(tx, tableChange.currentIndex, table.model) })
            } catch (err) {
                console.log(err)
            }
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
                placeholderText: "Name"
            }

            TextField {
                id: editMass
                placeholderText: "Mass (solar masses)"
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
