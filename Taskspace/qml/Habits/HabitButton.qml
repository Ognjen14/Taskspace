
import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    property alias source: image.source
    property alias colorOverlay: colorOverlay.color
    property var onClickedAction
    signal clickedButton()
    width: 35
    height: 35
    color: "transparent"

    Image {
        id: image
        anchors.fill: parent
    }

    ColorOverlay {
        id: colorOverlay
        anchors.fill: image
        source: image
        color: "transparent"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onPressed: {
            colorOverlay.color = Qt.lighter(colorOverlay.color, 0.5);
        }

        onReleased: {
            colorOverlay.color = Qt.darker(colorOverlay.color, 0.5);
            clickedButton()
        }
    }
}
