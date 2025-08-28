import QtQuick
import QtCharts 2.15
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material
import ".."
ChartView {
    id: forecastChart
    width: parent.width
    height: parent.height
    antialiasing: true
    backgroundColor: "transparent"
    legend.visible: false

    ValueAxis {
        id: axisYValue
        min: 0
        max: 50
        titleText: "Temperature (°C)"
        titleVisible: false
        titleFont.pixelSize: 30
        labelsColor: "white"
        gridVisible: false
        lineVisible: false
    }
    Text {
        text: "Temperature (°C)"
        color: "white"
        font.pixelSize: 18
        font.bold: true
        anchors {
            verticalCenter: parent.verticalCenter
            left: forecastChart.left
            leftMargin: -55
        }
        rotation: -90
    }


    DateTimeAxis {
        id: axisXValue
        format: "HH:mm"
        titleText: "Time"
        titleVisible: false
        color: "white"
        tickCount: 6
        labelsColor: "white"
        gridVisible: false
        lineVisible: false
    }

    Text {
        text: "Time"
        color: "white"
        font.pixelSize: 18
        font.bold: true
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 5
        }
    }

    property var listX: []
    property var listY: []

    SplineSeries {
        id: tempLine
        axisX: axisXValue
        axisY: axisYValue
        color: "#00bfff"
        width: 5

    }

    function updateChart() {
        tempLine.clear()
        const now = new Date();
        let baseDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        let lastHour = -1;

        for (let i = 0; i < listX.length; i++) {
            const parts = listX[i].split(":");
            let hour = parseInt(parts[0]);
            let minute = parseInt(parts[1]);

            if (lastHour !== -1 && hour < lastHour)
                baseDate.setDate(baseDate.getDate() + 1);
            lastHour = hour;

            const pointDate = new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate(), hour, minute);
            const ms = pointDate.getTime();

            tempLine.append(ms, listY[i]);

            if (i === 0) axisXValue.min = pointDate;
            if (i === listX.length - 1) axisXValue.max = pointDate;

            let minVal = Math.min.apply(null, listY);
            let maxVal = Math.max.apply(null, listY);

            axisYValue.max = maxVal + 2
            axisYValue.min = minVal - 10

        }
    }
}

