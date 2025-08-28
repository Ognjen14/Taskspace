#pragma once

#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QObject>
#include <QVariantMap>

class LocalStorage : public QObject {
  Q_OBJECT
public:
  explicit LocalStorage(QObject *parent = nullptr);

  Q_INVOKABLE bool writeData(const QVariantList &jsonList,
                             const QString &fileName);
  Q_INVOKABLE QVariantList readData(const QString &fileName);

  Q_INVOKABLE bool writeDataMap(const QVariantMap &jsonMap,
                                const QString &fileName);
  Q_INVOKABLE QVariantMap readDataMap(const QString &fileName);
};
