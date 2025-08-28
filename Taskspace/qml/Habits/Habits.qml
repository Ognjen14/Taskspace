import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."
import Qt5Compat.GraphicalEffects
import Storage 1.0
import QtQuick.Controls.Material
Item {
    id: habitItem
    JsonStorage{
        id: local
    }
    Rectangle
    {
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
                source: "../../icons/habit.png"

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
                text: "Habits"
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
        /* Habit List View Model */
        ListModel
        {
            id: habitListModel
            function addHabit(habitName, imageSource, textSource, textDescription)
            {   var newHabit = {
                    "habit" : habitName,
                    "imageSoruceCategory" : imageSource,
                    "categoryText" : textSource,
                    "descriptionText" : textDescription
                }
                append(newHabit)
            }
        }
        /* Habit List View (List that holds all created Habits) */
        Flickable {
            id: flickable
            width: parent.width
            height: parent.height - 200
            contentWidth: habitView.width
            contentHeight: habitView.height
            anchors{
                top: rowTitle.bottom
                topMargin: 50
                left: parent.left
                leftMargin: parent.width / 2 - (1600  / 4)
            }


            ListView {
                id: habitView
                model: habitListModel
                width: flickable.width
                height: flickable.height
                spacing: 20
                delegate: HabitPart {
                    habitID: index
                    habitName: model.habit
                    categotyImageSource: model.imageSoruceCategory
                    categotyText: model.categoryText
                    descriptionTextText: model.descriptionText
                    steakText: countConsecutiveGreenDays(index);
                }
            }
        }

        /* Habit Dialog for adding a new Habit to the List */
        HabitDialog{
            id: habitDialogg
            anchors.top: parent.top
            anchors.topMargin: -20
            width: parent.width
            height: parent.height
            onHabitAdded:
            {
                habitListModel.addHabit(AppData.selectedHabitName, AppData.selectedHabitCategory[1],
                                        AppData.selectedHabitCategory[0], AppData.selectedHabitDescription)
            }
        }

        /* Add new Habit button (button that opens HabitDialog) */
        HabitButton
        {
            id: addButton
            source: "../../icons/add.png"
            colorOverlay: AppData.textColorMain
            anchors{
                bottom: parent.bottom
                right: parent.right
                bottomMargin: 30
                rightMargin: 10
            }
            onClickedButton:
            {
                habitDialogg.openDialog()
            }
        }
    }

    Component.onCompleted: {
        var data =local.readData("Taskspace/habitStorage.json");
        AppData.listHabits = data;
        for (var i = 0; i < AppData.listHabits.length; ++i) {
            let habit = AppData.listHabits[i]
            habitListModel.addHabit(habit.name, habit.categoryImage, habit.category, habit.description)
        }
        AppData.habitHistory = local.readDataMap("Taskspace/habitHistoryStorage.json");
    }
    Component.onDestruction: {
        local.writeData(AppData.listHabits, "Taskspace/habitStorage.json")
        local.writeDataMap(AppData.habitHistory, "Taskspace/habitHistoryStorage.json")
    }


    /* Function that enalbe/disable HabitListView Scroll with scaling dependency */
    function checkScroll()
    {
        if(habitView.height < 500)
        {
            return habitListModel.count > 3 ? true : false

        }else{
            return habitListModel.count > 5 ? true : false

        }
    }
    function countConsecutiveGreenDays(habitID) {
        const history = AppData.habitHistory[habitID];
        if (!history) return 0;

        const keys = Object.keys(history).sort();
        let streak = 0;
        for (let i = keys.length - 1; i >= 0; i--) {
            const status = history[keys[i]]?.status;
            if (status === 1) {
                streak++;
            } else {
                break;
            }
        }
        return String(streak);
    }

    function deleteHabit(index) {
        if (index < 0 || index >= habitListModel.count) {
            console.warn("Invalid index for deletion:", index);
            return;
        }

        habitListModel.remove(index);
        delete AppData.habitHistory[index];
        reindexHabitHistory();

        if (AppData.listHabits && Array.isArray(AppData.listHabits)) {
            AppData.listHabits.splice(index, 1);
        }
    }

    function reindexHabitHistory() {
        const newHistory = {};
        const keys = Object.keys(AppData.habitHistory).sort((a, b) => Number(a) - Number(b));

        let newIndex = 0;
        for (let i = 0; i < keys.length; i++) {
            const k = keys[i];
            if (AppData.habitHistory[k] && Object.keys(AppData.habitHistory[k]).length > 0) {
                newHistory[newIndex] = AppData.habitHistory[k];
                newIndex++;
            }
        }
        AppData.habitHistory = newHistory;
    }


}
