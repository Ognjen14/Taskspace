import QtQuick
import ".."

Item
{
    id: forecastC
    property alias imageSource: imageWeather.source
    property alias temperatureT: temperatureText.text
    property alias timeT: timeText.text
    Column
    {
        width: parent.width
        height: parent.height
        spacing: 7
        Text{
            id: timeText
            horizontalAlignment: Qt.AlignHCenter
            width: parent.width
            height: parent.height / 4
            font.pixelSize: 15
            color: "gray"
            font.family: AppData.fontRobotoMono
        }
        Image{
            id: imageWeather
            width: parent.height / 2 + 10
            height: parent.height / 2 + 10
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            id: temperatureText
            horizontalAlignment: Qt.AlignHCenter
            width: parent.width
            height: parent.height / 4
            font.pixelSize: 30
            color: "white"
            font.bold:  true
            font.family: AppData.fontRobotoMono
        }
    }
}

