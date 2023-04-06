import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Dialogs

Window {
    width: 800
    height: 540
    visible: true
    title: "DONKI"

    ListModel {
        id: model
    }

    ListView {
        id: view
        anchors.fill: parent
        model: model

        header: Rectangle {
            width: parent.width
            height: 35
            color: "blue"

            Row {
                anchors.centerIn: parent
                spacing: 10

                ComboBox {
                    id: dataType
                    anchors.verticalCenter: parent.verticalCenter
                    width: 250
                    height: 25
                    model: ["Geomagnetic Storm (GST)", "Coronal Mass Ejection (CME)", "Solar Flare (FLR)", "Solar Energetic Particle (SEP)", "Radiation Belt Enhancement (RBE)"]
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "from"
                    color: "white"
                    font.pointSize: 15
                }

                TextField {
                    id: fromDate
                    anchors.verticalCenter: parent.verticalCenter
                    placeholderText: "yyyy-MM-dd"
                    validator: RegularExpressionValidator {
                        regularExpression: /[1-2][0-9]{3}-[0-1][0-9]-[0-3][0-9]/
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "to"
                    color: "white"
                    font.pointSize: 15
                }

                TextField {
                    id: toDate
                    anchors.verticalCenter: parent.verticalCenter
                    placeholderText: "yyyy-MM-dd"
                    validator: RegularExpressionValidator {
                        regularExpression: /[1-2][0-9]{3}-[0-1][0-9]-[0-3][0-9]/
                    }
                }

                Button {
                    id: get
                    width: 100
                    height: 25
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Get"

                    onClicked: getModel(fromDate.text, toDate.text, dataType.currentIndex)
                }
            }
        }

        delegate: Rectangle {
            width: parent.width
            height: 30
            color: "white"
            border.color: "black"
            Text {
                id: r
                anchors.centerIn: parent
                text: first + second
            }
        }
    }

    Dialog {
        id: dialog
        anchors.centerIn: parent
        title: "Please, wait..."

        BusyIndicator {
            anchors.centerIn: parent
            running: true
        }
    }

    function getModel(startDate, endDate, dataType) {
        dialog.visible = true
        var http = new XMLHttpRequest()

        var urls = [
            "https://api.nasa.gov/DONKI/GST?startDate=" + startDate + "&endDate=" + endDate + "&api_key=DEMO_KEY",
            "https://api.nasa.gov/DONKI/CME?startDate=" + startDate + "&endDate=" + endDate + "&api_key=DEMO_KEY",
            "https://api.nasa.gov/DONKI/FLR?startDate=" + startDate + "&endDate=" + endDate + "&api_key=DEMO_KEY",
            "https://api.nasa.gov/DONKI/SEP?startDate=" + startDate + "&endDate=" + endDate + "&api_key=DEMO_KEY",
            "https://api.nasa.gov/DONKI/RBE?startDate=" + startDate + "&endDate=" + endDate + "&api_key=DEMO_KEY"
        ]

        http.onreadystatechange = function() {
            model.clear()
            if (http.readyState == XMLHttpRequest.DONE && http.status == 200) {
                var jsonObj = JSON.parse(http.responseText)

                for (var i = 0; i < jsonObj.length; ++i) {
                    switch (dataType) {
                    case 0:
                        for (var j = 0; j < jsonObj[i].allKpIndex.length; ++j)
                            model.append({"first": "Time (UTC): " + jsonObj[i].allKpIndex[j].observedTime, "second": "; K-index: " + jsonObj[i].allKpIndex[j].kpIndex})
                        break
                    case 1:
                        model.append({"first": "Time (UTC): " + jsonObj[i].startTime, "second": "; source: " + jsonObj[i].sourceLocation})
                        break
                    case 2:
                        model.append({"first": "Time (UTC): " + jsonObj[i].peakTime, "second": "; class type: " + jsonObj[i].classType})
                        break
                    case 3:
                        model.append({"first": "Time (UTC): " + jsonObj[i].eventTime, "second": ""})
                        break
                    case 4:
                        model.append({"first": "Time (UTC): " + jsonObj[i].eventTime, "second": ""})
                        break
                    }
                }
                dialog.visible = false
            }
        }

        switch (dataType) {
        case 0:
            http.open("GET", urls[0], true)
            break
        case 1:
            http.open("GET", urls[1], true)
            break
        case 2:
            http.open("GET", urls[2], true)
            break
        case 3:
            http.open("GET", urls[3], true)
            break
        case 4:
            http.open("GET", urls[4], true)
            break
        }
        http.send()
    }
}
