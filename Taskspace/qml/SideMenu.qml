import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "./Tasks" as Tasks
import "./Habits" as Habits
import "./Weather" as Weather
import QtWebEngine
Item{
    id: controlCenter
    Row{
        anchors.fill: parent
        Rectangle{
            width: 170
            height: parent.height
            color: AppData.colorBackgroundPanel
            ColumnLayout{
                width: parent.width
                anchors{
                    top: parent.top
                    topMargin: 10
                    left: parent.left
                    leftMargin: 10
                }
                spacing: 30
                Label{
                    text: "Taskscape"
                    font.pixelSize: 22
                    color: "white"
                    font.bold: true
                    font.italic: true
                    font.family: AppData.fontRobotoMono
                }

                ColumnLayout{
                    spacing: 30
                    width: parent.width
                    SideBarButton{
                        id: btnHabits
                        icon: "../icons/habit.png"
                        label: "Habits"
                        width: parent.width - 12
                        onSideClicked: {
                            mainLoader.sourceComponent = habits
                            highlightButton(btnHabits);
                        }
                    }
                    SideBarButton{
                        id: btnTasks
                        icon: "../icons/tasks.png"
                        label: "Tasks"
                        width: parent.width - 12
                        onSideClicked: {
                            mainLoader.sourceComponent = tasks
                            highlightButton(btnTasks);
                        }
                    }
                    SideBarButton{
                        id: btnWeather
                        icon: "../icons/weather.png"
                        label: "Weather"
                        width: parent.width - 12
                        onSideClicked: {
                            mainLoader.sourceComponent = weather
                            highlightButton(btnWeather);
                        }
                    }
                    SideBarButton{
                        id: btnFinance
                        icon: "../icons/finance.png"
                        label: "Finance Tracker"
                        width: parent.width - 12
                        onSideClicked: {
                            highlightButton(btnFinance);
                        }
                    }
                }
            }
        }

        Loader{
            id: mainLoader
            width: parent.width - 170
            height: parent.height
            sourceComponent: habits
            onLoaded: {
                highlightButton(btnHabits)
            }
        }

    }
    function highlightButton(selectedButton) {
        const buttons = [btnHabits, btnTasks, btnWeather,btnFinance];
        for (let i = 0; i < buttons.length; i++) {
            buttons[i].highlightColor = (buttons[i] === selectedButton) ? "white" : "gray";
        }
    }


    Component{
        id: tasks
        Tasks.Tasks{}
    }
    Component{
        id: habits
        Habits.Habits{}
    }

    Component{
        id: weather
        Weather.Weather{}
    }
}
