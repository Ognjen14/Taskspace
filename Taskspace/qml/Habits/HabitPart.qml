import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."
import Storage 1.0
import QtQuick.Controls.Material
Rectangle {
    width: 1280 / 2
    height: 720 / 5
    radius: 20
    color: AppData.colorBackgroundSecondary
    property string todayIso: Qt.formatDate(new Date(), "yyyy-MM-dd")
    property alias habitName: habitNameText.text
    property alias categotyImageSource: categoryImage.source
    property alias categotyText : categoryText.text
    property alias descriptionTextText: descriptionText.text
    property alias steakText: steakText.text
    property int habitID: -1
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton

        onPressed: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                menu.popup(mouse.screenX, mouse.screenY);
            }
        }
    }

    Menu {
        id: menu

        MenuItem {
            id: menuItemEdit
            contentItem: Text {
                text: qsTr("Edit");
                color:  menuItemEdit.highlighted? "#f58d25" : "#ffffff"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            onTriggered: {
                console.log("Edit clicked");
            }
        }
        MenuItem {
            id: menuItemDelete
            contentItem: Text {
                text: qsTr("Delete");
                color:  menuItemDelete.highlighted? "#f58d25" : "#ffffff"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            onTriggered: {
                deleteHabit(habitID);
            }

        }
        leftPadding: 2
        rightPadding: 2

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            color: AppData.colorBackgroundSecondary
            border.color: AppData.textColorMain
            radius: 15
        }
    }

    Text {
        id: habitNameText
        font.bold: true
        font.pixelSize: 21
        font.family: AppData.fontRobotoMono
        color: "white"
        anchors.top: parent.top
        anchors.topMargin: 7
        anchors.left: parent.left
        anchors.leftMargin: 5
    }

    Row {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        spacing: 15

        Text {
            id: categoryText
            font.family: AppData.fontRobotoMono
            font.bold: true
            font.pixelSize: 18
            color: "white"
        }

        Image {
            id: categoryImage
            width: 35
            height: 35
        }
    }

    Text {
        id: descriptionText
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: AppData.fontRobotoMono
        font.bold: true
        font.pixelSize: 18
        color: "white"
    }
    Row{
        spacing: 10
        anchors{
            bottom: parent.bottom
            bottomMargin: 2
            left: parent.left
            leftMargin: 15
        }
        Image{
            width: 20
            height: 20
            source: "../../icons/chain.png"
        }

        Text {
            id: steakText
            font.family: AppData.fontRobotoMono
            font.bold: true
            font.pixelSize: 18
            color: "white"
        }

    }

    Rectangle {
        width: 400
        height: 100
        color: "transparent"
        anchors.centerIn: parent

        ListView {
            id: listView
            orientation: ListView.Horizontal
            width: parent.width
            height: parent.height
            model: habitCalendarListModel
            interactive: false
            spacing: 5

            delegate: Rectangle {
                width: listView.width / 8
                height: listView.height
                color: "transparent"
                enabled: model.isoDate === todayIso
                Text {
                    id: dayText
                    text: model.dayOfWeek
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pixelSize: 16
                    font.family: AppData.fontRobotoMono
                    color: "white"
                }
                Rectangle {
                    id: habitRect
                    anchors.top: dayText.bottom
                    anchors.topMargin: 5
                    width: 45
                    height: 45
                    radius: 15
                    color: {
                        const key = model.isoDate;
                        const history = AppData.habitHistory[habitID];

                        if (history && history[key]) {
                            const status = history[key].status;
                            switch (status) {
                                case 1: return "green";
                                case 2: return "red";
                                default: return "#3b505e";
                            }
                        }
                        return "#3b505e";
                    }
                    Text {
                        id: dateText
                        anchors.centerIn: parent
                        text: model.date
                        font.bold: true
                        font.pixelSize: 16
                        font.family: AppData.fontRobotoMono
                        color: "white"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (!AppData.habitHistory[habitID])
                                AppData.habitHistory[habitID] = {};

                            const key = model.isoDate;
                            let status = 0;

                            if (AppData.habitHistory[habitID][key]) {
                                status = (AppData.habitHistory[habitID][key].status + 1) % 3;
                            } else {
                                status = 1;
                            }

                            AppData.habitHistory[habitID][key] = { status: status };

                            switch (status) {
                                case 1: habitRect.color = "green"; break;
                                case 2: habitRect.color = "red"; break;
                                default: habitRect.color = "#3b505e"; break;
                            }
                            steakText.text = countConsecutiveGreenDays(habitID);
                        }
                    }
                }
            }
        }

        ListModel {
            id: habitCalendarListModel
            Component.onCompleted: updateDays()
            function updateDays() {
                var currentDate = new Date();
                var dayLabels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                clear();
                for (var i = 6; i >= 0; i--) {
                    var prevDay = new Date(currentDate);
                    prevDay.setDate(currentDate.getDate() - i);

                    var dayLabel = dayLabels[prevDay.getDay()];
                    var dayDate = prevDay.getDate();
                    var isoDate = Qt.formatDate(prevDay, "yyyy-MM-dd");
                    append({
                        "dayOfWeek": dayLabel,
                        "date": dayDate,
                        "isoDate": isoDate
                    });
                }
            }
        }

        Timer {
            id: updateTimer
            interval: calculateTimeUntilMidnight()
            running: true
            repeat: true
            onTriggered: {
                habitCalendarListModel.updateDays();
                updateTimer.interval = calculateTimeUntilMidnight();
            }
        }
    }
    Rectangle {
        height: 1
        width: parent.width
        color: "gray"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
    }

    JsonStorage{
        id: local
    }

    function calculateTimeUntilMidnight() {
        var now = new Date();
        var midnight = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 0, 0);
        return midnight - now;
    }

    function countDoneDays() {
        const history = AppData.habitHistory[habitID];
        if (!history) return 0;
        let count = 0;
        for (let date in history) {
            if (history[date] === 1)
                count++;
        }
        return count;
    }
}
