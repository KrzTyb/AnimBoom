/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls

Rectangle {
    anchors.fill: parent
    color: "#2f2f2f"

    Image {
        id: backgroundLogo
        anchors.centerIn: parent
        source: "../assets/logo/logo.png"
        fillMode: Image.PreserveAspectFit
        opacity: 0.2
    }

    Rectangle {
        id: toolbar
        x: 0
        y: 0
        width: parent.width
        height: 30
        color: "#232323"
        border.color: "#91000000"
        border.width: 1
    }
}
