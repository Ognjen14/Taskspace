#include "weatherapi.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QUrlQuery>
#include <QDebug>

WeatherApi::WeatherApi(QObject *parent)
    : QObject{parent}
{
    connect(&m_manager, &QNetworkAccessManager::finished,
            this, &WeatherApi::onNetworkReply);
}

void WeatherApi::fetchWeather(const QString &cityName)
{
    QUrl url("http://api.weatherapi.com/v1/forecast.json");
    QUrlQuery query;
    query.addQueryItem("key", m_apiKey);
    query.addQueryItem("q", cityName);
    query.addQueryItem("days", "3");
    query.addQueryItem("aqi", "no");
    query.addQueryItem("alerts", "no");
    url.setQuery(query);

    QNetworkRequest request(url);
    m_manager.get(request);
}
QString getDayNameFromISO(const QString &isoDate)
{
    QDate date = QDate::fromString(isoDate, "yyyy-MM-dd");
    return date.toString("ddd");
}
void WeatherApi::onNetworkReply(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError) {
        emit errorOccurred(reply->errorString());
        reply->deleteLater();
        return;
    }

    QByteArray data = reply->readAll();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    QJsonObject obj = doc.object();

    // === CURRENT WEATHER ===
    QJsonObject current = obj["current"].toObject();
    QJsonObject condition = current["condition"].toObject();

    m_date = current["last_updated"].toString();
    m_temperatureC = current["temp_c"].toDouble();
    m_weatherCondition = condition["text"].toString();
    m_weatherConditionCode = condition["code"].toInt();
    m_windSpeedKph = current["wind_kph"].toDouble();
    m_cloudCover = current["cloud"].toInt();
    m_pressureMb = current["pressure_mb"].toDouble();
    m_humidity = current["humidity"].toInt();
    m_isDay = current["is_day"].toInt() == 1;


    // === FORECAST ===
    m_forecast.clear();

    QString currentDateTimeStr = obj["location"].toObject()["localtime"].toString(); // e.g. "2025-07-24 21:40"
    QDateTime currentDateTime = QDateTime::fromString(currentDateTimeStr, "yyyy-MM-dd HH:mm");
    currentDateTime.setTimeSpec(Qt::LocalTime);

    // Round to next full 3-hour step
    int hour = currentDateTime.time().hour();
    int nextStep = ((hour / 3) + 1) * 3;
    if (nextStep >= 24) {
        currentDateTime = currentDateTime.addDays(1);
        currentDateTime.setTime(QTime(0, 0));
        nextStep = 0;
    }
    currentDateTime.setTime(QTime(nextStep, 0));

    int collected = 0;
    const int maxForecastEntries = 5;

    QJsonArray forecastDays = obj["forecast"].toObject()["forecastday"].toArray();

    for (const QJsonValue &day : std::as_const(forecastDays)) {
        QJsonArray hours = day.toObject()["hour"].toArray();

        for (const QJsonValue &val : std::as_const(hours)) {
            QJsonObject hourObj = val.toObject();
            QString timeStr = hourObj["time"].toString();
            QDateTime forecastTime = QDateTime::fromString(timeStr, "yyyy-MM-dd HH:mm");
            forecastTime.setTimeSpec(Qt::LocalTime);

            if (forecastTime < currentDateTime)
                continue;

            int diffHours = currentDateTime.secsTo(forecastTime) / 3600;
            if (diffHours % 3 != 0)
                continue;

            QVariantMap entry;
            entry["isDay"] = hourObj["is_day"].toInt() == 1;
            entry["temperature"] = hourObj["temp_c"].toDouble();
            entry["conditionText"] = hourObj["condition"].toObject()["text"].toString();
            entry["conditionCode"] = hourObj["condition"].toObject()["code"].toInt();
            entry["time"] = timeStr.split(" ")[1];

            m_forecast.append(entry);
            collected++;
            if (collected == maxForecastEntries)
                break;
        }
        if (collected == maxForecastEntries)
            break;
    }

    // === DAILY SUMMARY FOR NEXT 3 DAYS ===
    m_dailySummary.clear();

    int daysCollected = 0;
    for (const QJsonValue &day : std::as_const(forecastDays)) {
        if (daysCollected == 3)
            break;

        QJsonObject dayObj = day.toObject();
        QJsonObject dayInfo = dayObj["day"].toObject();
        QJsonObject condition = dayInfo["condition"].toObject();

        QVariantMap dailyEntry;
        QString isoDate = dayObj["date"].toString();
        dailyEntry["date"] = getDayNameFromISO(isoDate);
        dailyEntry["maxTemp"] = dayInfo["maxtemp_c"].toDouble();
        dailyEntry["minTemp"] = dayInfo["mintemp_c"].toDouble();
        dailyEntry["conditionText"] = condition["text"].toString();
        dailyEntry["conditionCode"] = condition["code"].toInt();

        m_dailySummary.append(dailyEntry);
        daysCollected++;
    }
    emit weatherUpdated();
    reply->deleteLater();
}

QString WeatherApi::date() const { return m_date; }
double WeatherApi::temperatureC() const { return m_temperatureC; }
QString WeatherApi::weatherCondition() const { return m_weatherCondition; }
int WeatherApi::weatherConditionCode() const { return m_weatherConditionCode; }
double WeatherApi::windSpeedKph() const { return m_windSpeedKph; }
int WeatherApi::cloudCover() const { return m_cloudCover; }
double WeatherApi::pressureMb() const { return m_pressureMb; }
int WeatherApi::humidity() const { return m_humidity; }
bool WeatherApi::isDay() const { return m_isDay; }

QVariantList WeatherApi::forecast() const {
    return m_forecast;
}
QList<QVariantMap> WeatherApi::dailySummary() const {
    return m_dailySummary;
}
