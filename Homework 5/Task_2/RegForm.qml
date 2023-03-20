import QtQuick
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
    id: rect
    width: primaryFrame.width * 2 / 3
    height: primaryFrame.height
    anchors.centerIn: parent
    color: "white"
    property string resText

    ScrollView {
        anchors.fill: parent
        height: content
        contentWidth: availableWidth

        ColumnLayout {
            id: content
            spacing: 30

            Column {
                Layout.topMargin: 10
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 10
                Layout.preferredWidth: rect.width

                Label {
                    text: "Фамилия:"
                    color: "#000000"
                    font.pointSize: 13
                }

                TextField {
                    id: surname
                    placeholderText: "Фамилия"
                    height: 40
                    width: parent.width - 15
                }

                Label {
                    text: "Имя:"
                    color: "#000000"
                    font.pointSize: 13
                }

                TextField {
                    id: name
                    placeholderText: "Имя"
                    height: 40
                    width: parent.width - 15
                }

                Label {
                    text: "Отчество (необязательно):"
                    color: "#000000"
                    font.pointSize: 13
                }

                TextField {
                    id: patronymic
                    placeholderText: "Отчество"
                    height: 40
                    width: parent.width - 15
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width

                Label {
                    text: "Пол:"
                    color: "#000000"
                    font.pointSize: 13
                }

                ComboBox {
                    id: gender
                    model: ["Женский", "Мужской"]
                    width: parent.width - 15
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width

                Label {
                    text: "Возраст:"
                    color: "#000000"
                    font.pointSize: 13
                }

                Slider {
                    id: age
                    from: 18
                    to: 120
                    snapMode: Slider.SnapAlways
                    stepSize: 1
                    width: parent.width - ageText.width - 20

                    Text {
                        width: 30
                        id: ageText
                        text: age.value
                        color: "#000000"
                        font.pointSize: 13
                        anchors.left: parent.right
                        anchors.leftMargin: 5
                    }
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width

                Label {
                    text: "Образование:"
                    color: "#000000"
                    font.pointSize: 13
                }

                ComboBox {
                    id: education
                    model: ["Без образования", "Общее", "Профессиональное"]
                    width: parent.width - 15
                }

                ComboBox {
                    id: specEducation
                    visible: education.currentIndex > 0 ? true : false
                    model: education.currentIndex === 1 ?
                               ["Дошкольное", "Начальное общее", "Основное общее", "Среднее общее"] :
                               ["Среднее профессиональное", "Высшее - бакалавриат", "Высшее - специалист, магистр"]
                    width: parent.width - 15
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width

                Label {
                    text: "Хобби:"
                    color: "#000000"
                    font.pointSize: 13
                }

                TextArea {
                    id: hobbies
                    color: "#000000"
                    width: parent.width - 15
                    placeholderText: "Хобби, увлечения, любимые занятия..."
                    placeholderTextColor: "#808080"
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width

                Label {
                    text: "Город:"
                    color: "#000000"
                    font.pointSize: 13
                }

                TextField {
                    id: city
                    placeholderText: "Город, населённый пункт"
                    height: 40
                    width: parent.width - 15
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width

                Label {
                    text: "О себе:"
                    color: "#000000"
                    font.pointSize: 13
                }

                TextArea {
                    id: selfAbout
                    color: "#000000"
                    width: parent.width - 15
                    placeholderText: "Информация о себе..."
                    placeholderTextColor: "#808080"
                }
            }

            Column {
                spacing: 5
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                Layout.preferredWidth: rect.width
                Layout.topMargin: 50
                Layout.bottomMargin: 50

                Label {
                    text: "Параметры для поиска партнёра"
                    color: "#000000"
                    font.pointSize: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 15
                }

                Label {
                    text: "Возраст:"
                    color: "#000000"
                    font.pointSize: 13
                }

                RangeSlider {
                    id: mateAge
                    from: 18
                    to: 120
                    snapMode: RangeSlider.SnapAlways
                    stepSize: 1
                    width: parent.width - mateAgeText.width - 20

                    Text {
                        width: 70
                        id: mateAgeText
                        text: mateAge.first.value + " - " + mateAge.second.value
                        color: "#000000"
                        font.pointSize: 13
                        anchors.left: parent.right
                        anchors.leftMargin: 5
                    }
                }

                Label {
                    text: "Пол:"
                    color: "#000000"
                    font.pointSize: 13
                }

                ComboBox {
                    id: mateGender
                    model: ["Мужской", "Женский"]
                    width: parent.width - 15
                }

                Label {
                    text: "Образование:"
                    color: "#000000"
                    font.pointSize: 13
                }

                ComboBox {
                    id: mateEducation
                    model: ["Не имеет значения", "Без образования", "Общее", "Профессиональное"]
                    width: parent.width - 15
                }

                ComboBox {
                    id: specMateEducation
                    visible: mateEducation.currentIndex > 1 ? true : false
                    model: mateEducation.currentIndex === 2 ?
                               ["Дошкольное", "Начальное общее", "Основное общее", "Среднее общее"] :
                               ["Среднее профессиональное", "Высшее - бакалавриат", "Высшее - специалист, магистр"]
                    width: parent.width - 15
                }
            }

            Row {
                spacing: 5
                Layout.bottomMargin: 10
                Layout.leftMargin: 5
                Layout.rightMargin: 5

                Button {
                    id: back
                    width: rect.width / 2 - 10
                    height: 60

                    Text {
                        anchors.centerIn: parent
                        text: "Назад"
                        font.pointSize: 15
                    }

                    onClicked: {
                        loader.sourceComponent = loginForm
                    }
                }

                Button {
                    id: update
                    width: rect.width / 2 - 10
                    height: 60

                    Text {
                        anchors.centerIn: parent
                        text: "Обновить данные"
                        font.pointSize: 15
                    }

                    onClicked: {
                        primaryFrame.resText = "Фамилия: " + surname.text + "\n" +
                                "Имя: " + name.text + "\n" +
                                "Отчество: " + patronymic.text + "\n" +
                                "Пол: " + gender.currentText + "\n" +
                                "Возраст: " + age.value + "\n" +
                                "Образование: " + (education.currentIndex > 0 ? specEducation.currentText : education.currentText) + "\n" +
                                "Хобби: " + hobbies.text + "\n" +
                                "Город: " + city.text + "\n" +
                                "О себе: " + selfAbout.text + "\n" +
                                "\nПараметры для поиска партнёра\n" + "\n" +
                                "Возраст: от " + mateAge.first.value + " до " + mateAge.second.value + "\n" +
                                "Пол: " + mateGender.currentText + "\n" +
                                "Образование: " + (mateEducation.currentIndex > 1 ? specMateEducation.currentText : mateEducation.currentText)

                        loader.sourceComponent = resForm
                    }
                }
            }
        }
    }
}
