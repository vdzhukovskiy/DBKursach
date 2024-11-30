#pragma once

#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlTableModel>

#include <memory>

class DbConnector : public QObject
{
    Q_OBJECT
public:
    explicit DbConnector(QObject *parent = nullptr);
    static DbConnector& instance();
    ~DbConnector();

    Q_INVOKABLE QStringList tables();
    Q_INVOKABLE void addDatabase(const QString &hostName, const QString &databaseName, const QString &userName, const QString &password);
    Q_INVOKABLE void registerIncident(const QString &driverName, const QString &busNumber, const QString &date, const QString &description, const QString &severity);
    Q_INVOKABLE QStringList driverNames();
    Q_INVOKABLE void deleteRow(const QString &id, const QString &tableName);
    Q_INVOKABLE void insertRow(const QString &tableName, const QStringList &values);

    QSqlDatabase& getDatabase();

signals:
    void connected();
    void updateTable();

private:
    std::shared_ptr<QSqlDatabase> db_;
};
