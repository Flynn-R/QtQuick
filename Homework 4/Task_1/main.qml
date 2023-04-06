import QtQuick
import QtCharts 2.15
import QtQuick.Controls 2.5
import myCharts 1.0
import QtQuick.Layouts 1.3

Window {
    id: root
    width: 640
    height: 700
    visible: true
    title: "Task 1"

    Chart {
        id: chart
    }

    ColumnLayout {
        anchors.fill: parent
        spacing:10

        ChartView {
            id: view
            title: "Chart"
            width: root.width - 50
            height: 500
            antialiasing: true

            SplineSeries {
                id: series
                name: chart.name
                color: chart.color

                ValuesAxis {
                    id: axY
                }

                axisX: ValuesAxis {
                    min: 0
                    max: 5
                }

                axisY: axY
            }
        }

        ButtonGroup {
            id: group

            onClicked: {
                if (checkedButton == sinx) {
                    chart.calculate(Chart.SINX)
                    axY.min = -1
                    axY.max = 1
                }
                else if (checkedButton == linear) {
                    chart.calculate(Chart.LINEAR)
                    axY.min = 0
                    axY.max = 5
                }
                else if (checkedButton == abs_linear) {
                    chart.calculate(Chart.ABS_LINEAR)
                    axY.min = 0
                    axY.max = 2.5
                }
                else if (checkedButton == squared) {
                    chart.calculate(Chart.SQUARED)
                    axY.min = 0
                    axY.max = 25
                }
                else {
                    chart.calculate(Chart.LOG2)
                    axY.min = -4
                    axY.max = 3
                }

                series.clear()
                for (var i = 0; i < chart.x.length; ++i)
                    series.append(chart.x[i], chart.y[i])
            }
        }

        Text {
            id: settings
            text: "Type of charts:"
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 15
        }

        Row {
            id: row1
            Layout.alignment: Qt.AlignHCenter
            spacing: 100

            RadioButton {
                ButtonGroup.group: group
                id: sinx

                Text {
                    anchors.left: parent.right
                    text: "y = sin(x)"
                    color: "black"
                }
            }

            RadioButton {
                id: linear
                ButtonGroup.group: group

                Text {
                    anchors.left: parent.right
                    text: "y = x"
                    color: "black"
                }
            }

            RadioButton {
                id: abs_linear
                ButtonGroup.group: group

                Text {
                    anchors.left: parent.right
                    text: "y = |x - 2.5|"
                    color: "black"
                }
            }
        }

        Row {
            id: row2
            Layout.alignment: Qt.AlignHCenter
            spacing: 100

            RadioButton {
                id: squared
                ButtonGroup.group: group

                Text {
                    anchors.left: parent.right
                    text: "y = x ^ 2"
                    color: "black"
                }
            }

            RadioButton {
                id: log2
                ButtonGroup.group: group

                Text {
                    anchors.left: parent.right
                    text: "y = log2(x)"
                    color: "black"
                }
            }
        }

        Row {
            id: row3
            Layout.bottomMargin: 10
            Layout.alignment: Qt.AlignHCenter
            spacing: 100

            TextField {
                id: name
                placeholderText: "Parameter name"
                width: 250
            }

            TextField {
                id: clr
                placeholderText: "Color"
                width: 100
            }

            Button {
                text: "Apply"

                onClicked: {
                    chart.name = name.text
                    chart.color = clr.text
                }
            }
        }
    }
}
