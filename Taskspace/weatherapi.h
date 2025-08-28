#ifndef WEATHERAPI_H
#define WEATHERAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
class WeatherApi : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString date READ date NOTIFY weatherUpdated)
    Q_PROPERTY(double temperatureC READ temperatureC NOTIFY weatherUpdated)
    Q_PROPERTY(QString weatherCondition READ weatherCondition NOTIFY weatherUpdated)
    Q_PROPERTY(int weatherConditionCode READ weatherConditionCode NOTIFY weatherUpdated)
    Q_PROPERTY(double windSpeedKph READ windSpeedKph NOTIFY weatherUpdated)
    Q_PROPERTY(int cloudCover READ cloudCover NOTIFY weatherUpdated)
    Q_PROPERTY(double pressureMb READ pressureMb NOTIFY weatherUpdated)
    Q_PROPERTY(int humidity READ humidity NOTIFY weatherUpdated)
    Q_PROPERTY(bool isDay READ isDay NOTIFY weatherUpdated)

    Q_PROPERTY(QVariantList forecast READ forecast NOTIFY forecastUpdated)
    Q_PROPERTY(QList<QVariantMap> dailySummary READ dailySummary NOTIFY forecastUpdated)

public:
    explicit WeatherApi(QObject *parent = nullptr);

    Q_INVOKABLE void fetchWeather(const QString &cityName);
    QString date() const;
    double temperatureC() const;
    QString weatherCondition() const;
    int weatherConditionCode() const;
    double windSpeedKph() const;
    int cloudCover() const;
    double pressureMb() const;
    int humidity() const;
    bool isDay() const;

    QVariantList forecast() const;

    QList<QVariantMap> dailySummary() const;
signals:
    void weatherUpdated();
     void forecastUpdated();
    void errorOccurred(const QString &error);

private:

    QNetworkAccessManager m_manager;
    QString m_date;
    double m_temperatureC = 0.0;
    QString m_weatherCondition;
    int m_weatherConditionCode = 0;
    double m_windSpeedKph = 0.0;
    int m_cloudCover = 0;
    double m_pressureMb = 0.0;
    int m_humidity = 0;
    bool m_isDay = false;

    QVariantList m_forecast;
    QList<QVariantMap> m_dailySummary;

    const QString m_apiKey = "d46ef94d00574c89be171738252407";

private slots:
    void onNetworkReply(QNetworkReply *reply);

};

#endif // WEATHERAPI_H
