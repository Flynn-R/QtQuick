import QtQuick
import QtQuick.Controls 2.5

Window {
    id: primaryFrame
    width: 640
    height: 480
    visible: true
    title: qsTr("Application")
    color: "#e5ecef"
    property string resText

    Component {
        id: loginForm

        LogIn {}
    }

    Component {
        id: regForm

        RegForm { id: reg }
    }

    Component {
        id: resForm

        Result { res: resText }
    }

    Loader {
        id: loader
        anchors.centerIn: parent
    }

    Component.onCompleted: {
        loader.sourceComponent = loginForm
    }
}
