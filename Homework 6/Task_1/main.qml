import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Dialogs

Window {
    width: 800
    height: 540
    visible: true
    title: "Geomagnetic Storm"

    ListModel {
        id: gst
    }

    ListModel {
        id: cme
    }

    ListModel {
        id: flr
    }

    ListModel {
        id: sep
    }

    ListModel {
        id: rbe
    }

    ListView {
        id: view
        anchors.fill: parent
        property string txt

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

                    onClicked: {
                        switch (dataType.currentIndex) {
                        case 0:
                            view.model = gst
                            break
                        case 1:
                            view.model = cme
                            break
                        case 2:
                            view.model = flr
                            break
                        case 3:
                            view.model = sep
                            break
                        case 4:
                            view.model = rbe
                            break
                        }

                        getModel(fromDate.text, toDate.text, dataType.currentIndex)
//                        getResult(dataType.currentIndex)
                    }
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
                text: view.txt
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

    function getResult(dataType) {
        switch (dataType) {
        case 0:
            view.txt = "Time (UTC): " + gst.time + "; K-index: " + gst.index
            break
        case 1:
            view.txt = "Time (UTC): " + cme.time + "; source: " + cme.source
            break
        case 2:
            view.txt = "Time (UTC): " + flr.time + "; class: " + flr.classType
            break
        case 3:
            view.txt = "Time (UTC): " + sep.time
            break
        case 4:
            view.txt = "Time (UTC): " + rbe.time
            break
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
            if (http.readyState == XMLHttpRequest.DONE && http.status == 200) {
                var jsonObj = JSON.parse(http.responseText)

                for (var i = 0; i < jsonObj.length; ++i) {
                    switch (dataType) {
                    case 0:
                        for (var j = 0; j < jsonObj[i].allKpIndex.length; ++j)
                            gst.append({"time": jsonObj[i].allKpIndex[j].observedTime, "index": jsonObj[i].allKpIndex[j].kpIndex})
                        break
                    case 1:
                        cme.append({"time": jsonObj[i].startTime, "source": jsonObj[i].sourceLocation})
                        break
                    case 2:
                        flr.append({"time": jsonObj[i].peakTime, "classType": jsonObj[i].classType})
                        break
                    case 3:
                        sep.append({"time": jsonObj[i].eventTime})
                        break
                    case 4:
                        rbe.append({"time": jsonObj[i].eventTime})
                        break
                    }
                }
                dialog.visible = false
            }
        }

        switch (dataType) {
        case 0:
            http.open("GET", urls[0], true)
            view.txt = "Time (UTC): " + gst.time + "; K-index: " + gst.index
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
