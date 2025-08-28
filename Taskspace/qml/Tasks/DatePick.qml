import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ".."
Dialog {
    id: datePick
    width: 300
    height: 320
    modal: true
    focus: true
    dim: false

    property date selectedDate: new Date()
    signal datePicked(date chosenDate)
    property var chosenDate: null

    property int selectedYear: selectedDate.getFullYear()
    property int selectedMonth: selectedDate.getMonth()

    background: Rectangle {
        color: AppData.colorBackgroundSecondary
        radius: 10
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            spacing: 20
            Layout.alignment: Qt.AlignHCenter

            Button {
                text: "<"
                onClicked: {
                    if (selectedMonth === 0) {
                        selectedMonth = 11
                        selectedYear--
                    } else {
                        selectedMonth--
                    }
                }
            }

            Label {
                text: Qt.formatDateTime(new Date(selectedYear, selectedMonth, 1), "MMMM yyyy")
                font.bold: true
                font.pixelSize: 16
                color: "white"
            }

            Button {
                text: ">"
                onClicked: {
                    if (selectedMonth === 11) {
                        selectedMonth = 0
                        selectedYear++
                    } else {
                        selectedMonth++
                    }
                }
            }
        }

        DayOfWeekRow {
            Layout.fillWidth: true
            locale: Qt.locale("en_US") // Start week on Monday
        }

        MonthGrid {
            id: grid
            Layout.fillWidth: true
            month: selectedMonth
            year: selectedYear
            locale: Qt.locale("en_US")

            delegate: Rectangle {
                required property var model
                width: parent.width / 7
                height: width
                radius: 4
                color: selectedDate.getTime() === model.date.getTime() ? "orange" : "transparent"
                border.color: "#888"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: model.day
                    font.pixelSize: 14
                    color: "white"
                    opacity: model.month === grid.month ? 1 : 0.3
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        datePick.selectedDate = model.date
                        datePick.chosenDate = model.date
                        timer.start()

                    }
                }
            }
        }
        Timer
        {
            id: timer
            interval: 2000
            repeat: false
            running: false
            onTriggered: {
                datePick.close()
            }
        }
    }
}
