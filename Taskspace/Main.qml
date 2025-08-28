import QtQuick
import "./qml" as QML
import QtQuick.Controls
import QtQuick.Controls.Material
import QtWebEngine
ApplicationWindow  {
    width: 1600
    height: 900
    visible: true
    title: qsTr("Taskscape")
    color: QML.AppData.colorBackgroundPrimary
    minimumHeight: 720
    minimumWidth: 1280
    Material.accent: Material.Cyan
    Material.theme: Material.Dark

    QML.SideMenu{
        anchors.fill: parent

        visible: true
        anchors{
            top: parent.top
            left: parent.left
        }
    }


    FontLoader
    {
        id: fontGuerrilla
        source: "font/ProtestGuerrilla-Regular.ttf"
    }
    FontLoader
    {
        id: fontPoorStory
        source: "font/PoorStory-Regular.ttf"
    }
    FontLoader
    {
        id: fontRobotoMono
        source: "font/RobotoMono-Regular.ttf"
    }
}
