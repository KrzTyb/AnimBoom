import QtQuick
import QtQuick.Window

Window {
    width: 1920
    height: 1080
    minimumHeight: 400
    minimumWidth: 400

    visible: true
    title: qsTr("AnimBoom Designer")

    MainView {
        anchors.fill: parent
    }
}
