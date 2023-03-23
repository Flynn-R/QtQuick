import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: "Weather"

    Text {
        id: info
        anchors.centerIn: parent
    }

    function getData() {
        var http = new XMLHttpRequest()
        var url = "https://api.gismeteo.net/v2/weather/current/4534/?lang=en"

        http.onreadystatechange = function() {
            if (http.readyState == XMLHttpRequest.DONE && http.status == 200) {
                var jsonObj = JSON.parse(http.responseText)

                info.text = "Date (UTC/Local): " + jsonObj.date.UTC + "/" + jsonObj.date.local +
                        "\n" + jsonObj.description.full +
                        "\nTemperature: " + jsonObj.temperature.air + "C, feels like " + jsonObj.temperature.comfort +
                        "C\nHumidity: " + jsonObj.humidity.percent + "%"
            }
        }

        http.open("GET", url, true)
        http.setRequestHeader('X-Gismeteo-Token', '56b30cb255.3443075') // Токен взят из примера в документации, он не работает
        http.send()
    }
}
