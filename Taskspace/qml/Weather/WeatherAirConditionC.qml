import QtQuick
import QtQuick.Layouts
import ".."
import Qt5Compat.GraphicalEffects
Item {
    id: root
    property alias imageSource: conImage.source
    property alias textSource: conText.text
    property alias valueSoruce: valueText.text

    ColumnLayout
    {
        spacing: 5
        width: parent.width
        height: parent.height
        RowLayout
        {
            spacing: 15
            Image {
                id: conImage
                Layout.preferredHeight: root.height / 4
                Layout.preferredWidth: root.height / 4
                fillMode: Image.PreserveAspectFit
                ColorOverlay{
                    anchors.fill: parent
                    source: parent
                    color: AppData.textColorMain
                }
            }

            Text{
                id: conText
                font.pixelSize: 16
                font.bold: false
                font.family: AppData.fontRobotoMono
                color: "gray"
            }
        }
        Text{
            id: valueText
            font.pixelSize: root.height * 0.25
            font.bold: true
            font.family: AppData.fontRobotoMono
            color: "white"
        }
    }

}
