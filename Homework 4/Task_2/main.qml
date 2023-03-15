import QtQuick
import QtCharts 2.3
import lsaClass 1.0
import QtQuick.Controls 2.5

Window {
    width: 640
    height: 480
    visible: true
    title: "The Method of Least Squares"

    ChartView {
        anchors.fill: parent
        title: "Least Square Approximation"
        antialiasing: true

        LSA {
            id: lsa
        }

        ScatterSeries {
            id: data
            name: "Data"

            axisX: ValuesAxis {
                min: 0
                max: 210
            }

            axisY: ValuesAxis {
                min: 0
                max: 30
            }
        }

        LineSeries {
            id: approx
            name: "Approximate function"
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < lsa.x.length; ++i)
            data.append(lsa.x[i], lsa.y[i])

        for (i = 0; i < lsa.X.length; ++i)
            approx.append(lsa.X[i], lsa.Y[i])
    }
}
