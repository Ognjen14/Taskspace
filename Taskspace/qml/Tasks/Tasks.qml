import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import ".."
import Storage 1.0
Item{
    JsonStorage{
        id: local
    }
    Rectangle{
        anchors.fill: parent
        color: "transparent"
        RowLayout{
            id: rowTitle
            height: 70
            width: parent.width
            spacing: 20
            anchors
            {
                top:parent.top
                topMargin: 20
                left: parent.left
                leftMargin: 30
            }
            Image{
                Layout.preferredHeight:  70
                Layout.preferredWidth:  70
                fillMode: Image.PreserveAspectFit
                source: "../../icons/tasks.png"

                ColorOverlay{
                    anchors.fill: parent
                    source: parent
                    color: AppData.textColorMain
                }
            }

            Label{
                Layout.preferredHeight:  100
                Layout.preferredWidth:  70
                Layout.leftMargin: -150
                text: "Tasks"
                color: AppData.textColorMain
                font.bold: true
                font.pixelSize: 30
                font.family: AppData.fontRobotoMono
                verticalAlignment: Qt.AlignVCenter
            }
            Label {
                id: dateTimeLabel
                Layout.preferredHeight:  70
                Layout.preferredWidth:  300
                font.pixelSize: 20
                color: "lightgray"
                text: Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss AP")
                font.family: AppData.fontRobotoMono
                verticalAlignment: Qt.AlignVCenter
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 30
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        dateTimeLabel.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss AP")
                    }
                }
            }
        }
        Flickable
        {
            width: parent.width
            height: parent.height - 225
            anchors{
                top: rowTitle.bottom
                topMargin: 50
                left: parent.left
                leftMargin: 30
            }
            /* List Model */
            ListModel
            {
                id: todoListModel
                function addTask(task, date) {
                    var newTask = {
                        "taskItem": task,
                        "favorite": false,
                        "completed": false,
                        "scheduledDate": date ? date.toLocaleDateString() : ""
                    }
                    todoListModel.append(newTask)
                }
            }
            ListView{
                id: listViewToDo
                width:  parent.width
                height: parent.height
                ScrollBar.vertical: ScrollBar
                {
                    policy: ScrollBar.AsNeeded
                    active: ScrollBar.AsNeeded
                }
                flickableDirection: Flickable.VerticalFlick
                clip:true
                spacing: 5
                boundsBehavior: Flickable.StopAtBounds
                model: todoListModel
                delegate: Rectangle{
                    width: listViewToDo.width - 50
                    height: 55
                    color: AppData.colorBackgroundSecondary
                    radius: 15
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton

                        onPressed: (mouse) => {
                            if (mouse.button === Qt.RightButton) {
                                menu.popup(mouse.screenX, mouse.screenY);
                            }
                        }
                    }
                    ColumnLayout
                    {
                        width: parent.width
                        height: parent.height
                        anchors.top: parent.top
                        spacing: -16
                        RowLayout
                        {
                            spacing: 15
                            Layout.preferredWidth: parent.width - 65
                            Layout.preferredHeight: 40
                            Layout.topMargin:  -10
                            CheckBox {
                                checked: model.completed

                                onClicked: {
                                    let item = todoListModel.get(index)
                                    let fav = item.favorite
                                    let comp = checked
                                    let date = item.scheduledDate
                                    let updatedItem = {
                                        "taskItem": item.taskItem,
                                        "favorite": fav,
                                        "completed": comp,
                                        "scheduledDate": date
                                    }
                                    todoListModel.remove(index);
                                    todoListModel.append(updatedItem);

                                    taskId.font.strikeout = checked
                                    taskId.color = checked ? "#858282" : "white"
                                }
                                hoverEnabled: true
                                ToolTip.visible: hovered
                                ToolTip.text: model.completed ? "Mark as uncompleted" : "Mark as completed"
                            }

                            Text
                            {
                                id: taskId
                                text: taskItem
                                color: "white"
                                font.pixelSize: 22
                                Layout.fillWidth: true
                                font.family: AppData.fontRobotoMono
                                font.strikeout: model.completed
                            }
                            RowLayout
                            {
                                visible: model.scheduledDate !== ""
                                spacing: 15
                                Image{
                                    source: "../../icons/calendar.png"
                                    Layout.preferredHeight:  20
                                    Layout.preferredWidth:  20
                                    ColorOverlay{
                                        anchors.fill: parent
                                        source: parent
                                        color: AppData.textColorMain
                                    }
                                }

                                Text{
                                    font.pixelSize: 14
                                    color: "lightgray"
                                    text: model.scheduledDate
                                }
                                Layout.leftMargin: 10
                            }
                            Image {
                                id: favoriteIcon
                                source: model.favorite ? "../../icons/star_full.png" : "../../icons/star_empty.png"
                                Layout.preferredHeight: 20
                                Layout.preferredWidth: 20

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: "lightblue"
                                }

                                ToolTip.visible: hovered
                                ToolTip.text: model.favorite ? "Remove from favorites" : "Mark as favorite"


                                property bool hovered: false

                                MouseArea {
                                    id: favMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true

                                    onClicked: {
                                        let item = todoListModel.get(index)
                                        let fav = !item.favorite
                                        let comp = item.completed
                                        let date = item.scheduledDate
                                        let updatedItem = { "taskItem": item.taskItem, "favorite": fav , "completed" : comp, "scheduledDate": date }

                                        todoListModel.remove(index)
                                        if (fav) {
                                            todoListModel.insert(0, updatedItem)
                                        } else {
                                            todoListModel.append(updatedItem)
                                        }
                                    }

                                    onEntered: favoriteIcon.hovered = true
                                    onExited: favoriteIcon.hovered = false
                                }
                            }

                            Image {
                                id: deleteIcon
                                source: "../../icons/bin.png"
                                Layout.preferredHeight: 20
                                Layout.preferredWidth: 20
                                Layout.rightMargin: 15

                                ToolTip.visible: hovered
                                ToolTip.text: "Remove a Task"

                                property bool hovered: false

                                ColorOverlay{
                                    anchors.fill: parent
                                    source: parent
                                    color: "#943126"
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        todoListModel.remove(index)
                                    }

                                    onEntered: deleteIcon.hovered = true
                                    onExited: deleteIcon.hovered = false
                                }
                            }
                        }
                    }
                }
            }
        }


        RowLayout
        {
            anchors{
                bottom: parent.bottom
                bottomMargin: 30
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width - 250
            height: 40
            spacing: 50
            TextField {
                id: todoInput
                placeholderText: qsTr("Add a Task:")
                placeholderTextColor: AppData.colorAccentBlue
                Layout.preferredWidth:  parent.width - 150
                color: "white"
                font.family: AppData.fontRobotoMono

                height: 40
                font.pixelSize: 22
                font.bold: true
                onAccepted: {
                    if (todoInput.text.trim() !== "") {
                        if(datePicker.chosenDate !== null){
                            todoListModel.addTask(todoInput.text.trim(), datePicker.chosenDate)
                            todoInput.text = "";
                            todoInput.focus = false;
                        }else{
                            todoListModel.addTask(todoInput.text.trim(), null)
                            todoInput.text = "";
                            todoInput.focus = false;
                        }
                        datePicker.chosenDate = null;
                    }
                }
            }
            Button {
                id: pickButton
                text: datePicker.chosenDate ?  datePicker.chosenDate.toLocaleDateString() : ""
                onClicked: datePicker.open()
                icon.source:"../../icons/calendar.png"
                icon.color: "black"
            }
        }
        DatePick {
            id: datePicker
            x: pickButton.x - datePicker.width + 300
            y: parent.height - 400
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
    Component.onDestruction: {
        AppData.taskList = []
        for (let i = 0; i < todoListModel.count; ++i) {
            let item = todoListModel.get(i)
            AppData.taskList.push({
                                      taskId: i,
                                      taskItem: item.taskItem,
                                      favorite: item.favorite || false,
                                      completed: item.completed,
                                      scheduledDate: item.scheduledDate
                                  })
        }
        local.writeData(AppData.taskList, "Taskspace/tastStorage.json")
    }

    Component.onCompleted: {
        var data = local.readData("Taskspace/tastStorage.json")
        console.log(JSON.stringify(data))
        AppData.taskList = data;
        for (let i = 0; i < AppData.taskList.length; ++i) {
            let task = AppData.taskList[i]

            if (task && typeof task.taskItem === "string") {
                todoListModel.append({
                                         taskItem: task.taskItem,
                                         favorite: task.favorite || false,
                                         completed: task.completed || false,
                                         scheduledDate: task.scheduledDate || ""
                                     })
            } else {
                console.warn("Invalid task at", i, task)
            }
        }
    }
}
