pragma Singleton
import QtQuick
import QtQuick.Controls.Material

QtObject{

               property string textColor: "white"
               readonly property string fontGorrilla: "Protest Guerrilla"
               readonly property string fontPoorStory: "Poor Story"
               readonly property string fontRobotoMono: "Roboto Mono"
               property int textSizeTitle: 25
               property int textSizeRegular: 15

               property string textColorMain: colorAccentBlue


               property var taskList: []

               property string colorBackgroundPrimary: "#040e1a"           // Main dark background
               property string colorBackgroundSecondary: "#1d2736"         // Card/container background
               property string colorBackgroundPanel: "#1d2736"             // Sidebar or overlay panels

               property string colorTextPrimary: "#FFFFFF"                 // Main white text
               property string colorTextSecondary: "#A0AEC0"               // Subtle labels
               property string colorTextSectionTitle: "#718096"            // Section headers

               property string colorAccentBlue: "#FFFFFF"                  // Buttons, highlights
               property var habitHistory: ({})


               property var listHabitCategories: [
                              "Quit a bad habit",
                              "Meditation",
                              "Sports",
                              "Social",
                              "Health",
                              "Reading",
                              "Studying",
                              "Nutrition",
                              "Self-Care",
                              "Exercise",
                              "Creativity",
                              "Organization",
                              "Gratitude",
                              "Time Management",
                              "Financial Planning",
                              "Personal Growth",
                              "Environmental Consciousness",
                              "Digital Detox",
                              "Cooking",
                              "Volunteering"
               ]


               property var imageHabitCategories: [
                              "../../icons/quitbadhabit.png",
                              "../../icons/mediation.png",
                              "../../icons/sports.png",
                              "../../icons/social.png",
                              "../../icons/health.png",
                              "../../icons/reading.png",
                              "../../icons/studying.png",
                              "../../icons/nutrition.png",
                              "../../icons/selfcare.png",
                              "../../icons/exercise.png",
                              "../../icons/creativity.png",
                              "../../icons/organization.png",
                              "../../icons/exercise.png",
                              "../../icons/timemanagement.png",
                              "../../icons/financialplanning.png",
                              "../../icons/exercise.png",
                              "../../icons/exercise.png",
                              "../../icons/detoxdigital.png",
                              "../../icons/cooking.png",
                              "../../icons/volotrring.png"

               ]

               property var habitColorSwitch: []
               property var habitDateDone: []
               property var selectedHabitCategory: []
               property string selectedHabitName
               property string selectedHabitDescription
               property var selectedDaysHabit: []
               property int habitCount: 0
               property var listHabits: []
               property var listHabitsDone: ["0","0","0","0","0","0","0"]


               property var weatherIconsNight : {
                              '1000': '../../icons/weatherImages/weatherIcons/night/113.png',
                              '1003': '../../icons/weatherImages/weatherIcons/night/116.png',
                              '1006': '../../icons/weatherImages/weatherIcons/night/119.png',
                              '1009': '../../icons/weatherImages/weatherIcons/night/122.png',
                              '1030': '../../icons/weatherImages/weatherIcons/night/143.png',
                              '1063': '../../icons/weatherImages/weatherIcons/night/176.png',
                              '1069': '../../icons/weatherImages/weatherIcons/night/179.png',
                              '1072': '../../icons/weatherImages/weatherIcons/night/185.png',
                              '1087': '../../icons/weatherImages/weatherIcons/night/200.png',
                              '1114': '../../icons/weatherImages/weatherIcons/night/227.png',
                              '1117': '../../icons/weatherImages/weatherIcons/night/230.png',
                              '1135': '../../icons/weatherImages/weatherIcons/night/248.png',
                              '1147': '../../icons/weatherImages/weatherIcons/night/260.png',
                              '1150': '../../icons/weatherImages/weatherIcons/night/263.png',
                              '1153': '../../icons/weatherImages/weatherIcons/night/266.png',
                              '1168': '../../icons/weatherImages/weatherIcons/night/281.png',
                              '1171': '../../icons/weatherImages/weatherIcons/night/284.png',
                              '1180': '../../icons/weatherImages/weatherIcons/night/293.png',
                              '1183': '../../icons/weatherImages/weatherIcons/night/296.png',
                              '1186': '../../icons/weatherImages/weatherIcons/night/299.png',
                              '1189': '../../icons/weatherImages/weatherIcons/night/302.png',
                              '1192': '../../icons/weatherImages/weatherIcons/night/305.png',
                              '1195': '../../icons/weatherImages/weatherIcons/night/308.png',
                              '1198': '../../icons/weatherImages/weatherIcons/night/311.png',
                              '1201': '../../icons/weatherImages/weatherIcons/night/314.png',
                              '1204': '../../icons/weatherImages/weatherIcons/night/317.png',
                              '1207': '../../icons/weatherImages/weatherIcons/night/320.png',
                              '1210': '../../icons/weatherImages/weatherIcons/night/323.png',
                              '1213': '../../icons/weatherImages/weatherIcons/night/326.png',
                              '1216': '../../icons/weatherImages/weatherIcons/night/329.png',
                              '1219': '../../icons/weatherImages/weatherIcons/night/332.png',
                              '1222': '../../icons/weatherImages/weatherIcons/night/335.png',
                              '1225': '../../icons/weatherImages/weatherIcons/night/338.png',
                              '1237': '../../icons/weatherImages/weatherIcons/night/350.png',
                              '1240': '../../icons/weatherImages/weatherIcons/night/353.png',
                              '1243': '../../icons/weatherImages/weatherIcons/night/356.png',
                              '1246': '../../icons/weatherImages/weatherIcons/night/359.png',
                              '1249': '../../icons/weatherImages/weatherIcons/night/362.png',
                              '1252': '../../icons/weatherImages/weatherIcons/night/365.png',
                              '1255': '../../icons/weatherImages/weatherIcons/night/368.png',
                              '1258': '../../icons/weatherImages/weatherIcons/night/371.png',
                              '1261': '../../icons/weatherImages/weatherIcons/night/374.png',
                              '1264': '../../icons/weatherImages/weatherIcons/night/377.png',
                              '1273': '../../icons/weatherImages/weatherIcons/night/386.png',
                              '1276': '../../icons/weatherImages/weatherIcons/night/389.png',
                              '1279': '../../icons/weatherImages/weatherIcons/night/392.png',
                              '1282': '../../icons/weatherImages/weatherIcons/night/395.png'
               };

               property var weatherIconsDay : {
                              '1000': '../../icons/weatherImages/weatherIcons/day/113.png',
                              '1003': '../../icons/weatherImages/weatherIcons/day/116.png',
                              '1006': '../../icons/weatherImages/weatherIcons/day/119.png',
                              '1009': '../../icons/weatherImages/weatherIcons/day/122.png',
                              '1030': '../../icons/weatherImages/weatherIcons/day/143.png',
                              '1063': '../../icons/weatherImages/weatherIcons/day/176.png',
                              '1069': '../../icons/weatherImages/weatherIcons/day/179.png',
                              '1072': '../../icons/weatherImages/weatherIcons/day/185.png',
                              '1087': '../../icons/weatherImages/weatherIcons/day/200.png',
                              '1114': '../../icons/weatherImages/weatherIcons/day/227.png',
                              '1117': '../../icons/weatherImages/weatherIcons/day/230.png',
                              '1135': '../../icons/weatherImages/weatherIcons/day/248.png',
                              '1147': '../../icons/weatherImages/weatherIcons/day/260.png',
                              '1150': '../../icons/weatherImages/weatherIcons/day/263.png',
                              '1153': '../../icons/weatherImages/weatherIcons/day/266.png',
                              '1168': '../../icons/weatherImages/weatherIcons/day/281.png',
                              '1171': '../../icons/weatherImages/weatherIcons/day/284.png',
                              '1180': '../../icons/weatherImages/weatherIcons/day/293.png',
                              '1183': '../../icons/weatherImages/weatherIcons/day/296.png',
                              '1186': '../../icons/weatherImages/weatherIcons/day/299.png',
                              '1189': '../../icons/weatherImages/weatherIcons/day/302.png',
                              '1192': '../../icons/weatherImages/weatherIcons/day/305.png',
                              '1195': '../../icons/weatherImages/weatherIcons/day/308.png',
                              '1198': '../../icons/weatherImages/weatherIcons/day/311.png',
                              '1201': '../../icons/weatherImages/weatherIcons/day/314.png',
                              '1204': '../../icons/weatherImages/weatherIcons/day/317.png',
                              '1207': '../../icons/weatherImages/weatherIcons/day/320.png',
                              '1210': '../../icons/weatherImages/weatherIcons/day/323.png',
                              '1213': '../../icons/weatherImages/weatherIcons/day/326.png',
                              '1216': '../../icons/weatherImages/weatherIcons/day/329.png',
                              '1219': '../../icons/weatherImages/weatherIcons/day/332.png',
                              '1222': '../../icons/weatherImages/weatherIcons/day/335.png',
                              '1225': '../../icons/weatherImages/weatherIcons/day/338.png',
                              '1237': '../../icons/weatherImages/weatherIcons/day/350.png',
                              '1240': '../../icons/weatherImages/weatherIcons/day/353.png',
                              '1243': '../../icons/weatherImages/weatherIcons/day/356.png',
                              '1246': '../../icons/weatherImages/weatherIcons/day/359.png',
                              '1249': '../../icons/weatherImages/weatherIcons/day/362.png',
                              '1252': '../../icons/weatherImages/weatherIcons/day/365.png',
                              '1255': '../../icons/weatherImages/weatherIcons/day/368.png',
                              '1258': '../../icons/weatherImages/weatherIcons/day/371.png',
                              '1261': '../../icons/weatherImages/weatherIcons/day/374.png',
                              '1264': '../../icons/weatherImages/weatherIcons/day/377.png',
                              '1273': '../../icons/weatherImages/weatherIcons/day/386.png',
                              '1276': '../../icons/weatherImages/weatherIcons/day/389.png',
                              '1279': '../../icons/weatherImages/weatherIcons/day/392.png',
                              '1282': '../../icons/weatherImages/weatherIcons/day/395.png'
               };

               property string cityText: "Beograd"
               property real temperatureC: 0
               property string weatherCondition: ""
               property int weatherConditionCode: 0
               property real windSpeedKph: 0
               property real humidity: 0
               property real cloudCover: 0
               property real pressureMb:0
               property bool isDay: false
               property var forecastData: []
               property var dailySummaryData: []
}
