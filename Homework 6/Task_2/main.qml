import QtQuick
import QtQuick.Controls 2.5

Window {
    width: 640
    height: 480
    visible: true
    title: "Currency"

    Column {
        spacing: 5
        anchors.centerIn: parent

        Text {
            id: info
        }

        Text {
            id: trl
        }

        Text {
            id: jpy
        }

        Text {
            id: usd
        }
    }

    function getData() {
        var http = new XMLHttpRequest()
        var url = "https://www.cbr-xml-daily.ru/daily_json.js"

        http.onreadystatechange = function() {
            if (http.readyState == XMLHttpRequest.DONE && http.status == 200) {
                var jsonObj = JSON.parse(http.responseText)

                info.text = "Date: " + jsonObj.Date
                trl.text = "Turkish Lira: " + jsonObj.Valute.TRY.Value / jsonObj.Valute.TRY.Nominal
                jpy.text = "Japanese Yen: " + jsonObj.Valute.JPY.Value / jsonObj.Valute.JPY.Nominal
                usd.text = "US Dollar: " + jsonObj.Valute.USD.Value / jsonObj.Valute.USD.Nominal
            }
        }

        http.open("GET", url, true)
        http.send()
    }

    Component.onCompleted: {
        getData()
    }
}
