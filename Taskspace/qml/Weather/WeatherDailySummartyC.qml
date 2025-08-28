import QtQuick
import QtQuick.Layouts
import ".."
Item {
    id: root
    property alias dayTextS:  dayText.text
    property alias conditionTextS:  conditionText.text
    property alias temperatureTextS: temperatureText.text
    property alias imageSource:  image.source
    RowLayout{
        spacing: 5
        width: parent.width
        height: parent.height
        Text{
            id: dayText
            color: "gray"
            font.family: AppData.fontRobotoMono
            font.pixelSize: 18
        }
        Image{
            id: image
            Layout.preferredHeight: parent.height / 2
            Layout.preferredWidth:  parent.height / 2
            fillMode: Image.PreserveAspectFit
        }
        Text{
            id: conditionText
            Layout.preferredWidth: parent.width / 3 - 10
            Layout.preferredHeight: parent.height
            verticalAlignment: Qt.AlignVCenter
            color: "gray"
            wrapMode: Text.WordWrap
            font.family: AppData.fontRobotoMono
            font.pixelSize: 15
        }
        Text{
            Layout.preferredWidth: parent.width / 3
            id: temperatureText
            color: "white"
            font.family: AppData.fontRobotoMono
            font.pixelSize: 18
        }
    }
}
