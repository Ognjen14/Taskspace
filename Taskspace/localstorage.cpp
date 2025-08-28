#include "localstorage.h"
#include <QJsonArray>
#include <QStandardPaths>
LocalStorage::LocalStorage(QObject *parent) : QObject{parent} {}
QString documentsPath(const QString &fileName) {
  QString baseDir =
      QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
  return QDir(baseDir).filePath(fileName);
}
bool LocalStorage::writeData(const QVariantList &jsonList,
                             const QString &fileName) {
  QString fullPath = documentsPath(fileName);
  QDir().mkpath(QFileInfo(fullPath).path());

  QFile file(fullPath);
  if (!file.open(QIODevice::WriteOnly | QIODevice::Text |
                 QIODevice::Truncate)) {
    qWarning("JsonStorage: Unable to open file for writing: %s",
             qPrintable(fullPath));
    return false;
  }

  qDebug() << "JsonStorage: Writing to file:" << fullPath;
  qDebug() << "JsonStorage: Input QVariantList size:" << jsonList.size();

  QJsonArray jsonArray;

  for (int i = 0; i < jsonList.size(); ++i) {
    const QVariant &item = jsonList.at(i);
    if (!item.canConvert<QVariantMap>()) {
      qWarning() << "JsonStorage: Item at index" << i
                 << "is not a QVariantMap:" << item;
      continue;
    }

    QVariantMap map = item.toMap();
    QJsonObject obj = QJsonObject::fromVariantMap(map);
    jsonArray.append(obj);

    qDebug() << "JsonStorage: Converted item at index" << i
             << "to JSON:" << QJsonDocument(obj).toJson(QJsonDocument::Compact);
  }

  QJsonDocument doc(jsonArray);
  QByteArray jsonOutput = doc.toJson(QJsonDocument::Indented);
  file.write(jsonOutput);
  file.close();

  qDebug() << "JsonStorage: Final JSON output:\n" << jsonOutput;

  return true;
}

bool LocalStorage::writeDataMap(const QVariantMap &jsonMap,
                                const QString &fileName) {
  QString fullPath = documentsPath(fileName);
  QDir().mkpath(QFileInfo(fullPath).path());

  QFile file(fullPath);
  if (!file.open(QIODevice::WriteOnly | QIODevice::Text |
                 QIODevice::Truncate)) {
    qWarning("JsonStorage: Unable to open file for writing: %s",
             qPrintable(fullPath));
    return false;
  }

  qDebug() << "JsonStorage: Writing MAP to file:" << fullPath;

  QJsonObject rootObject = QJsonObject::fromVariantMap(jsonMap);
  QJsonDocument doc(rootObject);

  QByteArray jsonOutput = doc.toJson(QJsonDocument::Indented);
  file.write(jsonOutput);
  file.close();

  qDebug() << "JsonStorage: Final JSON output:\n" << jsonOutput;
  return true;
}

QVariantList LocalStorage::readData(const QString &fileName) {

  QString fullPath = documentsPath(fileName);
  QFile file(fullPath);
  QVariantList result;

  if (!file.exists() || !file.open(QIODevice::ReadOnly | QIODevice::Text)) {
    qWarning("JsonStorage: Unable to open file for reading: %s",
             qPrintable(fullPath));
    return result;
  }

  QByteArray data = file.readAll();
  file.close();

  QJsonParseError parseError;
  QJsonDocument doc = QJsonDocument::fromJson(data, &parseError);
  if (parseError.error != QJsonParseError::NoError) {
    qWarning("JsonStorage: JSON parse error in %s: %s", qPrintable(fullPath),
             qPrintable(parseError.errorString()));
    return result;
  }

  if (doc.isArray()) {
    for (const QJsonValue &val : doc.array()) {
      result.append(val.toObject().toVariantMap());
    }
  }

  return result;
}
QVariantMap LocalStorage::readDataMap(const QString &fileName) {
  QString fullPath = documentsPath(fileName);
  QFile file(fullPath);
  QVariantMap result;

  if (!file.exists() || !file.open(QIODevice::ReadOnly | QIODevice::Text)) {
    qWarning("JsonStorage: Unable to open file for reading: %s",
             qPrintable(fullPath));
    return result;
  }

  QByteArray data = file.readAll();
  file.close();

  QJsonParseError parseError;
  QJsonDocument doc = QJsonDocument::fromJson(data, &parseError);
  if (parseError.error != QJsonParseError::NoError) {
    qWarning("JsonStorage: JSON parse error in %s: %s", qPrintable(fullPath),
             qPrintable(parseError.errorString()));
    return result;
  }

  if (doc.isObject()) {
    QJsonObject root = doc.object();
    result = root.toVariantMap();
  } else {
    qWarning("JsonStorage: Expected JSON object in file, but found array.");
  }

  return result;
}
