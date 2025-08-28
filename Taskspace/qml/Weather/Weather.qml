import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Weather 1.0
import ".."
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import QtCharts 2.15
import Storage 1.0
Item {
    JsonStorage{
        id: local
    }
    property var supportedCities: [
        "Belgrade", "Novi Sad", "Niš", "Kragujevac", "Subotica",
        "Zrenjanin", "Pančevo", "Čačak", "Smederevo", "Leskovac",

        "Tokyo", "Delhi", "Shanghai", "São Paulo", "Mexico City",
        "Cairo", "Mumbai", "Beijing", "Dhaka", "Osaka",
        "New York", "Karachi", "Buenos Aires", "Chongqing", "Istanbul",
        "Kolkata", "Manila", "Lagos", "Rio de Janeiro", "Tianjin",
        "Kinshasa", "Guangzhou", "Los Angeles", "Moscow", "Shenzhen",
        "Lahore", "Bangalore", "Paris", "Bogotá", "Jakarta",
        "Chennai", "Lima", "Bangkok", "Seoul", "Nagoya",
        "London", "Chengdu", "Chicago", "Ho Chi Minh City", "Hyderabad",
        "Wuhan", "Hangzhou", "Ahmedabad", "Kuala Lumpur", "Hong Kong",
        "Madrid", "Baghdad", "Toronto", "Santiago", "Riyadh",
        "Barcelona", "Houston", "Singapore", "Pune", "Dallas",
        "Philadelphia", "Fukuoka", "Atlanta", "Melbourne", "Khartoum",
        "San Francisco", "Berlin", "Pyongyang", "Casablanca", "Alexandria",
        "Abidjan", "Jeddah", "Yokohama", "Boston", "Washington D.C.",
        "Sydney", "Ankara", "Brasília", "Montréal", "Phoenix",
        "Surat", "Rome", "Naples", "Medellín", "Curitiba",
        "Porto Alegre", "San Diego", "Kuwait City", "Vienna", "Munich",
        "Hanoi", "Tashkent", "Caracas", "Tel Aviv", "Doha",
        "Warsaw", "Bucharest", "Prague", "Oslo", "Helsinki"
    ]

    property var filteredCities: []
    Rectangle{
        anchors.fill: parent
        color: "transparent"


        TextField {
            id: cityEnter
            width: 400
            height: 40
            color: "white"
            placeholderText: "Search for a City"
            placeholderTextColor: AppData.colorAccentBlue
            font.pixelSize: 20
            font.bold: true
            font.italic: true
            anchors{
                top: parent.top
                topMargin: 15
                left: parent.left
                leftMargin: 15
            }

            onTextChanged: {
                filteredCities = supportedCities.filter(function(city) {
                    return city.toLowerCase().indexOf(cityEnter.text.toLowerCase()) !== -1;
                });
                cityList.visible = filteredCities.length > 0;
            }

            onEditingFinished: {
                if (supportedCities.includes(text)) {
                    weatherApiManager.fetchWeather(text);
                    AppData.cityText = text;
                    cityText.text = AppData.cityText;
                }
                cityList.visible = false;
            }
        }
        ListView {
            id: cityList
            width: cityEnter.width
            height: Math.min(filteredCities.length * 30, 200)
            model: filteredCities
            visible: false
            anchors.top: cityEnter.bottom
            anchors.left: cityEnter.left
            clip: true
            z: 999

            delegate: Rectangle {
                width: parent.width
                height: 30
                color: AppData.colorBackgroundSecondary
                radius: 15
                border.width: 1
                border.color: "gray"
                Text {
                    text: modelData
                    anchors.centerIn: parent
                    font.pixelSize: 19
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        cityEnter.text = modelData;
                        cityList.focus = false;
                        cityList.visible = false;
                        cityEnter.focus = false;
                        AppData.cityText = modelData;
                        cityText.text = AppData.cityText;
                    }
                }
            }
        }


        Label {
            id: dateTimeLabel
            font.pixelSize: 20
            color: AppData.textColorMain
            text: Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss AP")
            font.family: AppData.fontRobotoMono
            anchors{
                left: cityEnter.right
                leftMargin: 80
                top: parent.top
                topMargin: 15
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    dateTimeLabel.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss AP")
                }
            }
        }

        Rectangle{
            id: mainInfo
            width: parent.width - 500
            height: parent.height  / 3 - 100
            color: "transparent"
            anchors{
                top: cityEnter.bottom
                topMargin: 20
                left: parent.left
                leftMargin: 50
            }

            Row{
                anchors.fill: parent
                Column
                {
                    spacing: parent.height - 150
                    width: parent.width / 2
                    height: parent.height
                    Column
                    {
                        width: parent.width / 2
                        spacing: 5
                        Text{
                            id: cityText
                            text: AppData.cityText
                            font.pixelSize: 30
                            font.bold: true
                            color: "white"
                            font.family: AppData.fontRobotoMono
                        }
                        Text{
                            id: weatherConditionText
                            text: AppData.weatherCondition
                            font.pixelSize: 18
                            font.bold: true
                            color: "gray"
                            font.family: AppData.fontRobotoMono
                        }
                    }

                    Text{
                        text: AppData.temperatureC + "°"
                        font.pixelSize: 60
                        font.bold: true
                        color: "white"
                    }
                }
                Rectangle{
                    width: parent.width / 2
                    height: parent.height
                    color: "transparent"
                    Image{
                        width: parent.height
                        height: parent.height
                        anchors.centerIn: parent
                        source:  AppData.weatherConditionCode !== 0
                                 ? (AppData.isDay
                                    ? AppData.weatherIconsDay[AppData.weatherConditionCode]
                                    : AppData.weatherIconsNight[AppData.weatherConditionCode])
                                 : ""
                    }
                }
            }
        }

        Rectangle{
            id: airConditionRect
            width: parent.width - forecastRect.width - 50 - 30
            height: mainInfo.height
            color: AppData.colorBackgroundSecondary
            radius: 15
            anchors{
                right: parent.right
                rightMargin: 20
                top: cityEnter.bottom
                topMargin: 20
            }
            Text{
                id: airText
                anchors{
                    top:parent.top
                    topMargin: 15
                    left: parent.left
                    leftMargin: 15
                }
                text: qsTr("AIR CONDITION")
                color: "gray"
                font.family: AppData.fontRobotoMono
                font.pixelSize: 18
            }

            Grid{
                rows: 2
                columns: 2
                width: parent.width
                height: parent.height - 25
                anchors{
                    top: airText.bottom
                    topMargin: 5
                    left: parent.left
                    leftMargin: 15
                }

                WeatherAirConditionC
                {
                    width: parent.width / 2 - 5
                    height: parent.height / 2 - 10
                    imageSource: "../../icons/weatherImages/wind.png"
                    textSource: "Wind"
                    valueSoruce: AppData.windSpeedKph + " km/h"
                }
                WeatherAirConditionC
                {
                    width: parent.width / 2 - 5
                    height: parent.height / 2 - 10
                    imageSource: "../../icons/weatherImages/humidity.png"
                    textSource: "Humidity"
                    valueSoruce: AppData.humidity+ " g/m³"
                }

                WeatherAirConditionC
                {
                    width: parent.width / 2 - 5
                    height: parent.height / 2 - 10
                    imageSource: "../../icons/weatherImages/cloudcover.png"
                    textSource: "Cloud cover"
                    valueSoruce: AppData.cloudCover + " %"
                }

                WeatherAirConditionC
                {
                    width: parent.width / 2 - 5
                    height: parent.height / 2 - 10
                    imageSource: "../../icons/weatherImages/pressure.png"
                    textSource: "Pressure"
                    valueSoruce: AppData.pressureMb + " Mb"
                }
            }

        }
        Rectangle
        {
            width: airConditionRect.width
            height: forecastRect.height + chartRect.height + 15
            radius: 15
            color: AppData.colorBackgroundSecondary
            anchors{
                top: airConditionRect.bottom
                right: parent.right
                rightMargin: 20
                topMargin: 15
            }

            Text{
                id: dailyForecastText
                anchors{
                    top:parent.top
                    topMargin: 15
                    left: parent.left
                    leftMargin: 15
                }
                text: qsTr("3-DAYS FORECAST")
                color: "gray"
                font.family: AppData.fontRobotoMono
                font.pixelSize: 18
            }

            Column
            {
                width: parent.width
                height: parent.width - 25
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 15
                }
                WeatherDailySummartyC{
                    id: day1
                    width: parent.width - 20
                    height: parent.height / 3
                }
                Rectangle{
                    width: parent.width - 30
                    height: 1
                    color: "gray"
                }
                WeatherDailySummartyC{
                    id: day2
                    width: parent.width - 20
                    height: parent.height / 3
                }
                Rectangle{
                    width: parent.width - 30
                    height: 1
                    color: "gray"
                }
                WeatherDailySummartyC{
                    id: day3
                    width: parent.width - 20
                    height: parent.height / 3
                }

            }
        }

        Rectangle{
            id: forecastRect
            width: parent.width  - 500
            height: parent.height / 3 - 50
            color: AppData.colorBackgroundSecondary
            radius: 15
            anchors{
                top: mainInfo.bottom
                topMargin: 15
                left: parent.left
                leftMargin: 50
            }

            Text{
                anchors{
                    top:parent.top
                    topMargin: 15
                    left: parent.left
                    leftMargin: 15
                }
                text: qsTr("TODAY'S FORECAST")
                color: "gray"
                font.family: AppData.fontRobotoMono
                font.pixelSize: 18
            }
            Row{
                width: parent.width - 50
                height: parent.height - 100
                spacing: 15
                anchors{
                    verticalCenter: parent.verticalCenter
                }
                WeatherForecastC{
                    id: forecast1
                    height: parent.height
                    width: parent.width / 5 - 15
                }
                Rectangle{
                    width: 1
                    height: parent.height
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }

                    color: "gray"
                }
                WeatherForecastC{
                    id: forecast2
                    height: parent.height
                    width: parent.width / 5 - 15
                }
                Rectangle{
                    width: 1
                    height: parent.height
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    color: "gray"
                }
                WeatherForecastC{
                    id: forecast3
                    height: parent.height
                    width: parent.width / 5 - 15
                }
                Rectangle{
                    width: 1
                    height: parent.height
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    color: "gray"
                }
                WeatherForecastC{
                    id: forecast4
                    height: parent.height
                    width: parent.width / 5 - 15
                }
                Rectangle{
                    width: 1
                    height: parent.height
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    color: "gray"
                }
                WeatherForecastC{
                    id: forecast5
                    height: parent.height
                    width: parent.width / 5 - 15
                }
            }
        }

        Rectangle{
            id: chartRect
            width: parent.width  - 500
            height: parent.height / 3 - 50
            color: AppData.colorBackgroundSecondary
            radius: 15
            anchors{
                top: forecastRect.bottom
                topMargin: 15
                left: parent.left
                leftMargin: 50
            }
            WeatherChart{id: weatherC}
        }
    }

    function updateForecasts(forecastComponents, forecastData) {
        if(forecastData.length !== 0){

            for (let i = 0; i < forecastComponents.length; i++) {
                const forecast = forecastComponents[i];
                const data = forecastData[i];

                forecast.imageSource = data.isDay
                        ? AppData.weatherIconsDay[data.conditionCode]
                        : AppData.weatherIconsNight[data.conditionCode];
                forecast.timeT = data.time;
                forecast.temperatureT = data.temperature + "°";
            }
        }
    }
    function updateDailySummaries(summaryComponents, summaryData) {
        if(summaryData.length !== 0){
            const count = Math.min(summaryComponents.length, summaryData.length);
            for (let i = 0; i < count; i++) {
                const comp = summaryComponents[i];
                const data = summaryData[i];

                comp.dayTextS = data.date
                comp.conditionTextS = data.conditionText;
                comp.imageSource = AppData.weatherIconsDay[data.conditionCode];
                comp.temperatureTextS = data.maxTemp + "/" + data.minTemp + "°";
            }
        }


    }

    function formatDate_DDMMYYYY(dateStr) {
        const parts = dateStr.split("-");
        const year = parts[0];
        const month = parts[1];
        const day = parts[2];
        return `${day}/${month}/${year}`;
    }


    WeatherApi {
        id: weatherApiManager
        onWeatherUpdated: {
            AppData.temperatureC = temperatureC;
            AppData.weatherCondition = weatherCondition;
            AppData.weatherConditionCode = weatherConditionCode;
            AppData.windSpeedKph = windSpeedKph;
            AppData.humidity = humidity;
            AppData.cloudCover = cloudCover;
            AppData.pressureMb = pressureMb;
            AppData.isDay = isDay;
            for (let i = 0; i < forecast.length; i++) {
                const entry = forecast[i];
                AppData.forecastData[i] = entry;
            }
            weatherC.listX = AppData.forecastData.map(f => f.time)
            weatherC.listY = AppData.forecastData.map(f => f.temperature)
            weatherC.updateChart()
            updateForecasts(
                        [forecast1, forecast2, forecast3, forecast4, forecast5],
                        AppData.forecastData
                        );

            AppData.dailySummaryData = [];
            for (let j = 0; j < dailySummary.length; j++) {
                const day = dailySummary[j];
                AppData.dailySummaryData.push({
                                                  date: day.date,
                                                  maxTemp: day.maxTemp,
                                                  minTemp: day.minTemp,
                                                  conditionText: day.conditionText,
                                                  conditionCode: day.conditionCode
                                              });
            }
            updateDailySummaries([day1, day2, day3], AppData.dailySummaryData);
            if(AppData.forecastData.length !== 0){
                weatherC.listX = AppData.forecastData.map(f => f.time)
                weatherC.listY = AppData.forecastData.map(f => f.temperature)
                weatherC.updateChart()
                updateForecasts(
                            [forecast1, forecast2, forecast3, forecast4, forecast5],
                            AppData.forecastData
                            );
            }
            if(AppData.dailySummaryData.length === 0){
                timerRead.start();
            }
        }
        onErrorOccurred: console.error("Error:", error)
    }

    Component.onCompleted: {
         var data = local.readData("Taskspace/weatherStorage.json");
        AppData.cityText = data[0].weatherCity;
        weatherApiManager.fetchWeather(AppData.cityText)
    }
    Component.onDestruction: {
        var data = [{ weatherCity: AppData.cityText }]
        local.writeData(data, "Taskspace/weatherStorage.json")
    }

}
