import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import ".."
Item {
    id: habitDialog
    visible: true
    width: parent.width
    height: parent.height
    signal habitAdded()

    function openDialog()
    {
        dialog.open()
        stackView.push(categoryPage)
    }

    Dialog {
        id: dialog
        width: parent.width
        height: parent.height
        modal: true
        background: Rectangle {
            color: AppData.colorBackgroundPrimary
            border.width: 0
            radius: 15
        }
        dim: false


        property int currentPage: 1

        StackView {
            id: stackView
            anchors.fill: parent
            Component {
                id: categoryPage
                Rectangle {
                    width: stackView.width
                    height: stackView.height
                    color: AppData.colorBackgroundSecondary
                    radius: 15

                    Text {
                        text: "Select a categoty for your habit"
                        anchors
                        {
                            top: parent.top
                            topMargin: 5
                            horizontalCenter: parent.horizontalCenter
                        }
                        font.family: AppData.fontRobotoMono
                        font.pixelSize: 22
                        color: "white"
                    }
                    HabitCategory
                    {
                        width: parent.width
                        height: parent.height - 200
                        anchors.top : parent.top
                        anchors.topMargin: 50
                        anchors.left: parent.left
                        anchors.leftMargin: 50
                    }

                    HabitButton
                    {
                        id: cancelButton
                        source: "../../icons/close.png"
                        colorOverlay: AppData.textColorMain
                        onClickedButton:
                        {
                            dialog.close()
                            stackView.clear()
                        }
                        anchors
                        {
                            bottom: parent.bottom
                            bottomMargin: 15
                            left: parent.left
                            leftMargin: 30
                        }
                    }
                    HabitButton
                    {
                        id: nextButton
                        source: "../../icons/arrow_next.png"
                        colorOverlay: AppData.textColorMain
                        onClickedButton:
                        {
                            dialog.currentPage = 2
                            stackView.push(habitPage)
                        }
                        anchors
                        {
                            bottom: parent.bottom
                            bottomMargin: 15
                            right: parent.right
                            rightMargin: 30
                        }
                    }
                }
            }
        }
        Component {
            id: habitPage
            Rectangle {
                width: stackView.width
                height: stackView.height
                color: AppData.colorBackgroundSecondary
                radius: 15
                ColumnLayout
                {
                    spacing: 30
                    anchors {
                        top: parent.top
                        topMargin: 10
                        horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        id: textHabit
                        text: qsTr("Define Habit")

                        font.family: AppData.fontRobotoMono
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    TextField {
                        id: textFuildHabitName
                        Layout.preferredWidth: parent.width - 200
                        Layout.preferredHeight: 55
                        font.family: AppData.fontRobotoMono
                        font.pixelSize: 25
                        placeholderText: "Enter new habit"
                        placeholderTextColor: "white"
                        color: "white"
                    }
                    Text
                    {
                        id: discriptionText
                        text: "Habit Description: e.g.. Morning Meditation: Spend 10 minutes meditating to start your day calmly."
                        font.family: AppData.fontRobotoMono
                        font.pixelSize: 20
                        font.bold: true
                        color:"white"
                        Layout.alignment: Qt.AlignHCenter

                    }
                    TextField {
                        id: textFuildHabitDiscription
                        Layout.preferredWidth: parent.width - 200
                        Layout.preferredHeight: 55
                        font.family: AppData.fontRobotoMono
                        font.pixelSize: 22
                        placeholderText: "Enter Habit Discription[optional]"
                        placeholderTextColor: "white"
                        color: "white"
                    }
                }

                HabitButton {
                    id: acceptButton
                    source: "../../icons/accept.png"
                    colorOverlay: "white"
                    onClickedButton: {
                        const name = textFuildHabitName.text.trim()
                        const description = textFuildHabitDiscription.text.trim()

                        if (name !== "") {
                            stackView.clear()
                            dialog.close()

                            AppData.selectedHabitName = name
                            AppData.selectedHabitDescription = description

                            const newHabit = {
                                name: name,
                                description: description,
                                category: AppData.selectedHabitCategory[0],
                                categoryImage: AppData.selectedHabitCategory[1]
                            }

                            AppData.listHabits.push(newHabit)
                            habitAdded()
                        } else {
                            // handle empty input
                        }
                    }


                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 15
                        right: parent.right
                        rightMargin: 30
                    }
                }
                HabitButton {
                    id: backButton
                    source: "../../icons/arrow_back.png"
                    colorOverlay: "white"
                    onClickedButton: {
                        dialog.currentPage = 1
                        stackView.pop()
                    }
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 15
                        left: parent.left
                        leftMargin: 30
                    }
                }
            }
        }
    }
}

