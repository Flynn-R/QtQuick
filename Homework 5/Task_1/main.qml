import QtQuick
import QtQuick.Controls 2.5
import "qrc:/Figures.js" as Figures

Window {
    width: 640
    height: width + 50
    visible: true
    title: "Task 1"

    ComboBox {
        id: figures
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 100
        height: 40
        model: [ "Star", "Ring", "House", "Hourglass" ]

        onCurrentIndexChanged: {
            cnvs.requestPaint()
        }
    }

    Canvas {
        id: cnvs
        anchors.top: figures.bottom
        anchors.topMargin: 10
        width: parent.width
        height: parent.width
        property int radius: width / 2

        onPaint: {
            var context = getContext("2d")
            context.clearRect(0, 0, width, height)
            context.fillStyle = Qt.rgba(1, 0, 1, 1)
            var coords

            switch (figures.currentIndex) {
            case 0:
                context.beginPath()

                context.moveTo(radius, 0)
                coords = Figures.figure(figures.currentIndex, radius)

                for (var i = 0; i < coords.length; ++i)
                    context.lineTo(coords[i][0], coords[i][1])

                context.closePath()
                context.lineWidth = 5
                context.stroke()
                context.fill()
                break
            case 1:
                context.beginPath()

                context.arc(radius, radius, width / 3, 0, 2 * Math.PI)

                context.closePath()
                context.lineWidth = 5
                context.stroke()
                context.fill()

                context.beginPath()

                context.arc(radius, radius, width / 4, 0, 2 * Math.PI)

                context.closePath()
                context.fillStyle = Qt.rgba(1, 1, 1, 1)
                context.stroke()
                context.fill()
                break
            case 2:
                context.beginPath()

                context.moveTo(radius, 4 * radius / 5)
                coords = Figures.figure(figures.currentIndex, radius)
                for (i = 0; i < coords[0].length; ++i)
                    context.lineTo(coords[0][i][0], coords[0][i][1])

                context.moveTo(2 * radius / 5, 3 * radius / 5)
                for (i = 0; i < coords[1].length; ++i)
                    context.lineTo(coords[1][i][0], coords[1][i][1])

                context.closePath()
                context.lineWidth = 5
                context.stroke()
                context.fill()
                break
            case 3:
                context.beginPath()

                coords = Figures.figure(figures.currentIndex, width)

                context.moveTo(coords[0][0], coords[0][1])

                for (i = 0; i < (coords.length - 1);) {
                    if (i == 6 || i == 13)
                        context.lineTo(coords[++i][0], coords[i][0])
                    else
                        context.bezierCurveTo(coords[i][0], coords[i++][1], coords[i][0], coords[i++][1], coords[i][0], coords[i][1])
                }

                context.closePath()
                context.lineWidth = 5
                context.stroke()
                context.fill()
                break
            default:
                break
            }
        }
    }
}
