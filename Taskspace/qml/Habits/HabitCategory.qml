import QtQuick
import QtQuick.Layouts
import ".."

GridLayout {
    id: gridLayout
    rows: 10
    columns: 2
    property int selectedIndex: -1
    Repeater {
        model: 20
        delegate: Rectangle {
            implicitWidth:  parent.width / 2.5
            implicitHeight: parent.height / 9.5
            color: (mouseArea.containsMouse || index === selectedIndex) ? "#586c8a": AppData.colorBackgroundPrimary
            radius: 15

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    if (index !== selectedIndex) {
                        selectedIndex = index;
                        AppData.selectedHabitCategory[0] = AppData.listHabitCategories[index];
                        AppData.selectedHabitCategory[1] = AppData.imageHabitCategories[index];
                    } else {
                        selectedIndex = -1;
                    }
                }
            }

            Text {
                text: AppData.listHabitCategories[index]
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.family: AppData.fontRobotoMono
                anchors
                {
                    leftMargin: 10
                    left: parent.left
                    verticalCenter: parent.verticalCenter

                }
                font.pixelSize: 22
                color: "white"
            }

            Image {
                source: AppData.imageHabitCategories[index]
                width: 35
                height: 35
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                anchors
                {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 15

                }
            }
        }
    }
}

