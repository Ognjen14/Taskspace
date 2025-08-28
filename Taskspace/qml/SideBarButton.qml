import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
Rectangle {
    width: 100
    height: 80
    property alias label: textLabel.text
    property alias icon: iconImage.source
    property string highlightColor: "gray"
    signal sideClicked()
    color: "transparent"
    MouseArea
    {
        anchors.fill: parent
        onReleased: {
            sideClicked()
        }
    }
    ColumnLayout{
        id: iconLabelRow
        width: parent.width
        height: parent.height
        Image{
            id: iconImage
            Layout.preferredHeight:  35
            Layout.preferredWidth: 35
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignHCenter
            ColorOverlay{
                anchors.fill: parent
                source: parent
                color: highlightColor
            }
        }

        Label{
            id: textLabel
            font.pixelSize: 16
            color: highlightColor
            font.family: AppData.fontRobotoMono
            Layout.alignment: Qt.AlignHCenter
        }

    }
    Image{
        id: rightIndicatior
        height: 10
        width: 10
        anchors{
            right: parent.right
            rightMargin: 10
        }
        ColorOverlay{
            anchors.fill: parent
            source: parent
            color: highlightColor
        }
        anchors.verticalCenter: parent.verticalCenter

        source: "../icons/right_side.png"
    }

}
